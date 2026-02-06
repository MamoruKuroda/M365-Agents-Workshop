# Step 3: Email・People・WebSearch Capabilities の追加

## このステップで学ぶこと

- Email Capability でメールを Knowledge として活用
- People Capability で組織の人物情報を参照
- WebSearch Capability で Web 検索を利用
- Instructions によるデータソースの**優先順位**制御

## 前提条件

- Step 2 が完了していること
- Microsoft 365 メールボックスが利用可能であること

## Step 2 との違い

| 項目 | Step 2 | Step 3 |
|------|--------|--------|
| **Knowledge** | SharePoint + Teams | SharePoint + Teams + **Email + People + WebSearch** |
| **Instructions** | 「必ず」「絶対に」で Capabilities の使用を強制 | データソースの**優先順位**を指示 |
| **スコープ指定** | URL で特定サイト/チームに限定 | Email / People / WebSearch は**スコープなし**（全領域対象） |

## 手順

### 3.1 新しい Capabilities の概念

Step 3 で追加する 3 つの Capability：

| Capability | 参照先 | スコープ指定 |
|------------|-------|------------|
| Email | ユーザーのメールボックス | フォルダ指定 or 共有メールボックス指定が可能 |
| People | 組織内の人物情報（ディレクトリ） | スコープ指定なし |
| WebSearch | 公開 Web（Bing） | URL で特定サイトに限定可能（最大4件） |

### 3.2 main.tsp に Capabilities を追加

`src/agent/main.tsp` の namespace 内に以下を追加します（Step 2 の SharePoint / Teams の下に追記）：

```typespec
namespace ProductEngineeringAgent {
  // ... 既存の searchIssues, oneDriveAndSharePoint, teamsMessages ...

  // 新規: Email Capability
  op email is AgentCapabilities.Email;

  // 新規: People Capability
  op people is AgentCapabilities.People;

  // 新規: WebSearch Capability
  op webSearch is AgentCapabilities.WebSearch;
}
```

> ⚠️ **スコープなし**の場合、ユーザーがアクセス可能な全領域が対象になります。

### 3.3 スコープ指定のオプション（任意）

必要に応じてスコープを指定できます：

#### Email のスコープ指定

```typespec
// 特定フォルダに限定
op email is AgentCapabilities.Email<Folders = [
  { folder_id: "Inbox" },
  { folder_id: "SentItems" }
]>;

// 共有メールボックスに限定
op email is AgentCapabilities.Email<SharedMailbox = "support@contoso.com">;
```

#### WebSearch のスコープ指定

```typespec
// 特定サイトに限定（最大4件）
op webSearch is AgentCapabilities.WebSearch<TSites = [
  { url: "https://learn.microsoft.com" },
  { url: "https://typespec.io" }
]>;
```

### 3.4 Instructions の強化：データソースの優先順位

Step 3 の重要なポイントは、**データソースの優先順位を指示する**ことです。

`src/agent/prompts/instructions.tsp` を編集します：

```typespec
namespace Prompts {
  const INSTRUCTIONS = """
    ...

    ## Data Source Priority

    When answering questions, **ALWAYS** follow this priority order:
    1. **First**: Search SharePoint and Teams for internal documents and discussions.
    2. **Second**: Search Email for relevant correspondence if internal documents are insufficient.
    3. **Third**: Use People to find contact information or organizational details.
    4. **Last resort**: Use Web Search only when internal data sources cannot answer the question.

    ## IMPORTANT Guidelines

    - **NEVER** use Web Search when the question can be answered from internal data sources.
    - When asked about communications, **ALWAYS** search Email.
    - When asked about people or contacts, **ALWAYS** use People.
    - When using Web Search, **ALWAYS** cite the source URL.
    ...
  """;
}
```

> 💡 **ポイント**: 
> - WebSearch は便利ですが、社内データを優先させる指示が重要です。
> - 「優先順位」を明示することで、LLM が適切なデータソースを選択しやすくなります。

### 3.5 Conversation Starters の追加

新しい Capabilities に対応する Conversation Starters を追加します：

```typespec
@conversationStarter(#{
  title: "メールを検索",
  text: "最近届いたプロジェクト関連のメールを教えて"
})
@conversationStarter(#{
  title: "担当者を探す",
  text: "このプロジェクトの担当者は誰？"
})
@conversationStarter(#{
  title: "最新技術を調べる",
  text: "TypeSpec の最新情報を Web で調べて"
})
```

### 3.6 Provision と動作確認

1. F5 キーで Provision を実行
2. `-developer on` で Developer Mode を有効化
3. 以下の質問で各 Capability の動作を確認：

| Capability | 確認用プロンプト |
|------------|---------------|
| Email | 「最近届いたプロジェクト関連のメールを教えて」 |
| People | 「このプロジェクトの担当者は誰？」 |
| WebSearch | 「TypeSpec の最新情報を Web で調べて」 |

## 動作確認のポイント

### Developer Mode でのデバッグカード

`-developer on` で表示されるデバッグカードで以下を確認：

- **実行された機能**: Email, People, WebSearch が Success ✅ になっているか
- **アクション**: searchIssues が必要に応じて呼ばれているか
- **参照元**: 回答のソースが適切か（社内データ優先になっているか）

### 優先順位の確認方法

1. 社内情報に関する質問 → SharePoint/Teams/Email が使われ、WebSearch が使われていないこと
2. 外部情報の質問 → WebSearch が使われること
3. 人物に関する質問 → People が使われること

## トラブルシューティング

### Email Capability が動作しない

| 原因 | 対策 |
|------|------|
| メールボックスが空 | テスト用のメールを送受信 |
| ライセンス不足 | Exchange Online ライセンスを確認 |
| Instructions が不十分 | 「メールを検索して」と明示的に指示 |

### People Capability が動作しない

| 原因 | 対策 |
|------|------|
| ディレクトリに情報がない | Azure AD にユーザー情報が登録されているか確認 |
| Instructions が不十分 | 「担当者を教えて」「組織図を教えて」と明示的に指示 |

### WebSearch の結果が不適切

| 原因 | 対策 |
|------|------|
| 社内情報なのに WebSearch が使われる | Instructions の優先順位を強化 |
| 信頼性の低いソース | WebSearch のスコープを信頼できるサイトに限定 |

## 完了チェックリスト

- [ ] Email Capability が追加されている
- [ ] People Capability が追加されている
- [ ] WebSearch Capability が追加されている
- [ ] Instructions にデータソースの優先順位が定義されている
- [ ] メールの検索ができる
- [ ] 人物情報の検索ができる
- [ ] Web 検索ができる
- [ ] 社内データが優先されている（WebSearch は最後の手段）

## 答え合わせ

実装に困った場合は、`step-3-extend-knowledge` ブランチを参照してください：

```bash
git fetch origin
git checkout step-3-extend-knowledge
```

## 次のステップ

[Step 4: 全機能統合](step4.md)
