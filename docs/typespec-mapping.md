# TypeSpec ファイルマッピング詳解

このドキュメントでは、TypeSpec ファイル（`.tsp`）がどのように JSON/YAML ファイルに変換されるかを詳細に説明します。

> **Note**: このドキュメントのコードスニペットは、[Step 1: GitHub Issue 検索エージェント](step1.md) のサンプルコードを使用しています。

## ファイル対応表

### 入力ファイル（開発者が編集）

| ファイル | 役割 | 出力先 |
|---------|------|-------|
| `src/agent/main.tsp` | エージェント定義 | `declarativeAgent.json` |
| `src/agent/actions/*.tsp` | API 定義 | `*-apiplugin.json`, `*-openapi.yml` |
| `src/agent/prompts/*.tsp` | 指示定義 | `declarativeAgent.json` の instructions |
| `src/agent/env.tsp` | 環境変数 | 各ファイル内で値として使用 |
| `appPackage/manifest.json` | アプリ基本情報 | `.generated/manifest.json` |

### 出力ファイル（自動生成・編集禁止）

| ファイル | 生成元 | 用途 |
|---------|-------|------|
| `.generated/manifest.json` | manifest.json + TypeSpec | Teams/M365 アプリ定義 |
| `.generated/declarativeAgent.json` | main.tsp + prompts/*.tsp | Copilot エージェント定義 |
| `.generated/*-apiplugin.json` | actions/*.tsp | API Plugin 定義 |
| `.generated/*-openapi.yml` | actions/*.tsp | OpenAPI 仕様 |

---

## デコレータと JSON の対応

### main.tsp → declarativeAgent.json

**入力（TypeSpec）:**

```typespec
// src/agent/main.tsp
@agent("GitHubIssueSearch", "GitHub Issue を検索・表示する Declarative Agent です。")
@instructions(Prompts.INSTRUCTIONS)
@conversationStarter(#{
  title: "GitHub Issue を検索",
  text: "M365 Agents Toolkit の最新の Issue を教えて"
})
@conversationStarter(#{
  title: "オープンな Issue 一覧",
  text: "現在オープンになっている Issue は何件ある？"
})
namespace GitHubIssueSearch {
  op searchIssues is GitHubAPI.searchIssues;
}
```

**出力（JSON）:**

```json
// appPackage/.generated/declarativeAgent.json
{
  "name": "GitHubIssueSearch",
  "description": "GitHub Issue を検索・表示する Declarative Agent です。",
  "instructions": "You are a declarative agent...",
  "conversation_starters": [
    {
      "title": "GitHub Issue を検索",
      "text": "M365 Agents Toolkit の最新の Issue を教えて"
    },
    {
      "title": "オープンな Issue 一覧",
      "text": "現在オープンになっている Issue は何件ある？"
    }
  ],
  "actions": [
    {
      "id": "githubapi",
      "file": "githubapi-apiplugin.json"
    }
  ]
}
```

**マッピング対応:**

| TypeSpec | JSON |
|----------|------|
| `@agent()` 第1引数 | `name` |
| `@agent()` 第2引数 | `description` |
| `@instructions()` | `instructions` |
| `@conversationStarter()` | `conversation_starters[]` |
| `op xxx is YYY.zzz` | `actions[]` |

---

### actions/github.tsp → apiplugin.json + openapi.yml

**入力（TypeSpec）:**

```typespec
// src/agent/actions/github.tsp
@service
@server(Environment.GITHUB_API_URL)
@actions(#{
  nameForHuman: "GitHub",
  descriptionForHuman: "Search open issues on GitHub.",
  descriptionForModel: "Search open issues from GitHub repositories.",
  legalInfoUrl: "https://docs.github.com/...",
  privacyPolicyUrl: "https://docs.github.com/..."
})
namespace GitHubAPI {
  @route("/search/issues")
  @card(#{
    dataPath: "$.items",
    file: "adaptiveCards/searchIssues.json",
    properties: #{
      title: "$.title",
      url: "$.html_url"
    }
  })
  @get op searchIssues(
    @query q: string = "repo:OfficeDev/microsoft-365-agents-toolkit is:issue is:open",
    @query per_page: integer = 5
  ): string;
}
```

**出力1（API Plugin JSON）:**

```json
// appPackage/.generated/githubapi-apiplugin.json
{
  "name_for_human": "GitHub",
  "description_for_human": "Search open issues on GitHub.",
  "description_for_model": "Search open issues from GitHub repositories.",
  "legal_info_url": "https://docs.github.com/...",
  "privacy_policy_url": "https://docs.github.com/...",
  "namespace": "githubapi",
  "functions": [
    {
      "name": "searchIssues",
      "description": "Search open issues from GitHub repositories.",
      "capabilities": {
        "response_semantics": {
          "data_path": "$.items",
          "static_template": { "file": "adaptiveCards/searchIssues.json" }
        }
      }
    }
  ],
  "runtimes": [
    {
      "type": "OpenApi",
      "spec": { "url": "githubapi-openapi.yml" }
    }
  ]
}
```

**出力2（OpenAPI YAML）:**

```yaml
# appPackage/.generated/githubapi-openapi.yml
openapi: 3.0.0
info:
  title: GitHubAPI
servers:
  - url: https://api.github.com
paths:
  /search/issues:
    get:
      operationId: searchIssues
      parameters:
        - name: q
          in: query
          schema:
            type: string
            default: "repo:OfficeDev/microsoft-365-agents-toolkit is:issue is:open"
        - name: per_page
          in: query
          schema:
            type: integer
            default: 5
```

**マッピング対応:**

| TypeSpec | apiplugin.json | openapi.yml |
|----------|---------------|-------------|
| `@actions({ nameForHuman })` | `name_for_human` | - |
| `@actions({ descriptionForModel })` | `description_for_model` | - |
| `namespace GitHubAPI` | `namespace: "githubapi"` | `info.title` |
| `@server(url)` | - | `servers[].url` |
| `@route("/path")` | - | `paths["/path"]` |
| `@get` | - | `get:` |
| `op searchIssues` | `functions[].name` | `operationId` |
| `@query q: string` | - | `parameters[]` |
| `@card({ file })` | `static_template.file` | - |

---

## 図解：データフロー

```
┌─────────────────────────────────────────────────────────────────────┐
│ src/agent/                                                           │
│                                                                      │
│  main.tsp ──────────┬────────────────────────────────────────┐       │
│    │                │                                        │       │
│    │ import         │ @agent, @instructions                  │       │
│    ▼                │ @conversationStarter                   │       │
│  prompts/           │                                        ▼       │
│  instructions.tsp ──┴────────────────────────────────→ declarative   │
│                                                        Agent.json    │
│  actions/                                                            │
│  github.tsp ─────────────────────────────────────────→ apiplugin.json│
│    │                                                   openapi.yml   │
│    │ @server(Environment.GITHUB_API_URL)                            │
│    ▼                                                                 │
│  env.tsp ← env/.env.local                                           │
│    │      (generate:env スクリプト)                                  │
│    │                                                                 │
└────┼────────────────────────────────────────────────────────────────┘
     │
     │ 値の参照
     ▼
┌─────────────────────────────────────────────────────────────────────┐
│ appPackage/                                                          │
│                                                                      │
│  manifest.json ────────────────────────────────────→ .generated/     │
│  (テンプレート)     copilotAgents セクション追加      manifest.json  │
│                                                                      │
│  adaptiveCards/ ───────────────────────────────────→ ZIP に含まれる  │
│  searchIssues.json  (編集可能、TypeSpec では生成されない)            │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘
```

---

## よくある疑問

### Q: なぜ manifest.json が2つあるの？

| ファイル | 役割 |
|---------|------|
| `appPackage/manifest.json` | 開発者が編集する**テンプレート** |
| `appPackage/.generated/manifest.json` | TypeSpec コンパイル後の**最終成果物** |

テンプレートには `copilotAgents` セクションがなく、コンパイル時に TypeSpec から追加されます。

### Q: env.tsp は誰が作るの？

`npm run generate:env` スクリプトが `env/.env.local` から自動生成します。  
Provision ワークフローの Step 3 で実行されます。詳細は [provision.md](provision.md) を参照。

### Q: Adaptive Card はどこで定義する？

TypeSpec ではなく、直接 JSON で定義します：

- **定義場所**: `appPackage/adaptiveCards/*.json`
- **参照方法**: TypeSpec の `@card()` デコレータで `file` を指定

```typespec
@card(#{
  file: "adaptiveCards/searchIssues.json",  // ← ここで参照
  ...
})
```

### Q: 生成されたファイルを編集したらどうなる？

次回の TypeSpec コンパイル（F5 実行や Provision）で**上書きされます**。  
`.generated/` 配下のファイルは編集しないでください。

---

## 関連ドキュメント

- [Provision ワークフロー](provision.md) - コンパイルがいつ実行されるか
- [Step 1: GitHub Issue 検索エージェント](step1.md) - このドキュメントのサンプルコードの出典
- [アーキテクチャ概要](architecture.md) - 全体像
