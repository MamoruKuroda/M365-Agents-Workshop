# Step 1: GitHub Issue 検索エージェントの作成

## このステップで学ぶこと

- Declarative Agent プロジェクトの構造理解
- TypeSpec によるエージェント定義
- API Plugin の基本設定
- local 環境（F5）での動作確認

## 前提条件

このステップを開始する前に、以下が完了していることを確認してください：

- [ ] Node.js 18/20/22 がインストールされている
- [ ] VS Code がインストールされている
- [ ] Microsoft 365 Agents Toolkit 拡張機能がインストールされている
- [ ] Microsoft 365 Copilot ライセンスが割り当てられている

---

## 方法A: このリポジトリを使う（推奨）

このリポジトリを clone した場合、プロジェクトは既にセットアップ済みです。  
**「1.1 プロジェクトの確認」に進んでください。**

```bash
git clone https://github.com/MamoruKuroda/M365-Agents-Workshop.git
cd M365-Agents-Workshop
npm install
```

---

## 方法B: ゼロから作成する場合

### 0.1 M365 Agents Toolkit のインストール

1. VS Code を開く
2. 拡張機能パネル（Ctrl+Shift+X）を開く
3. 「**Microsoft 365 Agents Toolkit**」を検索
4. **インストール** をクリック

### 0.2 新規プロジェクトの作成

1. VS Code のサイドバーで **M365 Agents Toolkit アイコン** をクリック
2. **Create a New Agent/App** をクリック
3. **Declarative Agent** を選択
4. **Start with TypeSpec for Microsoft 365 Copilot** を選択
5. Application Name に `SupportTicketAgent` と入力
6. フォルダを選択して作成

> ⚠️ このテンプレートには GitHub Issue 検索の API Plugin が既に含まれています。

---

## 手順

### 1.1 プロジェクトの確認

プロジェクト（clone または作成後）のフォルダ構成を確認します：

```
SupportTicketAgent/
├── src/agent/
│   ├── main.tsp          ← エージェント定義のエントリーポイント
│   ├── env.tsp           ← 環境変数（自動生成）
│   ├── actions/
│   │   └── github.tsp    ← API Plugin 定義
│   └── prompts/
│       └── instructions.tsp  ← エージェントへの指示
├── appPackage/
│   ├── manifest.json     ← アプリマニフェスト（テンプレート）
│   └── adaptiveCards/    ← レスポンス表示用カード
├── env/
│   └── .env.local        ← 環境変数
├── m365agents.local.yml  ← local 環境の Provision 定義
└── m365agents.yml        ← dev 環境の Provision 定義
```

### 1.2 エージェント名の設定

エージェント名を変更する場合、以下の **4箇所を編集** します：

| 編集するファイル | 設定箇所 | 役割 |
|-----------------|---------|------|
| `m365agents.local.yml` | `teamsApp/create` の `name` | Microsoft 365 へのアプリ登録名 |
| `m365agents.yml` | `teamsApp/create` の `name` | 同上（dev 環境用） |
| `appPackage/manifest.json` | `name.short` | アプリパッケージ内の表示名 |
| `src/agent/main.tsp` | `@agent()` デコレータ | Declarative Agent の名前 |

> ⚠️ **注意**: `appPackage/.generated/` 配下のファイルは**編集しないでください**。
> これらは TypeSpec コンパイルの出力結果であり、編集しても次回コンパイル時に上書きされます。

### 1.3 Provision（F5）の実行

1. VS Code で F5 キーを押す（またはデバッグ実行）
2. ブラウザが自動で開き、Microsoft 365 にサインイン
3. Copilot Chat が開く
4. エージェント一覧から作成したエージェントを選択

Provision の詳細な処理フローは [docs/provision.md](provision.md) を参照してください。

### 1.4 動作確認

1. Copilot Chat でエージェントを選択
2. 会話スターターをクリック、または質問を入力
3. GitHub Issue の検索結果が表示されることを確認

**確認用の質問例：**
- 「M365 Agents Toolkit の最新の Issue を教えて」
- 「現在オープンになっている Issue は何件ある？」

## ⚠️ トラブルシューティング

### エージェント名の確認方法

コンパイル後、以下のコマンドで生成されたファイルの名前を確認します：

```powershell
# 生成された manifest.json の名前を確認
Get-Content "appPackage/.generated/manifest.json" | Select-String '"short"'

# 生成された declarativeAgent.json の名前を確認
Get-Content "appPackage/.generated/declarativeAgent.json" | Select-String '"name"'
```

### なぜ複数箇所に名前があるのか？

| 名前 | 用途 |
|-----|------|
| yml の `teamsApp/create` name | **初回登録時**に Microsoft 365 に登録されるアプリ名 |
| manifest.json の `name.short` | **更新時**にパッケージに含まれるアプリ名 |
| main.tsp の `@agent()` | **Copilot Chat 内**で表示されるエージェント名 |

これらが不一致だと、Teams アプリ一覧と Copilot Chat で異なる名前が表示される可能性があります。

### ID リセットの手順

新しいエージェントとして再登録したい場合は、`env/.env.local` から以下の ID をクリアします：

```dotenv
TEAMS_APP_ID=
M365_APP_ID=
M365_TITLE_ID=
TEAMS_APP_TENANT_ID=
```

その後、F5 で再度 Provision を実行すると新規登録されます。

### TypeSpec の import と依存関係

yml ファイルには `main.tsp` のみ指定されています。  
他の `.tsp` ファイルは `import` 文で再帰的に読み込まれます：

```typespec
// main.tsp
import "./actions/github.tsp";      // ← コンパイラが自動で読み込む
import "./prompts/instructions.tsp";
import "./env.tsp";
```

### ブラウザキャッシュの問題

エージェント名や説明を変更しても、Copilot Chat に古い情報が表示されることがあります。

**対策:**
- InPrivate / シークレットモードで確認
- 別のブラウザプロファイルを使用
- 複数アカウントでログインしている場合は整理

## 完了チェックリスト

- [ ] エージェントが Copilot Chat に表示される
- [ ] GitHub Issue 検索が動作する
- [ ] 会話スターターが表示される
- [ ] Adaptive Card で検索結果が表示される

## 次のステップ

[Step 2: SharePoint + Teams Capabilities の追加](step2.md)
