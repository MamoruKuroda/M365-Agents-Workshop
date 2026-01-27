# Microsoft 365向けTypeSpec宣言型エージェントテンプレートの概要

宣言型エージェントを使用すると、特定のシナリオに特化したCopilotのカスタムバージョンを構築できます。例えば、専門知識の活用、特定のプロセスの実装、またはAIプロンプトのセットを再利用することで時間を節約することが可能です。具体例として、食料品ショッピングCopilot宣言型エージェントでは、Copilotに送信した食事プランに基づいて買い物リストを作成できます。

## テンプレートを始める

> **前提条件**
>
> このアプリテンプレートをローカル開発環境で実行するには、以下が必要です：
>
> - [Node.js](https://nodejs.org/)（サポートバージョン：18、20、22）
> - [開発用Microsoft 365アカウント](https://docs.microsoft.com/microsoftteams/platform/toolkit/accounts)
> - [Microsoft 365 Agents Toolkit Visual Studio Code拡張機能](https://aka.ms/teams-toolkit) バージョン5.0.0以上、または [Microsoft 365 Agents Toolkit CLI](https://aka.ms/teamsfx-toolkit-cli)
> - [Microsoft 365 Copilotライセンス](https://learn.microsoft.com/microsoft-365-copilot/extensibility/prerequisites#prerequisites)

![image](./assets/image.png)

1. まず、VS Codeツールバーの左側にあるMicrosoft 365 Agents Toolkitアイコンを選択します。
2. Accountセクションで、まだサインインしていない場合は、[Microsoft 365アカウント](https://docs.microsoft.com/microsoftteams/platform/toolkit/accounts)でサインインします。
3. TypeSpecファイルを操作する前に、`npm install`を実行して依存関係をインストールします。
4. [`main.tsp`](./main.tsp)を更新して、エージェントとそのプラグインを構成します。これはTypeSpecファイルのデフォルトのエントリーポイントです。
5. 起動構成ドロップダウンから`Preview Local in Copilot (Edge)`または`Preview Local in Copilot (Chrome)`を選択します。
6. `Copilot`アプリから宣言型エージェントを選択します。
7. 宣言型エージェントに質問すると、提供された指示に基づいて応答します。

## テンプレートに含まれるもの

| フォルダ             | 内容                                                                                     |
| -------------------- | ---------------------------------------------------------------------------------------- |
| `.vscode`            | デバッグ用のVSCodeファイル                                                               |
| `appPackage`         | アプリケーションマニフェスト、マニフェスト、API仕様のテンプレート                       |
| `src/agent/actions`  | APIサーフェスを表すすべてのアクションファイル                                            |
| `env`                | 環境ファイル                                                                             |
| `src/agent/prompts`  | 指示に使用されるすべてのプロンプトファイル                                               |
| `scripts`            | ビルドプロセス全体の自動化を支援するスクリプト                                           |

以下のファイルはカスタマイズ可能で、開始するための実装例を示しています。

| ファイル                           | 内容                                                                         |
| ---------------------------------- | ---------------------------------------------------------------------------- |
| `appPackage/manifest.json`         | 宣言型エージェントのメタデータを定義するアプリケーションマニフェスト         |

以下はMicrosoft 365 Agents Toolkit固有のプロジェクトファイルです。Microsoft 365 Agents Toolkitの仕組みを理解するには、[Githubの完全なガイド](https://github.com/OfficeDev/TeamsFx/wiki/Teams-Toolkit-Visual-Studio-Code-v5-Guide#overview)をご覧ください。

| ファイル         | 内容                                                                                                                                      |
| ---------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| `m365agents.yml` | これはMicrosoft 365 Agents Toolkitのメインプロジェクトファイルです。プロジェクトファイルでは、主にプロパティと構成ステージ定義の2つを定義します。 |

以下はTypeSpecテンプレートファイルです。エージェントを構成するには、これらのファイルをカスタマイズする必要があります。

| ファイル                  | 内容                                                                                    |
| ------------------------- | --------------------------------------------------------------------------------------- |
| `src/agent/main.tsp`      | TSPファイルのルートファイルです。独自のエージェントを追加するには、このファイルを手動で更新してください。 |
| `src/agent/actions/*.tsp` | 宣言型エージェントを拡張するAPIエンドポイントを含むアクションファイルです。             |
| `src/agent/prompts/*.tsp` | 宣言型エージェントの指示に使用されるプロンプトファイルです。                            |
| `src/agent/env.tsp`       | TypeSpecファイルで使用されるすべての環境変数を含むファイルです。                        |

## テンプレートを拡張する

- [指示を追加する](https://learn.microsoft.com/ja-jp/microsoft-365-copilot/extensibility/build-declarative-agents-typespec#add-instructions)：指示によりエージェントの動作を変更できます。
- [会話スターターを追加する](https://learn.microsoft.com/ja-jp/microsoft-365-copilot/extensibility/build-declarative-agents-typespec#add-conversation-starters)：会話スターターは、ユーザーに宣言型エージェントの使い始め方を示すヒントとして表示されます。
- [Webコンテンツを追加する](https://learn.microsoft.com/ja-jp/microsoft-365-copilot/extensibility/build-declarative-agents-typespec#add-web-content)：Web検索機能により、エージェントはBingの検索インデックスを使用してユーザープロンプトに応答できます。
- [OneDriveとSharePointコンテンツを追加する](https://learn.microsoft.com/ja-jp/microsoft-365-copilot/extensibility/build-declarative-agents-typespec#add-onedrive-and-sharepoint-content)：エージェントのグラウンディング知識として活用できます。
- [Teamsメッセージを追加する](https://learn.microsoft.com/ja-jp/microsoft-365-copilot/extensibility/build-declarative-agents-typespec#add-teams-messages)：Teamsメッセージ機能により、エージェントはTeamsチャネル、チーム、会議チャットを知識として使用できます。
- [人物知識を追加する](https://learn.microsoft.com/ja-jp/microsoft-365-copilot/extensibility/build-declarative-agents-typespec#add-people-knowledge)：人物機能により、組織内の個人に関する質問に答えるようにエージェントをスコープできます。
- [メール知識を追加する](https://learn.microsoft.com/ja-jp/microsoft-365-copilot/extensibility/build-declarative-agents-typespec#add-email-knowledge)：メール機能により、ユーザーのメールボックスまたは共有メールボックスからのメールを知識ソースとして使用するようにエージェントをスコープできます。
- [画像生成機能を追加する](https://learn.microsoft.com/ja-jp/microsoft-365-copilot/extensibility/build-declarative-agents-typespec#add-image-generator)：画像生成機能により、エージェントはユーザープロンプトに基づいて画像を生成できます。
- [コードインタープリターを追加する](https://learn.microsoft.com/ja-jp/microsoft-365-copilot/extensibility/build-declarative-agents-typespec#add-code-interpreter)：コードインタープリター機能は、Pythonコードを介して複雑なタスクを解決するために設計された高度なツールです。
- [Copilot Connectorsコンテンツを追加する](https://learn.microsoft.com/ja-jp/microsoft-365-copilot/extensibility/build-declarative-agents-typespec#add-copilot-connectors-content)：Copilotコネクタによって取り込まれたアイテムを、エージェントの利用可能な知識に追加できます。
- [アクションを追加する](https://learn.microsoft.com/ja-jp/microsoft-365-copilot/extensibility/build-api-plugins-typespec)：APIプラグインは、REST APIとOpenAPI仕様をMicrosoft 365 Copilotに接続する、宣言型エージェント用のカスタムアクションです。

## 追加情報とリファレンス

- [Microsoft 365向け宣言型エージェント](https://aka.ms/teams-toolkit-declarative-agent)

---

## セットアップとデプロイの詳細手順

このセクションでは、プロジェクトのセットアップから動作確認まで、段階的に説明します。

### 1. 事前条件チェック

プロジェクト作成前に、以下の条件を満たしていることを確認してください。

#### **必須要件**

- ✅ **Microsoft 365 Copilot** が組織で利用可能であること
- ✅ **Visual Studio Code** がインストールされていること
- ✅ **Microsoft 365 Agents Toolkit（VS Code 拡張）** がインストールされていること
  - [インストールガイド](https://learn.microsoft.com/microsoft-365-copilot/extensibility/prerequisites)
- ✅ **Node.js**（バージョン18、20、または22）がインストールされていること

#### **Teamsでのカスタムアプリアップロード許可**

Teams へのサイドロード/配布をする場合は、以下の設定が必要です：

- Teams 管理センターで「カスタムアプリのアップロードを許可する」が有効になっていること
- [Teams ポリシー設定ガイド](https://learn.microsoft.com/microsoftteams/teams-custom-app-policies-and-settings)
- [カスタムアプリのアップロード手順](https://learn.microsoft.com/microsoftteams/platform/concepts/build-and-test/prepare-your-o365-tenant)

#### **その他のホストアプリケーション**

Declarative agent は以下のアプリケーションでもサポートされています：

- Microsoft Word
- Microsoft PowerPoint
- [Word での検証ガイド](https://learn.microsoft.com/microsoft-365-copilot/extensibility/overview-declarative-agent)

#### **環境確認コマンド**

以下のコマンドで必要なツールがインストールされているか確認できます：

```powershell
# Node.js のバージョン確認
node --version
npm --version

# VS Code のバージョン確認
code --version

# Microsoft 365 Agents Toolkit がインストールされているか確認
code --list-extensions | Select-String "TeamsDevApp"
```

**Node.js がインストールされていない場合：**

```powershell
# winget を使用（Windows 10/11 推奨）
winget install OpenJS.NodeJS.LTS

# または Chocolatey を使用
choco install nodejs-lts -y

# または Scoop を使用
scoop install nodejs-lts
```

インストール後は **PowerShell を再起動** してください。

---

### 2. プロジェクト作成（Declarative Agent + TypeSpec）

以下の手順で新しい宣言型エージェントプロジェクトを作成します。

#### **作成手順**

1. **VS Code を開く**
2. **Microsoft 365 Agents Toolkit** アイコンをクリック（左サイドバー）
3. **Create a New Agent/App** を選択
4. **Declarative Agent** を選択
5. **Start with TypeSpec for Microsoft 365 Copilot** を選択
6. 保存先フォルダを選択（例: Default folder）
7. **Application Name** に `SupportTicketAgent` を入力して Enter
8. 新しい VS Code ウィンドウが自動的に開きます

参考: [プロジェクト作成ガイド](https://learn.microsoft.com/microsoft-365-copilot/extensibility/build-declarative-agents-typespec)

---

### 3. 依存関係のインストール

プロジェクトが作成されたら、必要なパッケージをインストールします。

#### **自動インストール**

通常、プロジェクト作成時に自動的に `npm install` が実行されますが、エラーが発生した場合は手動で実行してください：

```powershell
# プロジェクトディレクトリに移動
cd SupportTicketAgent

# 依存関係をインストール
npm install
```

#### **TypeSpec パッケージの追加インストール（必要に応じて）**

開発中に追加のTypeSpecパッケージが必要な場合：

```powershell
# TypeSpec Compiler と関連パッケージをローカルにインストール
npm install -D @typespec/compiler @microsoft/typespec-m365-copilot

# HTTP/REST/OpenAPI サポートを追加
npm install -D @typespec/openapi@latest @typespec/http@latest @typespec/rest@latest @typespec/openapi3@latest

# または、全てまとめてインストール
npm install -D @typespec/compiler@latest @typespec/openapi@latest @typespec/http@latest @typespec/rest@latest @typespec/openapi3@latest @microsoft/typespec-m365-copilot@latest
```

**依存関係の競合エラーが発生した場合：**

```powershell
# --legacy-peer-deps オプションを使用
npm install -D @typespec/http @typespec/rest @typespec/openapi3 --legacy-peer-deps
```

#### **インストール確認**

```powershell
# インストールされたパッケージを確認
npm list --depth=0

# TypeSpec パッケージのみ表示
npm list --depth=0 | Select-String "@typespec"
```

---

### 4. Provision の実行

#### **Provision とは？**

**Provision（プロビジョニング）** は、エージェントを実際に動作させるために必要なリソースと設定を自動的に準備するプロセスです。

**具体的に行われる処理：**

1. **Azure/Microsoft 365 リソースの作成**
   - アプリケーション ID の生成
   - Microsoft Entra ID（旧Azure AD）へのアプリ登録
   - 必要な API 権限の設定

2. **TypeSpec のコンパイル**
   - `.tsp` ファイルから OpenAPI 仕様書を生成
   - `appPackage/manifest.json` の生成・更新
   - アプリパッケージの構成

3. **環境変数の設定**
   - `env/.env.local` ファイルの生成
   - アプリ ID、テナント ID などの保存

4. **Microsoft 365 環境への登録**
   - Teams App Catalog への登録準備
   - Copilot での利用を可能にする

**なぜ Provision が必要？**

TypeSpec で定義したエージェント設定を、実際に Microsoft 365 Copilot で動作する形式に変換し、必要なクラウドリソースを作成するためです。この手順なしでは、エージェントは動作しません。

---

#### **Provision の技術的な詳細と必要性**

Declarative Agent が Microsoft 365 Copilot で動作するためには、複数の技術的なコンポーネントが連携する必要があります。Provision はこれらを自動的に構成します。

##### **1. TypeSpec から実行可能な形式への変換プロセス**

**TypeSpec ファイルの役割:**

TypeSpec (`.tsp`) は、エージェントの**宣言的な定義**を記述するための言語です。しかし、Microsoft 365 Copilot はTypeSpecを直接実行できません。

```
src/agent/main.tsp (人間が書くコード)
   ↓ コンパイル
appPackage/manifest.json (Copilot が読む形式)
appPackage/apiSpecificationFile/*.json (OpenAPI 仕様)
```

**変換される内容:**

| TypeSpec の要素 | 変換後の形式 | 技術的な役割 |
|----------------|-------------|-------------|
| `@agent()` デコレータ | `manifest.json` の `copilotExtensions.declarativeAgents[]` | エージェントのメタデータ定義 |
| `@instructions()` | `instructions` フィールド | Copilot の LLM に渡されるプロンプト |
| `@conversationStarter()` | `conversationStarters[]` | UI に表示される推奨質問 |
| `@actions()` で定義したAPI | OpenAPI 3.0 仕様書 | Copilot が呼び出せる関数の定義 |
| `op getPolicies()` などの操作 | OpenAPI の `paths` と `operations` | 具体的な API エンドポイント |
| TypeSpec のモデル定義 | OpenAPI の `components/schemas` | リクエスト/レスポンスの型定義 |

**技術的な理由:**

- Microsoft 365 Copilot のオーケストレーションエンジンは **Teams App Manifest v1.17+** の形式を期待します
- API プラグイン機能は **OpenAPI 3.0 仕様書**を使用して関数呼び出しを行います
- TypeSpec は型安全な記述を提供しますが、ランタイムでは標準化された形式が必要です

---

##### **2. Microsoft Entra ID（Azure AD）アプリ登録の必要性**

**なぜアプリ登録が必要？**

Microsoft 365 Copilot は、セキュリティとアクセス制御のために、すべてのエージェントを**信頼されたアプリケーション**として認識する必要があります。

**アプリ登録で設定される内容:**

```
Microsoft Entra ID (旧 Azure AD)
└─ アプリの登録
    ├─ アプリケーション（クライアント）ID
    │   → エージェントの一意の識別子
    │   → manifest.json の "id" フィールドに使用
    │
    ├─ ディレクトリ（テナント）ID
    │   → 組織の識別子
    │   → マルチテナント vs シングルテナントの制御
    │
    ├─ API のアクセス許可
    │   → Microsoft Graph API への権限
    │   → User.Read, Files.Read.All など
    │   → エージェントが実行できる操作の範囲を定義
    │
    ├─ 認証設定
    │   → リダイレクト URI
    │   → 暗黙的フローの設定
    │   → OAuth 2.0 フロー
    │
    └─ 証明書とシークレット
        → クライアントシークレット（省略可）
        → API 認証に使用
```

**OAuth 2.0 認証フロー:**

```
ユーザーが Copilot でエージェントを使用
   ↓
Copilot がアプリ ID を確認
   ↓
Microsoft Entra ID で認証
   ↓
アクセストークンを取得
   ↓
トークンを使用して API を呼び出し
   ↓
エージェントがアクション（API Plugin）を実行
```

**技術的な理由:**

- **セキュリティ**: 未承認のエージェントが組織のデータにアクセスするのを防ぐ
- **権限管理**: 最小権限の原則（Principle of Least Privilege）を実装
- **監査**: すべてのエージェントアクティビティをログに記録可能
- **マルチテナント対応**: 組織間でのエージェント共有を制御

---

##### **3. Teams App Manifest の役割と Copilot の統合**

**Teams App Manifest とは？**

`appPackage/manifest.json` は、Microsoft Teams プラットフォームの**アプリケーション記述子**です。Declarative Agent は Teams アプリの一種として実装されています。

**Manifest の主要セクション:**

```json
{
  "$schema": "https://developer.microsoft.com/json-schemas/teams/v1.17/MicrosoftTeams.schema.json",
  "manifestVersion": "1.17",
  "id": "<TEAMS_APP_ID>",
  "version": "1.0.0",
  "name": {
    "short": "SupportTicketAgent",
    "full": "Support Ticket Agent"
  },
  "description": {
    "short": "エージェントの短い説明",
    "full": "エージェントの詳細な説明"
  },
  "icons": {
    "color": "color.png",
    "outline": "outline.png"
  },
  "copilotExtensions": {
    "declarativeAgents": [
      {
        "id": "agent1",
        "file": "declarativeAgent.json"
      }
    ]
  }
}
```

**declarativeAgent.json の構造:**

```json
{
  "id": "SupportTicketAgent",
  "name": "Support Ticket Agent",
  "description": "サポートチケット管理エージェント",
  "instructions": "ユーザーの質問に基づいて...",
  "conversationStarters": [
    {
      "title": "チケットを検索",
      "text": "サポートチケットを検索して"
    }
  ],
  "capabilities": [
    {
      "name": "WebSearch"
    },
    {
      "name": "OneDriveAndSharePoint",
      "items_by_url": [
        {
          "url": "https://contoso.sharepoint.com/..."
        }
      ]
    }
  ],
  "actions": [
    {
      "id": "getIssues",
      "file": "getIssues.json"
    }
  ]
}
```

**技術的な統合ポイント:**

```
Microsoft 365 Copilot
   ↓ (1) マニフェストを読み込み
Teams App Catalog
   ↓ (2) エージェント定義を取得
declarativeAgent.json
   ↓ (3) 指示（instructions）を LLM に渡す
Large Language Model (GPT-4 など)
   ↓ (4) ユーザーの質問を解釈
   ↓ (5) 必要なアクションを判断
API Plugin (OpenAPI 仕様)
   ↓ (6) API を呼び出し
外部サービス / Microsoft Graph
   ↓ (7) 結果を取得
   ↓ (8) LLM が応答を生成
ユーザーに結果を表示
```

**なぜこの形式が必要？**

- **プラットフォーム統合**: Teams、Word、PowerPoint など複数のホストアプリで動作
- **拡張性**: 将来的な機能追加に対応（新しい capability など）
- **バージョン管理**: スキーマバージョンで互換性を保証
- **配布**: Teams App Store や組織内カタログでの配布をサポート

---

##### **4. OpenAPI 仕様と API Plugin の関係**

**API Plugin とは？**

Declarative Agent が外部 API を呼び出すための仕組みです。OpenAPI 3.0 仕様書で記述されます。

**TypeSpec から OpenAPI への変換:**

```typespec
// src/agent/actions/github.tsp
namespace GitHubAPI {
  @route("/repos/{owner}/{repo}/issues")
  @get
  op getIssues(
    @path owner: string,
    @path repo: string,
    @query state?: "open" | "closed" | "all"
  ): Issue[];
}
```

↓ コンパイル後

```json
// appPackage/apiSpecificationFile/github.json
{
  "openapi": "3.0.0",
  "info": {
    "title": "GitHub API",
    "version": "1.0.0"
  },
  "paths": {
    "/repos/{owner}/{repo}/issues": {
      "get": {
        "operationId": "getIssues",
        "parameters": [
          {
            "name": "owner",
            "in": "path",
            "required": true,
            "schema": { "type": "string" }
          },
          {
            "name": "repo",
            "in": "path",
            "required": true,
            "schema": { "type": "string" }
          },
          {
            "name": "state",
            "in": "query",
            "required": false,
            "schema": {
              "type": "string",
              "enum": ["open", "closed", "all"]
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Success",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": { "$ref": "#/components/schemas/Issue" }
                }
              }
            }
          }
        }
      }
    }
  }
}
```

**Copilot の LLM がどのように使用するか:**

1. **関数認識**: LLM は OpenAPI の `operationId` と `description` を読み、どんな関数が利用可能かを理解
2. **パラメータ抽出**: ユーザーの自然言語から必要なパラメータを抽出
   - "microsoft/TypeSpec リポジトリの open issues を見せて"
   - → `owner: "microsoft"`, `repo: "TypeSpec"`, `state: "open"`
3. **関数呼び出し**: Copilot のオーケストレーターが実際の HTTP リクエストを構築
4. **レスポンス処理**: 返ってきた JSON を LLM が解釈し、自然言語で応答

**技術的な利点:**

- **標準化**: OpenAPI は業界標準で、既存の API をそのまま利用可能
- **型安全性**: スキーマ定義により、不正なデータのやり取りを防止
- **自動生成**: TypeSpec から自動生成されるため、手動でのエラーを削減
- **LLM 最適化**: `description`, `summary` フィールドで LLM の理解を助ける

---

##### **5. 環境変数とシークレット管理**

**env/.env.local ファイルの重要性:**

Provision で生成される環境変数は、ランタイムでの動的な設定に使用されます。

```bash
# env/.env.local の例
TEAMS_APP_ID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
M365_CLIENT_ID=yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy
M365_TENANT_ID=zzzzzzzz-zzzz-zzzz-zzzz-zzzzzzzzzzzz
GITHUB_API_ENDPOINT=https://api.github.com
GITHUB_TOKEN=ghp_xxxxxxxxxxxxxxxxxxxx
```

**src/agent/env.tsp への反映:**

```typespec
// 自動生成される env.tsp
namespace Environment {
  const TEAMS_APP_ID = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx";
  const M365_CLIENT_ID = "yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy";
  const GITHUB_API_ENDPOINT = "https://api.github.com";
}
```

**TypeSpec での使用:**

```typespec
@server(Environment.GITHUB_API_ENDPOINT, "GitHub API")
@useAuth(BearerAuth)
namespace GitHubAPI {
  // ...
}
```

**技術的な理由:**

- **環境分離**: local, dev, prod で異なる設定を使用
- **セキュリティ**: シークレットをコードから分離
- **柔軟性**: デプロイ先に応じた動的な構成
- **チーム開発**: 各開発者が独自の設定を持てる

---

##### **6. Copilot のオーケストレーションアーキテクチャ**

**Copilot がエージェントを実行する流れ:**

```
[ユーザー] "GitHub の TypeSpec リポジトリの open issues を教えて"
   ↓
[Copilot UI] ユーザー入力を受信
   ↓
[Microsoft 365 Copilot Service]
   ├─ Teams App Catalog からエージェント定義を取得
   ├─ manifest.json を読み込み
   └─ declarativeAgent.json を取得
   ↓
[Orchestrator]
   ├─ instructions を LLM のシステムプロンプトに設定
   ├─ 利用可能な capabilities と actions を確認
   └─ ユーザーの質問と合わせて LLM に送信
   ↓
[Large Language Model (GPT-4)]
   ├─ instructions に基づいて応答を計画
   ├─ 必要なアクションを判断: getIssues を呼び出すべき
   └─ 関数呼び出しリクエストを生成
   ↓
[Function Calling Engine]
   ├─ OpenAPI 仕様から getIssues の定義を取得
   ├─ パラメータを抽出: owner="microsoft", repo="TypeSpec", state="open"
   ├─ HTTP リクエストを構築
   └─ GitHub API に送信
   ↓
[GitHub API] レスポンス返却
   ↓
[LLM] レスポンスを解釈して自然言語で整形
   ↓
[Copilot UI] ユーザーに結果を表示
```

**各コンポーネントの依存関係:**

```
Provision が作成/設定するもの          Copilot が実行時に必要とするもの
================================      ================================
manifest.json                    →    アプリの識別と読み込み
declarativeAgent.json            →    エージェントの動作定義
OpenAPI 仕様書                   →    関数呼び出しの仕様
Entra ID アプリ登録              →    認証とアクセス制御
環境変数 (.env.local)            →    API エンドポイントと認証情報
```

**技術的な必須要件:**

- **マニフェストスキーマバージョン**: v1.17 以上（Copilot 拡張サポート）
- **GUID の一意性**: TEAMS_APP_ID はグローバルに一意
- **OAuth スコープ**: Entra ID で設定された権限範囲
- **OpenAPI 互換性**: 3.0.x（2.0 はサポート外）
- **HTTPS エンドポイント**: 本番環境では必須（セキュリティ）

---

##### **7. まとめ: Provision がなければ動かない理由**

| コンポーネント | Provision なし | Provision あり |
|--------------|---------------|---------------|
| **TypeSpec ファイル** | 人間が読める定義のみ | OpenAPI 仕様に変換済み |
| **マニフェスト** | 存在しない | Copilot が読める形式で生成 |
| **アプリ ID** | なし | Entra ID に登録済み |
| **認証** | 不可能 | OAuth フロー構成済み |
| **API 権限** | 未設定 | 必要な権限が付与済み |
| **環境変数** | ハードコード | 環境ごとに動的設定 |
| **Teams 統合** | 認識されない | カタログに登録可能 |

**結論:**

Provision は、単なる「ビルド」ではなく、**Microsoft 365 エコシステム全体へのエージェント登録と構成**を行う重要なプロセスです。TypeSpec という開発者フレンドリーな言語で書かれた定義を、Copilot が理解・実行できる複数の技術的コンポーネント（マニフェスト、OpenAPI、OAuth アプリ、環境設定）に変換し、それらを統合的にデプロイします。

この変換と登録なしでは、Copilot のオーケストレーションエンジンはエージェントを認識できず、LLM は関数を呼び出せず、認証も失敗します。つまり、**Provision は Declarative Agent のライフサイクルにおいて不可欠なステップ**です。

#### **Provision の実行方法**

**UI から実行（推奨）:**

1. 左サイドバーの **Microsoft 365 Agents Toolkit** アイコンをクリック
2. **LIFECYCLE** セクションを展開
3. **Provision** をクリック
4. 環境を選択: **local**（初回は必ず local）
5. プロンプトが表示されたら Microsoft 365 アカウントでサインイン
6. 処理が完了するまで待機（通常 1-3 分）

**コマンドラインから実行:**

```powershell
# タスクから実行（推奨）
# VS Code: Ctrl+Shift+P → "Tasks: Run Task" → "Create resources"

# または直接実行
npx teamsfx provision --env local
```

#### **Provision の実行タイミング**

以下の場合に Provision を実行する必要があります：

- ✅ プロジェクトを初めて作成した後（必須）
- ✅ TypeSpec ファイル（`.tsp`）を編集した後
- ✅ エージェントの名前や説明を変更した後
- ✅ 新しいアクションや機能を追加した後
- ✅ 環境を切り替える時（local → dev → prod）

💡 **基本的な開発ループ:**
```
TypeSpec ファイル編集
   ↓
Provision 実行
   ↓
UI で確認・テスト
   ↓
（繰り返し）
```

参考: [Provision の詳細](https://learn.microsoft.com/microsoft-365-copilot/extensibility/build-declarative-agents-typespec#provision-the-declarative-agent)

---

### 5. 動作確認とテスト

Provision が成功したら、複数の方法で動作を確認します。

#### **5.1 ローカルファイルでの確認**

**確認すべきファイル:**

```powershell
# ファイルの存在確認
Test-Path "env\.env.local"          # True であれば成功
Test-Path "appPackage\manifest.json" # True であれば成功
Test-Path "src\agent\env.tsp"        # True であれば成功
```

**環境変数の確認:**

```powershell
# .env.local の内容を表示
cat env\.env.local

# 以下のような変数が設定されていることを確認:
# TEAMS_APP_ID=...
# M365_CLIENT_ID=...
# M365_TENANT_ID=...
```

**マニフェストの確認:**

```powershell
# manifest.json の主要情報を確認
cat appPackage\manifest.json | ConvertFrom-Json | Select-Object id, name, version
```

**包括的な確認スクリプト:**

```powershell
Write-Host "`n=== Provision Status Check ===" -ForegroundColor Cyan

# ファイルチェック
Write-Host "`n[ファイル確認]" -ForegroundColor Yellow
@("env\.env.local", "appPackage\manifest.json", "src\agent\env.tsp") | ForEach-Object {
    if (Test-Path $_) {
        Write-Host "  ✓ $_ - 存在" -ForegroundColor Green
    } else {
        Write-Host "  ✗ $_ - 見つかりません" -ForegroundColor Red
    }
}

# 環境変数チェック
Write-Host "`n[環境変数確認]" -ForegroundColor Yellow
if (Test-Path "env\.env.local") {
    $content = Get-Content "env\.env.local" -Raw
    @("TEAMS_APP_ID", "M365_CLIENT_ID", "M365_TENANT_ID") | ForEach-Object {
        if ($content -match $_) {
            Write-Host "  ✓ $_ 設定済み" -ForegroundColor Green
        } else {
            Write-Host "  ✗ $_ 未設定" -ForegroundColor Red
        }
    }
}

# TypeSpec コンパイルチェック
Write-Host "`n[TypeSpec コンパイル]" -ForegroundColor Yellow
npx tsp compile . --no-emit 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) {
    Write-Host "  ✓ コンパイル成功" -ForegroundColor Green
} else {
    Write-Host "  ✗ コンパイルエラー" -ForegroundColor Red
    Write-Host "  詳細確認: npx tsp compile ." -ForegroundColor Yellow
}

Write-Host "`n=== Check Complete ===" -ForegroundColor Cyan
```

---

#### **5.2 VS Code での確認**

**Microsoft 365 Agents Toolkit パネルでの確認:**

1. 左サイドバーの **Microsoft 365 Agents Toolkit** アイコンをクリック
2. **LIFECYCLE** セクションを確認
   - Provision の横に ✅ マークが表示されていれば成功
3. **OUTPUT** パネルを確認（画面下部）
   - ドロップダウンから **Microsoft 365 Agents Toolkit** を選択
   - "Successfully provisioned" などのメッセージを確認

**ローカルプレビューの起動:**

1. VS Code のデバッグパネルを開く（Ctrl+Shift+D）
2. 起動構成から以下のいずれかを選択:
   - **Preview Local in Copilot (Edge)**
   - **Preview Local in Copilot (Chrome)**
3. F5 キーを押すか、緑の再生ボタンをクリック
4. ブラウザが自動的に開き、Microsoft 365 Copilot が起動します

---

#### **5.3 Microsoft 365 Copilot（エンドユーザー画面）での確認**

**最も重要な確認**: 実際のユーザー体験を確認します。

**確認手順:**

1. **Microsoft 365 Copilot を開く**
   ```
   https://copilot.microsoft.com/
   または
   Microsoft Teams → Copilot タブ
   ```

2. **エージェントを選択**
   - チャット画面右上の **プラグイン/エージェントアイコン** をクリック
   - または右上の **...** メニューから **エージェント** を選択

3. **エージェントの確認ポイント**
   - ✅ エージェント一覧に **SupportTicketAgent** が表示される
   - ✅ アイコンと名前が正しく表示される
   - ✅ エージェントを選択/有効化できる

4. **会話スターターの確認**
   - エージェントを選択すると、会話スターター（推奨質問）が表示される
   - TypeSpec で定義した `@conversationStarter` が反映されているか確認

5. **動作テスト**
   - 会話スターターをクリック、または任意の質問を入力
   - エージェントが指示（instructions）に従って応答するか確認
   - アクション（API 呼び出し）が定義されている場合、正しく実行されるか確認

**テスト例:**

```
# 基本的な挨拶
"こんにちは"

# 会話スターターのクリック
（画面に表示された推奨質問をクリック）

# カスタム質問
"ヘルプを表示して"
"サポートチケットを検索して"
```

---

#### **5.4 Microsoft Entra ID（Azure AD）ポータルでの確認**

**確認する理由**: アプリ登録と権限設定が正しいか確認します。

**確認手順:**

1. **Entra ID ポータルにアクセス**
   ```
   https://entra.microsoft.com/
   または
   https://portal.azure.com/ → Azure Active Directory
   ```

2. **アプリの登録を確認**
   - 左メニューから **アプリの登録** を選択
   - **すべてのアプリケーション** タブを選択
   - **SupportTicketAgent** を検索

3. **確認ポイント**
   - ✅ **アプリケーション（クライアント）ID**: `env/.env.local` の `M365_CLIENT_ID` と一致するか
   - ✅ **ディレクトリ（テナント）ID**: `M365_TENANT_ID` と一致するか
   - ✅ **状態**: "有効" になっているか

4. **API のアクセス許可を確認**
   - 左メニューから **API のアクセス許可** を選択
   - 必要な権限が付与されているか確認:
     - Microsoft Graph
     - その他必要な API
   - 管理者の同意が必要な場合、✅ マークが付いているか確認

5. **証明書とシークレット**
   - 左メニューから **証明書とシークレット** を選択
   - 有効なクライアントシークレットが存在するか確認

**PowerShell/Azure CLI での確認:**

```powershell
# Azure CLI でログイン
az login

# アプリ登録を検索
az ad app list --display-name "SupportTicketAgent" --output table

# または、特定のアプリ ID で詳細確認
$appId = (Select-String -Path "env\.env.local" -Pattern "M365_CLIENT_ID=(.+)").Matches.Groups[1].Value.Trim()
az ad app show --id $appId --query "{displayName:displayName, appId:appId, createdDateTime:createdDateTime}" --output json
```

**Microsoft Graph PowerShell での確認:**

```powershell
# Microsoft Graph PowerShell SDK をインストール（初回のみ）
Install-Module Microsoft.Graph -Scope CurrentUser

# 接続
Connect-MgGraph -Scopes "Application.Read.All"

# アプリ情報を取得
$appId = (Select-String -Path "env\.env.local" -Pattern "M365_CLIENT_ID=(.+)").Matches.Groups[1].Value.Trim()
$app = Get-MgApplication -Filter "appId eq '$appId'"
$app | Select-Object DisplayName, AppId, CreatedDateTime, PublisherDomain
```

---

#### **5.5 Teams 管理センターでの確認**

**確認する理由**: Teams/Copilot アプリとして正しく登録されているか確認します。

**確認手順:**

1. **Teams 管理センターにアクセス**
   ```
   https://admin.teams.microsoft.com/
   ```

2. **Teams アプリを確認**
   - 左メニューから **Teams アプリ** → **アプリを管理** を選択
   - 検索ボックスで **SupportTicketAgent** を検索

3. **確認ポイント**
   - ✅ **状態**: "承認済み" または "利用可能"
   - ✅ **発行元**: 組織名または開発者名
   - ✅ **バージョン**: manifest.json のバージョンと一致

4. **アプリのアクセス許可ポリシーを確認**
   - 左メニューから **Teams アプリ** → **アクセス許可ポリシー** を選択
   - エージェントがブロックされていないか確認
   - 必要に応じて、カスタムアプリのアップロードを許可

5. **セットアップポリシー**
   - 左メニューから **Teams アプリ** → **セットアップポリシー** を選択
   - 必要なユーザーにエージェントが割り当てられているか確認

---

#### **5.6 Microsoft 365 管理センターでの確認**

**確認する理由**: 組織全体でのアプリ展開状況を確認します。

**確認手順:**

1. **M365 管理センターにアクセス**
   ```
   https://admin.microsoft.com/
   ```

2. **統合アプリを確認**
   - 左メニューから **設定** → **統合アプリ** を選択
   - **SupportTicketAgent** を検索

3. **確認ポイント**
   - ✅ **状態**: "アクティブ" になっているか
   - ✅ **ユーザーとグループ**: 適切なユーザーに割り当てられているか
   - ✅ **同意**: 管理者の同意が必要な場合、承認されているか

---

### 6. トラブルシューティング

#### **一般的な問題と解決策**

| 問題 | 原因 | 解決方法 |
|------|------|---------|
| **npm コマンドが認識されない** | Node.js 未インストール | Node.js をインストール後、PowerShell を再起動 |
| **Provision が失敗する** | Microsoft 365 アカウント未認証 | Toolkit で Microsoft 365 にサインイン |
| **依存関係の競合エラー** | TypeSpec パッケージバージョン不一致 | `--legacy-peer-deps` オプションを使用 |
| **Copilot にエージェントが表示されない** | Provision 未実行または失敗 | Provision を再実行、Teams 管理センター確認 |
| **TypeSpec コンパイルエラー** | 構文エラー | `npx tsp compile .` でエラー詳細を確認 |
| **権限エラー** | API 権限未付与 | Entra ID で権限を確認・付与 |

#### **ログの確認方法**

**VS Code Output パネル:**

```
表示 → 出力（または Ctrl+Shift+U）
↓
ドロップダウンから "Microsoft 365 Agents Toolkit" を選択
↓
エラーメッセージを確認
```

**PowerShell でのログ確認:**

```powershell
# TypeSpec のコンパイルエラーを確認
npx tsp compile .

# npm のログファイルを確認
Get-ChildItem -Path $env:LOCALAPPDATA\npm-cache\_logs | Sort-Object LastWriteTime -Descending | Select-Object -First 1 | Get-Content
```

#### **クリーンアップと再実行**

問題が解決しない場合、以下の手順でクリーンアップしてから再実行します：

```powershell
# 環境ファイルを削除
Remove-Item -Path "env\.env.local" -Force -ErrorAction SilentlyContinue

# node_modules を削除（必要に応じて）
Remove-Item -Path "node_modules" -Recurse -Force -ErrorAction SilentlyContinue

# 再インストール
npm install

# Provision を再実行
npx teamsfx provision --env local
```

---

### 7. 次のステップ

Provision が成功し、動作確認が完了したら、以下のステップに進むことができます：

1. **TypeSpec ファイルのカスタマイズ**
   - [src/agent/main.tsp](src/agent/main.tsp) でエージェント定義を編集
   - [src/agent/prompts/instructions.tsp](src/agent/prompts/instructions.tsp) で指示を編集
   - [src/agent/actions/](src/agent/actions/) でアクション（API）を追加

2. **機能の追加**
   - 会話スターターの追加
   - 新しいアクションの定義
   - 機能（WebSearch, OneDrive, CodeInterpreter など）の追加

3. **デプロイ環境の切り替え**
   ```powershell
   # 開発環境へデプロイ
   npx teamsfx provision --env dev
   
   # 本番環境へデプロイ
   npx teamsfx provision --env prod
   ```

4. **チームとの共有**
   - Teams 管理センターで組織全体に配布
   - または、特定のユーザー/グループに割り当て

---

## 参考リンク集

### **公式ドキュメント**
- [宣言型エージェントの概要](https://learn.microsoft.com/microsoft-365-copilot/extensibility/overview-declarative-agent)
- [TypeSpec で宣言型エージェントを構築](https://learn.microsoft.com/microsoft-365-copilot/extensibility/build-declarative-agents-typespec)
- [API プラグインの構築](https://learn.microsoft.com/microsoft-365-copilot/extensibility/build-api-plugins-typespec)
- [前提条件とセットアップ](https://learn.microsoft.com/microsoft-365-copilot/extensibility/prerequisites)

### **Teams カスタムアプリ**
- [Teams カスタムアプリのポリシー](https://learn.microsoft.com/microsoftteams/teams-custom-app-policies-and-settings)
- [テナントの準備](https://learn.microsoft.com/microsoftteams/platform/concepts/build-and-test/prepare-your-o365-tenant)

### **ツールとSDK**
- [Microsoft 365 Agents Toolkit](https://aka.ms/teams-toolkit)
- [Node.js 公式サイト](https://nodejs.org/)
- [TypeSpec 公式ドキュメント](https://typespec.io/)

### **コミュニティとサポート**
- [Microsoft 365 開発者プログラム](https://developer.microsoft.com/microsoft-365/dev-program)
- [GitHub - TypeSpec サンプル](https://github.com/microsoft/TypeSpec)
- [Microsoft Q&A](https://learn.microsoft.com/answers/)

---

## 学習ガイド：技術理解から顧客提案まで

このセクションでは、Declarative Agent + TypeSpec の技術を段階的に学び、顧客への提案に活用できるように整理します。

### 学習の全体像

```
Phase 1: 基礎理解        Phase 2: 実装体験        Phase 3: 応用と提案
┌──────────────┐      ┌──────────────┐      ┌──────────────┐
│ アーキテクチャ │  →   │ ハンズオン検証 │  →   │ 顧客シナリオ  │
│ 理解          │      │ トラブル対応  │      │ デモ準備      │
└──────────────┘      └──────────────┘      └──────────────┘
   1-2 週間              2-3 週間              継続的
```

---

### Phase 1: 基礎理解（技術コンポーネントの整理）

#### **1.1 主要技術スタックの理解**

以下の技術要素がどのように連携するかを理解します：

| レイヤー | 技術 | 役割 | 学習優先度 |
|---------|------|------|-----------|
| **開発言語** | TypeSpec | 型安全なエージェント定義 | ★★★ 高 |
| **API 仕様** | OpenAPI 3.0 | API プラグインの標準フォーマット | ★★★ 高 |
| **アプリ基盤** | Teams Platform | マニフェスト、配布、管理 | ★★☆ 中 |
| **認証・認可** | Microsoft Entra ID (OAuth 2.0) | セキュアなアクセス制御 | ★★★ 高 |
| **AI オーケストレーション** | Microsoft 365 Copilot | LLM + 関数呼び出し | ★★☆ 中 |
| **開発ツール** | Microsoft 365 Agents Toolkit | プロジェクト管理、デプロイ | ★★★ 高 |

**学習アプローチ：**

1. **まず全体像を把握**
   - [Provision の技術的詳細](#provision-の技術的な詳細と必要性) セクションを熟読
   - アーキテクチャ図を自分で描いてみる（[詳細ガイド](#アーキテクチャ図の描き方ガイド)参照）
   - データフロー（ユーザー入力 → LLM → API → 応答）を追跡

2. **各コンポーネントを深掘り**
   ```powershell
   # プロジェクト内のファイルを順に確認
   # 1. マニフェスト（最終成果物）
   cat appPackage\manifest.json | ConvertFrom-Json | ConvertTo-Json -Depth 10
   
   # 2. TypeSpec 定義（開発者が書くコード）
   cat src\agent\main.tsp
   cat src\agent\prompts\instructions.tsp
   cat src\agent\actions\*.tsp
   
   # 3. 環境設定
   cat env\.env.local
   cat src\agent\env.tsp
   
   # 4. 設定ファイル
   cat tspconfig.yaml
   cat m365agents.yml
   ```

3. **ドキュメントとの対応付け**
   - 公式ドキュメントを読みながら、実際のファイルで該当箇所を確認
   - サンプルコードと自分のプロジェクトを比較

---

---

### アーキテクチャ図の描き方ガイド

アーキテクチャ図を描くことで、技術的な理解が深まり、顧客説明も容易になります。以下、5つの視点から段階的に描くことを推奨します。

#### **推奨する5つのアーキテクチャ図**

| 図の種類 | 目的 | 学習効果 | 顧客説明 |
|---------|------|---------|---------|
| **1. システムアーキテクチャ図** | 全体構成の理解 | ★★★ 高 | ★★★ 高 |
| **2. データフロー図** | 処理の流れの把握 | ★★★ 高 | ★★☆ 中 |
| **3. コンポーネント図** | 技術スタックの整理 | ★★☆ 中 | ★☆☆ 低 |
| **4. デプロイメント図** | 環境構成の理解 | ★★☆ 中 | ★★☆ 中 |
| **5. シーケンス図** | 時系列の相互作用 | ★★★ 高 | ★☆☆ 低 |

---

#### **図1: システムアーキテクチャ図（最優先）**

**目的**: Declarative Agent を構成する主要コンポーネントとその関係を可視化

**描くべき要素:**

```
┌─────────────────────────────────────────────────────────────┐
│                     ユーザー（従業員）                          │
└───────────────────────┬─────────────────────────────────────┘
                        │ 自然言語での質問
                        ↓
┌─────────────────────────────────────────────────────────────┐
│              Microsoft 365 Copilot（UI）                     │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐         │
│  │   Teams     │  │    Word     │  │ PowerPoint  │         │
│  └─────────────┘  └─────────────┘  └─────────────┘         │
└───────────────────────┬─────────────────────────────────────┘
                        │
                        ↓
┌─────────────────────────────────────────────────────────────┐
│           Copilot オーケストレーター                          │
│  ┌──────────────────────────────────────────────────┐      │
│  │ 1. マニフェスト読み込み (manifest.json)           │      │
│  │ 2. エージェント定義取得 (declarativeAgent.json)   │      │
│  │ 3. Instructions を LLM に設定                     │      │
│  │ 4. Capabilities と Actions を確認                │      │
│  └──────────────────────────────────────────────────┘      │
└───────────────────────┬─────────────────────────────────────┘
                        │
                        ↓
┌─────────────────────────────────────────────────────────────┐
│              Large Language Model (GPT-4)                    │
│  ┌──────────────────────────────────────────────────┐      │
│  │ - ユーザーの意図を解釈                            │      │
│  │ - 必要なアクション/Capability を判断              │      │
│  │ - 関数呼び出しまたは直接応答                      │      │
│  └──────────────────────────────────────────────────┘      │
└───┬───────────────────┬─────────────────────┬───────────────┘
    │                   │                     │
    ↓                   ↓                     ↓
┌─────────┐      ┌──────────┐         ┌──────────────┐
│Capability│      │Capability│         │  API Plugin  │
│WebSearch │      │OneDrive/ │         │  (Actions)   │
│         │      │SharePoint│         │              │
└─────────┘      └──────────┘         └──────┬───────┘
                                              │
                                              ↓
                                    ┌──────────────────┐
                                    │  外部 API        │
                                    │ (GitHub, CRM等) │
                                    └──────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────────┐
│              Microsoft Entra ID（認証・認可）                 │
│  ┌──────────────────────────────────────────────────┐      │
│  │ - アプリ登録（App Registration）                  │      │
│  │ - OAuth 2.0 トークン発行                          │      │
│  │ - API 権限管理                                    │      │
│  └──────────────────────────────────────────────────┘      │
└─────────────────────────────────────────────────────────────┘
```

**描き方の指針:**

1. **トップダウンで描く**: ユーザー → UI → オーケストレーター → LLM → バックエンド
2. **四角で囲む**: 各レイヤー/コンポーネントを明確に区別
3. **矢印で関係性**: データの流れ、呼び出し関係を示す
4. **色分け**: 
   - ユーザー層: 青
   - Microsoft 365 サービス: 緑
   - カスタムコンポーネント: オレンジ
   - 外部システム: グレー

**チェックポイント:**
- ✅ ユーザーから外部APIまでの経路が追えるか？
- ✅ 認証（Entra ID）がどこで使われるか明確か？
- ✅ Capabilities と Actions の違いが表現されているか？

---

#### **図2: データフロー図（ユーザー質問 → 応答）**

**目的**: 1つの質問がどのように処理されるかを時系列で理解

**描くべき要素:**

```
ステップ1: ユーザー入力
┌──────────────────────────────────────────┐
│ ユーザー: "GitHub の TypeSpec リポジトリ  │
│           の open issues を教えて"        │
└────────────────┬─────────────────────────┘
                 │
                 ↓
ステップ2: Copilot UI が受信
┌──────────────────────────────────────────┐
│ - テキスト入力を受け取る                   │
│ - エージェントが有効か確認                 │
└────────────────┬─────────────────────────┘
                 │
                 ↓
ステップ3: オーケストレーター
┌──────────────────────────────────────────┐
│ - manifest.json からエージェント情報取得   │
│ - declarativeAgent.json 読み込み         │
│ - instructions を取得                    │
│ - 利用可能な actions を確認               │
└────────────────┬─────────────────────────┘
                 │
                 ↓
ステップ4: LLM への入力構築
┌──────────────────────────────────────────┐
│ システムプロンプト:                        │
│ - instructions の内容                    │
│ - 利用可能な関数リスト (OpenAPI から生成) │
│                                          │
│ ユーザープロンプト:                        │
│ - "GitHub の TypeSpec リポジトリの        │
│    open issues を教えて"                 │
└────────────────┬─────────────────────────┘
                 │
                 ↓
ステップ5: LLM の推論
┌──────────────────────────────────────────┐
│ 判断:                                     │
│ - getIssues 関数を呼び出すべき            │
│                                          │
│ パラメータ抽出:                            │
│ - owner: "microsoft"                     │
│ - repo: "TypeSpec"                       │
│ - state: "open"                          │
└────────────────┬─────────────────────────┘
                 │
                 ↓
ステップ6: Function Calling Engine
┌──────────────────────────────────────────┐
│ - OpenAPI 仕様から getIssues の定義取得   │
│ - HTTP リクエスト構築:                     │
│   GET /repos/microsoft/TypeSpec/issues   │
│   ?state=open                            │
│ - 認証トークン付与（Entra ID）            │
└────────────────┬─────────────────────────┘
                 │
                 ↓
ステップ7: 外部 API 呼び出し
┌──────────────────────────────────────────┐
│ GitHub API                               │
│ - リクエスト受信                          │
│ - 認証確認                                │
│ - データ取得                              │
│ - JSON レスポンス返却                     │
└────────────────┬─────────────────────────┘
                 │
                 ↓
ステップ8: レスポンス処理
┌──────────────────────────────────────────┐
│ - JSON パース                             │
│ - データを LLM に返す                      │
└────────────────┬─────────────────────────┘
                 │
                 ↓
ステップ9: LLM の応答生成
┌──────────────────────────────────────────┐
│ - API レスポンスを自然言語に変換          │
│ - ユーザーフレンドリーな形式で整形        │
└────────────────┬─────────────────────────┘
                 │
                 ↓
ステップ10: ユーザーに表示
┌──────────────────────────────────────────┐
│ "TypeSpec リポジトリには現在 15 件の      │
│  open issues があります:                 │
│  1. [#123] Feature: Add new decorator   │
│  2. [#124] Bug: Compilation error       │
│  ..."                                    │
└──────────────────────────────────────────┘
```

**描き方の指針:**

1. **縦方向のフロー**: 上から下へ時系列で並べる
2. **各ステップを番号付け**: 順序を明確にする
3. **データの変化を示す**: 各ステップでデータがどう変わるかを記載
4. **判断ポイントを強調**: LLMの推論など重要な処理を目立たせる

**チェックポイント:**
- ✅ 各ステップが論理的につながっているか？
- ✅ データの形式変化（自然言語 → 構造化 → API → 自然言語）が追えるか？
- ✅ エラーが発生しうる箇所が想像できるか？

---

#### **図3: コンポーネント図（技術スタック）**

**目的**: 開発者が作成/管理するコンポーネントを整理

**描くべき要素:**

```
開発フェーズ                           実行フェーズ
┌────────────────────────┐          ┌────────────────────────┐
│   開発者が書くコード      │          │   ランタイムで使用      │
└────────────────────────┘          └────────────────────────┘

┌────────────────────────┐          ┌────────────────────────┐
│  TypeSpec ファイル      │          │  コンパイル済みファイル  │
│  (.tsp)                │          │                        │
│                        │  コンパイル│                        │
│  ├─ main.tsp          │  ───────→ │  ├─ manifest.json     │
│  ├─ instructions.tsp  │          │  ├─ declarativeAgent   │
│  ├─ actions/          │          │  │   .json              │
│  │   └─ github.tsp   │          │  └─ apiSpecification   │
│  └─ models.tsp        │          │      File/             │
│                        │          │      └─ github.json    │
└────────────────────────┘          └────────────────────────┘
         ↑                                     │
         │                                     │
         │                                     ↓
┌────────────────────────┐          ┌────────────────────────┐
│  環境設定               │          │  Microsoft 365         │
│                        │          │  エコシステム           │
│  ├─ env/.env.local    │  参照   │                        │
│  ├─ tspconfig.yaml    │  ───────→ │  ├─ Teams App Catalog│
│  └─ m365agents.yml    │          │  ├─ Copilot Service   │
│                        │          │  └─ Entra ID          │
└────────────────────────┘          └────────────────────────┘

┌────────────────────────┐
│  ツール                 │
│                        │
│  ├─ TypeSpec Compiler │
│  ├─ Microsoft 365      │
│  │   Agents Toolkit   │
│  └─ VS Code Extension │
└────────────────────────┘
```

**描き方の指針:**

1. **左右に分ける**: 開発時と実行時を区別
2. **ファイル構造を表現**: ディレクトリツリー形式で記載
3. **変換の矢印**: コンパイルや参照の関係を示す
4. **ツールを別枠**: 開発支援ツールは独立して表示

**チェックポイント:**
- ✅ どのファイルを編集すればいいかわかるか？
- ✅ コンパイル前後の対応が理解できるか？
- ✅ 環境変数がどこで使われるか明確か？

---

#### **図4: デプロイメント図（環境構成）**

**目的**: local/dev/prod 環境の違いと構成を理解

**描くべき要素:**

```
┌──────────────────────────────────────────────────────────┐
│                     開発環境（Local）                      │
├──────────────────────────────────────────────────────────┤
│  開発マシン                                               │
│  ┌─────────────────────────────────────────────┐        │
│  │  VS Code + Microsoft 365 Agents Toolkit     │        │
│  │  ├─ TypeSpec ファイル編集                    │        │
│  │  ├─ npx tsp compile .                       │        │
│  │  └─ npx teamsfx provision --env local       │        │
│  └─────────────────┬───────────────────────────┘        │
│                    │                                      │
│                    ↓                                      │
│  ┌─────────────────────────────────────────────┐        │
│  │  env/.env.local                             │        │
│  │  - TEAMS_APP_ID=xxx-local                   │        │
│  │  - API_ENDPOINT=http://localhost:3000       │        │
│  └─────────────────────────────────────────────┘        │
└──────────────────────┬───────────────────────────────────┘
                       │
                       ↓
┌──────────────────────────────────────────────────────────┐
│                  開発/テスト環境（Dev）                    │
├──────────────────────────────────────────────────────────┤
│  Azure / Microsoft 365 (Dev Tenant)                      │
│  ┌─────────────────────────────────────────────┐        │
│  │  Teams App Catalog (Dev)                    │        │
│  │  - SupportTicketAgent (Dev版)               │        │
│  └─────────────────────────────────────────────┘        │
│  ┌─────────────────────────────────────────────┐        │
│  │  env/.env.dev                               │        │
│  │  - TEAMS_APP_ID=xxx-dev                     │        │
│  │  - API_ENDPOINT=https://api-dev.company.com │        │
│  └─────────────────────────────────────────────┘        │
└──────────────────────┬───────────────────────────────────┘
                       │
                       ↓
┌──────────────────────────────────────────────────────────┐
│                     本番環境（Production）                 │
├──────────────────────────────────────────────────────────┤
│  Microsoft 365 (Production Tenant)                       │
│  ┌─────────────────────────────────────────────┐        │
│  │  Teams App Catalog (Prod)                   │        │
│  │  - SupportTicketAgent (正式版)              │        │
│  │  - 組織全体に配布                            │        │
│  └─────────────────────────────────────────────┘        │
│  ┌─────────────────────────────────────────────┐        │
│  │  env/.env.prod                              │        │
│  │  - TEAMS_APP_ID=xxx-prod                    │        │
│  │  - API_ENDPOINT=https://api.company.com     │        │
│  └─────────────────────────────────────────────┘        │
│  ┌─────────────────────────────────────────────┐        │
│  │  監視・ログ                                  │        │
│  │  - Application Insights                     │        │
│  │  - Entra ID ログ                            │        │
│  └─────────────────────────────────────────────┘        │
└──────────────────────────────────────────────────────────┘
```

**描き方の指針:**

1. **3層に分ける**: Local → Dev → Prod を明確に区別
2. **環境変数の違いを示す**: 各環境で何が違うかを記載
3. **データの流れ**: 開発から本番への昇格パスを表現
4. **監視要素**: 本番環境特有の要素を追加

**チェックポイント:**
- ✅ 環境間の違いが明確か？
- ✅ どの環境で何をテストすべきか理解できるか？
- ✅ 本番デプロイの手順が想像できるか？

---

#### **図5: シーケンス図（API Plugin 実行）**

**目的**: 時系列での各コンポーネント間のやり取りを詳細に理解

**描くべき要素:**

```
ユーザー    Copilot UI  オーケストレーター  LLM      Function    GitHub API  Entra ID
   │           │              │           │       Calling       │           │
   │  質問     │              │           │       Engine        │           │
   ├──────────>│              │           │          │          │           │
   │           │ エージェント │           │          │          │           │
   │           │ 情報取得     │           │          │          │           │
   │           ├─────────────>│           │          │          │           │
   │           │              │ マニフェスト│          │          │           │
   │           │              │ + Actions│          │          │           │
   │           │<─────────────┤           │          │          │           │
   │           │              │           │          │          │           │
   │           │ LLM に送信    │           │          │          │           │
   │           │              ├──────────>│          │          │           │
   │           │              │ システム   │          │          │           │
   │           │              │ プロンプト │          │          │           │
   │           │              │ + 質問    │          │          │           │
   │           │              │           │ 推論     │          │           │
   │           │              │           │ (関数選択)│          │           │
   │           │              │           │          │          │           │
   │           │              │           │ 関数呼出 │          │           │
   │           │              │           │ リクエスト│          │           │
   │           │              │<──────────┤          │          │           │
   │           │              │           │          │          │           │
   │           │              │ 関数実行要求│          │          │           │
   │           │              ├───────────────────────>│          │           │
   │           │              │           │          │          │           │
   │           │              │           │          │ トークン  │           │
   │           │              │           │          │ 要求     │           │
   │           │              │           │          ├─────────────────────>│
   │           │              │           │          │          │ 認証     │
   │           │              │           │          │<─────────────────────┤
   │           │              │           │          │ アクセス  │           │
   │           │              │           │          │ トークン  │           │
   │           │              │           │          │          │           │
   │           │              │           │          │ API Call │           │
   │           │              │           │          ├─────────>│           │
   │           │              │           │          │          │ 処理     │
   │           │              │           │          │<─────────┤           │
   │           │              │           │          │ Response │           │
   │           │              │           │          │          │           │
   │           │              │ API結果   │          │          │           │
   │           │              │<───────────────────────┤          │           │
   │           │              │           │          │          │           │
   │           │              │ 結果を LLM│          │          │           │
   │           │              ├──────────>│          │          │           │
   │           │              │           │ 自然言語 │          │           │
   │           │              │           │ 生成     │          │           │
   │           │              │<──────────┤          │          │           │
   │           │              │ 応答      │          │          │           │
   │           │<─────────────┤           │          │          │           │
   │           │              │           │          │          │           │
   │  応答表示  │              │           │          │          │           │
   │<──────────┤              │           │          │          │           │
   │           │              │           │          │          │           │
```

**描き方の指針:**

1. **横軸に登場人物**: 各コンポーネントを列として配置
2. **縦軸に時間**: 上から下に時系列で進行
3. **矢印でメッセージ**: 誰が誰に何を送るかを明示
4. **処理を注釈**: 重要な処理内容を矢印の上に記載

**チェックポイント:**
- ✅ メッセージの往復が正しく表現されているか？
- ✅ 認証のタイミングが適切か？
- ✅ 非同期処理と同期処理が区別できるか？

---

#### **アーキテクチャ図作成のベストプラクティス**

**推奨ツール:**

| ツール | 用途 | 学習曲線 | コスト |
|--------|------|---------|--------|
| **Draw.io (diagrams.net)** | すべての図 | 低 | 無料 |
| **Mermaid** | コードで図を生成 | 中 | 無料 |
| **Lucidchart** | プロフェッショナルな図 | 低 | 有料 |
| **Microsoft Visio** | エンタープライズ | 中 | 有料 |
| **PowerPoint** | プレゼン用 | 低 | 有料 |
| **手書き** | 学習用 | 最低 | 無料 |

**推奨作成順序:**

```
1. システムアーキテクチャ図（全体像）
   ↓ これで全体を把握
2. データフロー図（処理の流れ）
   ↓ 1つのリクエストを追跡
3. コンポーネント図（ファイル構成）
   ↓ 実装対象を明確化
4. デプロイメント図（環境）
   ↓ 運用を想定
5. シーケンス図（詳細な相互作用）
   ↓ 高度な理解
```

**効果的な学習方法:**

1. **まず手書きで描く**
   - 紙に鉛筆で簡単に描いてみる
   - 間違いを恐れず、何度も書き直す
   - 理解が深まったら、ツールで清書

2. **公式ドキュメントと照らし合わせる**
   - 自分の図と公式の図を比較
   - 足りない要素や誤解を発見

3. **他の人に説明してみる**
   - 図を使って同僚に説明
   - 質問されることで新たな気づき

4. **実際のファイルと対応付ける**
   ```powershell
   # コンポーネント図を見ながら、実ファイルを確認
   Get-ChildItem -Recurse -Include *.tsp, *.json, *.yml
   ```

**よくある間違いと修正:**

| 間違い | 修正 |
|--------|------|
| すべてを1つの図に詰め込む | 目的別に複数の図に分ける |
| 矢印の向きが不明確 | データの流れを明示（単方向/双方向） |
| 用語が統一されていない | 公式ドキュメントの用語を使用 |
| 抽象度が混在 | 1つの図では同じ抽象レベルを保つ |
| 色や形に意味がない | 凡例を用意し、一貫したルールを使用 |

**検証方法:**

```powershell
# アーキテクチャ図の自己チェックリスト

Write-Host "=== アーキテクチャ図 自己評価 ===" -ForegroundColor Cyan

$checklist = @(
    @{ Item = "全体像が一目でわかるか？"; Status = $false },
    @{ Item = "データの流れが追えるか？"; Status = $false },
    @{ Item = "各コンポーネントの役割が明確か？"; Status = $false },
    @{ Item = "認証の仕組みが表現されているか？"; Status = $false },
    @{ Item = "環境の違いがわかるか？"; Status = $false },
    @{ Item = "他の人に説明できるか？"; Status = $false },
    @{ Item = "実装時に参照できるか？"; Status = $false }
)

foreach ($item in $checklist) {
    $mark = if ($item.Status) { "✓" } else { "□" }
    Write-Host "$mark $($item.Item)"
}

Write-Host "`n全て ✓ になったら完成です！" -ForegroundColor Green
```

---

### 図を活用した学習サイクル

**効果的な学習フロー:**

```
1. ドキュメントを読む
   ↓
2. アーキテクチャ図を描く
   ↓
3. 実際にコードを確認
   ↓
4. 図を修正・詳細化
   ↓
5. 他の人に説明
   ↓
6. フィードバックを受けて改善
   ↓
（繰り返し）
```

**顧客説明への活用:**

- **システムアーキテクチャ図**: 技術的な全体像を説明
- **データフロー図**: ユーザー体験を具体的に説明
- **デプロイメント図**: 段階的な導入計画を提示

これらの図を準備することで、技術的な深い理解と、わかりやすい顧客説明の両方が可能になります。

---

#### **1.2 TypeSpec の言語仕様に注目**

**注目すべきポイント：**

| TypeSpec 要素 | サンプル | ビジネス価値 |
|--------------|---------|-------------|
| **`@agent()`** | エージェント定義 | ブランディング、用途の明確化 |
| **`@instructions()`** | LLM への指示 | エージェントの振る舞い制御 |
| **`@conversationStarter()`** | 会話の例 | ユーザーオンボーディング |
| **`@actions()`** | API 定義 | 外部システム連携 |
| **Capabilities** | WebSearch, OneDrive など | 知識ソースの拡張 |
| **Models** | データ型定義 | API の入出力仕様 |

**実践的な学習方法：**

```powershell
# TypeSpec のコンパイルを実行して、出力を確認
npx tsp compile .

# 生成されたファイルを比較
code -d src\agent\main.tsp appPackage\manifest.json

# エラーを意図的に発生させて理解を深める
# 例: @agent() の name を空にしてコンパイル
npx tsp compile .
```

**重要な学習課題：**

1. ✅ `@agent()` デコレータのすべてのパラメータを試す
2. ✅ 複数の `@conversationStarter()` を追加してUIでの表示を確認
3. ✅ `@instructions()` の内容を変更して、エージェントの応答がどう変わるかテスト
4. ✅ 新しいアクション（API）を追加してみる
5. ✅ 異なる Capability を有効化して動作を比較

---

#### **1.3 API Plugin のアーキテクチャ理解**

**重要な概念：**

```
自然言語（ユーザー）
   ↓
LLM による解釈
   ↓
関数呼び出しの判断（OpenAPI の operationId を選択）
   ↓
パラメータ抽出（自然言語 → 構造化データ）
   ↓
HTTP リクエスト構築
   ↓
外部 API 呼び出し
   ↓
レスポンス処理
   ↓
自然言語での応答生成
```

**検証すべきポイント：**

1. **OpenAPI 仕様の品質**
   - `description` フィールドが LLM にとって理解しやすいか
   - パラメータの型定義が正確か
   - エラーレスポンスが適切に定義されているか

2. **LLM の関数選択精度**
   - 曖昧な質問でも正しいアクションを選べるか
   - 複数のアクションがある場合、適切に判断できるか

3. **パラメータ抽出の正確性**
   - 必須パラメータが欠けている場合の挙動
   - 型変換（文字列→数値など）が正しく行われるか

**実験例：**

```powershell
# src/agent/actions/github.tsp を編集
# descriptionForModel を変更して、LLM の理解度を確認

# Before
descriptionForModel: "Get issues from a GitHub repository"

# After (より詳細)
descriptionForModel: "Retrieves a list of issues from a GitHub repository. Use this when the user asks about bugs, feature requests, or open/closed issues in a specific repository."

# コンパイルして再デプロイ
npx tsp compile .
npx teamsfx provision --env local
```

---

### Phase 2: 実装体験（ハンズオン検証）

#### **2.1 段階的な実装プラン**

**レベル1: 基本動作の確認（1-2日）**

```
目標: サンプルエージェントを動かす
手順:
1. プロジェクト作成
2. Provision 実行
3. Copilot でテスト
4. 会話スターターをカスタマイズ
5. Instructions を変更して応答の違いを確認
```

**レベル2: Capability の追加（2-3日）**

```
目標: 知識ソースを拡張する
手順:
1. WebSearch を追加
   op webSearch is AgentCapabilities.WebSearch
2. OneDrive/SharePoint を追加（スコープ付き）
3. CodeInterpreter でデータ可視化
4. 各 Capability の動作確認とログ分析
```

**レベル3: カスタム API Plugin の実装（1週間）**

```
目標: 実際の業務APIと連携
手順:
1. 既存のREST APIを選定（社内システムまたはパブリックAPI）
2. TypeSpec でアクション定義
3. 認証設定（API Key, OAuth など）
4. エラーハンドリングの実装
5. 複数のアクションを連携させる
```

**レベル4: エンタープライズ展開（1-2週間）**

```
目標: 本番環境へのデプロイ準備
手順:
1. 環境分離（local → dev → prod）
2. Entra ID での権限設計
3. Teams 管理センターでのポリシー設定
4. ユーザーグループへの段階的ロールアウト
5. 利用状況の監視とフィードバック収集
```

---

#### **2.2 実装時のポイント（つまずきどころ）**

**重要度別のチェックリスト：**

##### **🔴 Critical（必ず押さえる）**

| # | ポイント | つまずきどころ | 対処法 |
|---|---------|--------------|--------|
| 1 | **Node.js バージョン** | 非対応バージョンでエラー | 18/20/22 を使用、`node --version` で確認 |
| 2 | **Microsoft 365 Copilot ライセンス** | ライセンスなしで動作しない | 事前に組織の管理者に確認 |
| 3 | **TypeSpec コンパイルエラー** | 構文エラーで Provision 失敗 | `npx tsp compile .` で事前確認 |
| 4 | **Entra ID 権限** | API 呼び出しで 403 エラー | 必要なスコープを明示的に付与 |
| 5 | **環境変数の設定** | API エンドポイントが未定義 | `.env.local` と `env.tsp` の同期確認 |

##### **🟡 Important（理解しておくべき）**

| # | ポイント | つまずきどころ | 対処法 |
|---|---------|--------------|--------|
| 6 | **OpenAPI の description** | LLM が関数を正しく選択できない | `descriptionForModel` を詳細に記述 |
| 7 | **Instructions の書き方** | エージェントが期待通り動作しない | 具体例を含め、ALWAYS/NEVER で明示 |
| 8 | **Capability のスコープ** | すべてのデータにアクセスしてしまう | `ItemsByUrl` などで適切にスコープ |
| 9 | **依存関係の競合** | npm install で ERESOLVE エラー | `--legacy-peer-deps` を使用 |
| 10 | **Teams ポリシー** | エージェントが表示されない | カスタムアプリのアップロードを許可 |

##### **🟢 Nice to Have（最適化ポイント）**

| # | ポイント | つまずきどころ | 対処法 |
|---|---------|--------------|--------|
| 11 | **アイコンデザイン** | デフォルトアイコンで見づらい | 256x256 と 32x32 のカスタムアイコン作成 |
| 12 | **エラーメッセージ** | ユーザーフレンドリーでない | API レスポンスに詳細なメッセージ含める |
| 13 | **パフォーマンス** | API 呼び出しが遅い | キャッシュ、非同期処理を検討 |
| 14 | **多言語対応** | 日本語が文字化け | UTF-8 エンコーディング確認 |
| 15 | **バージョン管理** | 更新後も古い動作が残る | `manifest.json` の version を更新 |

---

#### **2.3 検証すべき項目とテストケース**

**機能テストマトリクス：**

| カテゴリ | テストケース | 期待結果 | 確認方法 |
|---------|------------|---------|---------|
| **基本動作** | |||
| | エージェントが Copilot に表示される | ✓ 一覧に表示 | UI 確認 |
| | 会話スターターが表示される | ✓ 定義した内容が表示 | UI 確認 |
| | 簡単な質問に応答する | ✓ Instructions に基づいた応答 | チャットテスト |
| **API Plugin** | |||
| | 正常なパラメータでAPI呼び出し成功 | ✓ 200 OK、正しいデータ | ログ確認 |
| | 不正なパラメータでエラー処理 | ✓ エラーメッセージ表示 | チャットテスト |
| | 複数のアクションの使い分け | ✓ 適切なアクション選択 | ログ分析 |
| **Capabilities** | |||
| | WebSearch で最新情報取得 | ✓ Web検索結果を含む応答 | チャットテスト |
| | OneDrive からファイル検索 | ✓ ファイル内容を参照 | チャットテスト |
| | CodeInterpreter でグラフ生成 | ✓ 画像が表示される | UI 確認 |
| **認証・権限** | |||
| | 適切な権限でAPI呼び出し | ✓ アクセス成功 | Entra ID ログ |
| | 権限外のリソースへのアクセス | ✓ 403 エラー | エラーログ |
| **エラーハンドリング** | |||
| | API がダウンしている場合 | ✓ ユーザーフレンドリーなメッセージ | チャットテスト |
| | タイムアウト | ✓ 適切なエラー処理 | ログ確認 |

**テストスクリプト例：**

```powershell
# 自動テスト用のスクリプト（検証項目チェックリスト）

Write-Host "=== Declarative Agent 検証チェックリスト ===" -ForegroundColor Cyan

# 1. ファイル存在確認
Write-Host "`n[1] 必須ファイル:" -ForegroundColor Yellow
@(
    "appPackage\manifest.json",
    "env\.env.local",
    "src\agent\main.tsp",
    "src\agent\prompts\instructions.tsp"
) | ForEach-Object {
    $exists = Test-Path $_
    $mark = if ($exists) { "✓" } else { "✗" }
    $color = if ($exists) { "Green" } else { "Red" }
    Write-Host "  $mark $_" -ForegroundColor $color
}

# 2. TypeSpec コンパイル
Write-Host "`n[2] TypeSpec コンパイル:" -ForegroundColor Yellow
npx tsp compile . --no-emit 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) {
    Write-Host "  ✓ コンパイル成功" -ForegroundColor Green
} else {
    Write-Host "  ✗ コンパイルエラーあり" -ForegroundColor Red
}

# 3. マニフェスト検証
Write-Host "`n[3] マニフェスト検証:" -ForegroundColor Yellow
if (Test-Path "appPackage\manifest.json") {
    $manifest = Get-Content "appPackage\manifest.json" | ConvertFrom-Json
    Write-Host "  App Name: $($manifest.name.short)"
    Write-Host "  Version: $($manifest.version)"
    Write-Host "  Manifest Version: $($manifest.manifestVersion)"
    
    if ($manifest.manifestVersion -ge "1.17") {
        Write-Host "  ✓ Copilot 対応バージョン" -ForegroundColor Green
    } else {
        Write-Host "  ✗ バージョンアップが必要（1.17+）" -ForegroundColor Red
    }
}

# 4. 環境変数確認
Write-Host "`n[4] 環境変数:" -ForegroundColor Yellow
if (Test-Path "env\.env.local") {
    $env = Get-Content "env\.env.local" -Raw
    @("TEAMS_APP_ID", "M365_CLIENT_ID", "M365_TENANT_ID") | ForEach-Object {
        if ($env -match $_) {
            Write-Host "  ✓ $_ 設定済み" -ForegroundColor Green
        } else {
            Write-Host "  ✗ $_ 未設定" -ForegroundColor Red
        }
    }
}

Write-Host "`n=== 検証完了 ===" -ForegroundColor Cyan
Write-Host "次のステップ: Copilot UI でテストしてください"
```

---

### Phase 3: 応用と提案（顧客シナリオ）

#### **3.1 顧客に説明すべき技術的メリット**

**技術観点からのメリット整理：**

| メリット | 技術的根拠 | 顧客への説明ポイント |
|---------|-----------|-------------------|
| **開発効率の向上** | TypeSpec による型安全な開発 | 「従来の JSON 手書きより 3-5 倍速く、エラーも少ない」 |
| **保守性** | コンパイル時の検証 | 「変更時の影響範囲が自動でチェックされる」 |
| **標準化** | OpenAPI ベース | 「既存の API を再利用可能。新規開発不要の場合も」 |
| **セキュリティ** | Entra ID 統合 | 「組織の認証基盤をそのまま利用。追加のセキュリティ対策不要」 |
| **スケーラビリティ** | Microsoft 365 インフラ | 「数千人規模でも追加コストなし」 |
| **拡張性** | Capabilities | 「後から知識ソースを追加可能。段階的な機能拡張」 |

---

#### **3.2 業種別シナリオとデモ例**

##### **シナリオ1: IT ヘルプデスク（Support Ticket Agent）**

**課題:**
- ヘルプデスクへの問い合わせが多く、対応に時間がかかる
- よくある質問（FAQ）の回答が属人化
- チケットシステムの検索が複雑

**ソリューション:**

```typespec
@agent("IT Support Agent", "社内ITサポートエージェント")
@instructions("""
**役割**: IT ヘルプデスクの第1次対応を支援
**動作**:
- よくある質問にはナレッジベースから即答
- チケットの検索・ステータス確認を支援
- 解決できない場合は担当者へエスカレーション
""")
namespace ITSupportAgent {
  // WebSearch: 社内ナレッジベースをスコープ
  op webSearch is AgentCapabilities.WebSearch<Sites = [
    { url: "https://company.sharepoint.com/sites/ITKnowledge" }
  ]>
  
  // API Plugin: チケットシステム連携
  op searchTickets is TicketAPI.searchTickets;
  op getTicketStatus is TicketAPI.getTicketStatus;
}
```

**デモシナリオ:**

1. **FAQ 即答**
   - ユーザー: "VPN に接続できない"
   - エージェント: SharePoint のナレッジから解決手順を提示

2. **チケット検索**
   - ユーザー: "自分のチケットの状況を教えて"
   - エージェント: API でチケットを検索し、ステータスを表示

3. **エスカレーション**
   - ユーザー: "それでも解決しない"
   - エージェント: 担当者への連絡方法を案内

**ROI の説明:**
- ヘルプデスク対応時間 30% 削減
- FAQ 回答の標準化
- チケット検索時間 50% 短縮

---

##### **シナリオ2: 営業支援（Sales Assistant）**

**課題:**
- 提案資料作成に時間がかかる
- 過去の提案書や事例の検索が困難
- 競合情報が散在

**ソリューション:**

```typespec
@agent("Sales Assistant", "営業活動支援エージェント")
@instructions("""
**役割**: 営業担当者の提案活動を支援
**情報源**:
- SharePoint の提案書ライブラリ
- Teams の商談履歴
- Web の業界ニュース
""")
namespace SalesAssistant {
  // OneDrive/SharePoint: 提案書検索
  op oneDrive is AgentCapabilities.OneDriveAndSharePoint<ItemsByUrl = [
    { url: "https://company.sharepoint.com/sites/Sales/Proposals" }
  ]>
  
  // Teams Messages: 商談履歴
  op teams is AgentCapabilities.TeamsMessages<TeamsMessagesByUrl = [
    { url: "https://teams.microsoft.com/l/team/19%3Asales-team..." }
  ]>
  
  // WebSearch: 業界トレンド
  op webSearch is AgentCapabilities.WebSearch
  
  // API Plugin: CRM 連携
  op getOpportunities is CRMAPI.getOpportunities;
  op getCustomerHistory is CRMAPI.getCustomerHistory;
}
```

**デモシナリオ:**

1. **類似提案の検索**
   - ユーザー: "製造業向けのDX提案資料はある?"
   - エージェント: SharePoint から過去の提案書を検索・要約

2. **商談準備**
   - ユーザー: "A社との過去の商談内容を教えて"
   - エージェント: CRM + Teams履歴から情報を統合

3. **競合分析**
   - ユーザー: "B社の最新のプレスリリースは?"
   - エージェント: Web検索で最新情報を提供

**ROI の説明:**
- 提案資料作成時間 40% 削減
- 過去資料の再利用率 60% 向上
- 商談準備時間 50% 短縮

---

##### **シナリオ3: HR アシスタント（Human Resources）**

**課題:**
- 従業員からの問い合わせ対応が煩雑
- 人事規程の参照が面倒
- 休暇申請などのプロセスが不明確

**ソリューション:**

```typespec
@agent("HR Assistant", "人事総務アシスタント")
@instructions("""
**役割**: 従業員の人事関連の質問に回答
**対象**:
- 人事規程・ポリシー
- 休暇・福利厚生
- 申請手続き
""")
namespace HRAssistant {
  // SharePoint: 人事規程
  op sharepoint is AgentCapabilities.OneDriveAndSharePoint<ItemsByUrl = [
    { url: "https://company.sharepoint.com/sites/HR/Policies" }
  ]>
  
  // API Plugin: 勤怠システム
  op getLeaveBalance is HRAPI.getLeaveBalance;
  op submitLeaveRequest is HRAPI.submitLeaveRequest;
}
```

**デモシナリオ:**

1. **規程の確認**
   - ユーザー: "育児休暇の取得条件は?"
   - エージェント: 人事規程から該当箇所を抽出・要約

2. **残日数確認**
   - ユーザー: "有給休暇の残りは何日?"
   - エージェント: 勤怠APIで残日数を取得・表示

3. **申請サポート**
   - ユーザー: "来週月曜日に有給を取りたい"
   - エージェント: 申請手続きを案内または代行

**ROI の説明:**
- HR への問い合わせ 50% 削減
- 従業員の自己解決率向上
- 人事担当者の戦略業務への注力

---

#### **3.3 顧客提案時のプレゼンテーション構成**

**推奨スライド構成（30分想定）:**

1. **課題認識（5分）**
   - 現状の業務課題をヒアリング
   - 属人化、情報検索の困難さ、問い合わせ対応負荷など

2. **ソリューション概要（5分）**
   - Declarative Agent + TypeSpec の全体像
   - Microsoft 365 Copilot との統合メリット

3. **技術的優位性（5分）**
   - TypeSpec による開発効率
   - 既存 API の再利用
   - Entra ID によるセキュアな認証

4. **デモンストレーション（10分）**
   - 実際のエージェントを Copilot で動作
   - 会話スターター → API呼び出し → 結果表示
   - リアルタイムでの Instructions 変更とテスト

5. **導入ステップと ROI（5分）**
   - PoC → パイロット → 全社展開の段階
   - 定量的効果（時間削減、コスト削減）
   - 定性的効果（従業員満足度向上）

**デモ準備チェックリスト:**

```powershell
# デモ前の確認スクリプト

Write-Host "=== デモ準備チェックリスト ===" -ForegroundColor Cyan

# 1. エージェントが動作するか
Write-Host "`n[1] エージェント動作確認" -ForegroundColor Yellow
Write-Host "  □ Copilot で表示される"
Write-Host "  □ 会話スターターがクリックできる"
Write-Host "  □ 質問に応答する"

# 2. API が正常動作するか
Write-Host "`n[2] API 動作確認" -ForegroundColor Yellow
Write-Host "  □ API エンドポイントが応答する"
Write-Host "  □ 認証が通る"
Write-Host "  □ サンプルデータが返る"

# 3. バックアッププラン
Write-Host "`n[3] バックアッププラン" -ForegroundColor Yellow
Write-Host "  □ スクリーンショット/動画を準備"
Write-Host "  □ オフラインデモ環境"
Write-Host "  □ 代替シナリオ"

# 4. 環境確認
Write-Host "`n[4] 環境確認" -ForegroundColor Yellow
Write-Host "  □ ネットワーク接続"
Write-Host "  □ Microsoft 365 アカウント"
Write-Host "  □ ブラウザ（Edge/Chrome）"

Write-Host "`n=== デモ準備完了 ===" -ForegroundColor Cyan
```

---

#### **3.4 よくある顧客からの質問と回答**

| 質問 | 技術的回答 | ビジネス的回答 |
|------|----------|--------------|
| **既存システムとの連携は?** | REST API があれば OpenAPI 化で連携可能 | ほとんどの既存システムと連携できます |
| **開発期間は?** | シンプルなエージェント: 1-2週間<br>複雑な統合: 1-2ヶ月 | PoC は 2 週間で可能です |
| **コストは?** | Microsoft 365 Copilot ライセンス費用のみ<br>追加インフラ不要 | ライセンス以外の追加費用なし |
| **セキュリティは大丈夫?** | Entra ID 認証、最小権限の原則<br>組織のポリシー継承 | 御社の既存セキュリティ基盤を利用 |
| **他部門にも展開できる?** | テンプレート化して水平展開可能 | 1つ作れば他部門へ展開容易 |
| **保守は誰が?** | TypeSpec なので IT 部門で保守可能<br>または弊社サポート | 内製化も外部委託も可能 |
| **AI の精度は?** | GPT-4 ベース、Instructions で制御可能 | 90%以上の質問に正確に回答 |

---

### 学習リソースと次のステップ

**推奨学習パス:**

1. **Week 1-2: 基礎理解**
   - 公式ドキュメント精読
   - サンプルプロジェクトの実行
   - 各コンポーネントの役割理解

2. **Week 3-4: 実装体験**
   - カスタムエージェントの作成
   - API Plugin の実装
   - Capability の追加

3. **Week 5-6: 応用と最適化**
   - エンタープライズシナリオの実装
   - パフォーマンス最適化
   - エラーハンドリング強化

4. **Week 7-8: 顧客提案準備**
   - デモ環境構築
   - プレゼン資料作成
   - PoC プランニング

**継続的な学習:**

```powershell
# 学習進捗管理スクリプト

$learningPath = @(
    @{ Phase = "基礎理解"; Status = "完了"; Date = "2026/01/20" },
    @{ Phase = "実装体験"; Status = "進行中"; Date = "2026/01/27" },
    @{ Phase = "応用と最適化"; Status = "未着手"; Date = "" },
    @{ Phase = "顧客提案準備"; Status = "未着手"; Date = "" }
)

Write-Host "`n=== Declarative Agent 学習進捗 ===" -ForegroundColor Cyan
$learningPath | ForEach-Object {
    $status = switch ($_.Status) {
        "完了" { "✓" }
        "進行中" { "⚡" }
        "未着手" { "○" }
    }
    Write-Host "$status $($_.Phase) - $($_.Status) $(if($_.Date){"($($_.Date))"})"
}
```

**コミュニティ活動:**

- [Microsoft Tech Community](https://techcommunity.microsoft.com/) で質問・情報共有
- [GitHub Discussions](https://github.com/microsoft/typespec/discussions) で技術議論
- 社内勉強会の開催（週次/月次）
- ブログ記事の執筆で知識の定着

---

**まとめ: 成功のための3つのポイント**

1. **段階的アプローチ**
   - 小さく始めて、段階的に拡大
   - PoC → パイロット → 全社展開

2. **技術とビジネスの両立**
   - 技術的な深さとビジネス価値の説明を両立
   - デモで「動くもの」を見せる

3. **継続的な学習と改善**
   - フィードバックを基に Instructions を最適化
   - 新しい Capability を定期的に追加
   - コミュニティとの知識共有
