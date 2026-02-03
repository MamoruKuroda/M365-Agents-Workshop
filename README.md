# M365 Agents Workshop

Microsoft 365 Copilot の Declarative Agent を TypeSpec と M365 Agents Toolkit で構築するハンズオンワークショップです。

## 概要

このワークショップでは、GitHub Issue 検索エージェントをベースに、段階的に機能を拡張しながら Declarative Agent の開発を学びます。

## 前提条件

### ライセンス要件

このワークショップを実施するには、以下のライセンスが必要です：

| 要件 | 説明 |
|------|------|
| **Microsoft 365 サブスクリプション** | E3, E5, Business Basic/Standard/Premium 等 |
| **Microsoft 365 Copilot ライセンス** | Microsoft 365 サブスクリプションへの**アドオン**として購入 |

> ⚠️ **重要**: Microsoft 365 Copilot は単体では購入できません。対象となる Microsoft 365 サブスクリプションが必要です。
> 
> 詳細: [Microsoft 365 Copilot のライセンスオプション](https://learn.microsoft.com/ja-jp/copilot/microsoft-365/microsoft-365-copilot-licensing)

### 開発環境

| ツール | バージョン | 備考 |
|-------|----------|------|
| **Node.js** | 18, 20, 22 | LTS 推奨 |
| **Visual Studio Code** | 最新版 | |
| **Microsoft 365 Agents Toolkit** | 5.0.0 以上 | VS Code 拡張機能 |

### テナント設定

| 設定 | 確認場所 | 必要な状態 |
|------|---------|-----------|
| **カスタムアプリのアップロード** | Teams 管理センター > Teams アプリ > セットアップポリシー | 有効 |
| **Copilot アクセス** | Microsoft 365 管理センター | ライセンス割り当て済み |

## 開発環境の基礎知識

### local 環境と dev 環境の違い

| 項目 | local 環境 | dev 環境 |
|------|-----------|----------|
| 起動方法 | F5（デバッグ実行） | Toolkit の Provision コマンド |
| 設定ファイル | `m365agents.local.yml` | `m365agents.yml` |
| 環境変数 | `env/.env.local` | `env/.env.dev` |
| 用途 | 個人開発・テスト | 組織共有・本番 |

👉 **推奨**: 開発・テスト中は常に **local 環境（F5）** を使用してください。

### Provision ワークフローの理解

`m365agents.local.yml` / `m365agents.yml` は **Provision ワークフロー定義ファイル** です。  
GitHub Actions の workflow.yml に相当するもので、以下のアクションが順次実行されます：

```yaml
provision:
  - uses: teamsApp/create           # 1. Teams App を Microsoft 365 に登録
  - uses: cli/runNpmCommand         # 2. npm install
  - uses: cli/runNpmCommand         # 3. env.tsp 生成
  - uses: typeSpec/compile          # 4. TypeSpec コンパイル
  - uses: teamsApp/zipAppPackage    # 5. アプリパッケージ ZIP 作成
  - uses: teamsApp/validateAppPackage # 6. パッケージ検証
  - uses: teamsApp/update           # 7. Teams App 更新
  - uses: teamsApp/extendToM365     # 8. Microsoft 365 への拡張
```

詳細は [docs/provision.md](docs/provision.md) を参照してください。

### TypeSpec コンパイルの出力

`typeSpec/compile` アクションは以下のファイルを生成します：

```
appPackage/.generated/
├── manifest.json           ← ベース manifest + copilotAgents セクション追加
├── declarativeAgent.json   ← @agent, @instructions から生成
├── *-apiplugin.json        ← API Plugin 定義
├── *-openapi.yml           ← OpenAPI 仕様
└── specs/
```

| ファイル | 役割 |
|---------|------|
| `appPackage/manifest.json` | **ベーステンプレート**（基本情報を定義） |
| `appPackage/.generated/manifest.json` | **最終成果物**（TypeSpec コンパイル結果） |

※ TypeSpec を使用しない開発方式では、開発者が `manifest.json` を直接編集します。

### ブラウザキャッシュの問題

エージェント名や説明を変更しても、Copilot Chat に古い情報が表示されることがあります。

**対策:**
- InPrivate / シークレットモードで確認
- 別のブラウザプロファイルを使用
- 複数アカウントでログインしている場合は整理

### APP_NAME_SUFFIX の活用

同じエージェントの複数バージョンを区別するために使用します。

| 設定場所 | 例 |
|---------|-----|
| `env/.env.local` | `APP_NAME_SUFFIX=-v1` |
| `env/.env.dev` | `APP_NAME_SUFFIX=-dev` |

### 確認用コマンド

```powershell
# 設定値の一括確認
Get-Content env/.env.local | Select-String "APP_NAME|TEAMS_APP_ID|M365_APP_ID"

# エージェント名がすべてのファイルで一致しているか確認
Select-String -Path "m365agents*.yml","appPackage/manifest.json","src/agent/main.tsp" -Pattern "GitHubIssueSearch"
```

## ステップ一覧
リポジトリは以下の Step に沿って実装を進めます。
| Step | ブランチ | 内容 | 学習目標 |
|------|---------|------|---------|
| main | `main` | Toolkit テンプレート | プロジェクト構造の理解 |
| 1 | `step-1-activate-github-action` | GitHub Action 有効化 + ConversationStarter | API Plugin の動作確認 |
| 2 | `step-2-add-capabilities` | SharePoint + Teams | M365 データ連携 |
| 3 | `step-3-extend-knowledge` | Email, People, WebSearch | 知識ソースの拡張 |
| 4 | `step-4-full-features` | 全機能 | 実運用レベルの構成 |

## ドキュメント

| ドキュメント | 内容 |
|-------------|------|
| [アーキテクチャ概要](docs/architecture.md) | 技術スタック、なぜ TypeSpec を使うのか |
| [TypeSpec マッピング](docs/typespec-mapping.md) | .tsp と .json の対応関係 |
| [Provision ワークフロー](docs/provision.md) | F5 実行時の処理フロー |
| [Step 1](docs/step1.md) | GitHub Issue 検索エージェントの作成 |

## フォルダ構成

| フォルダ/ファイル | 内容 |
|-----------------|------|
| `src/agent/main.tsp` | エージェント定義のエントリーポイント |
| `src/agent/actions/` | API 定義（API Plugin） |
| `src/agent/prompts/` | 指示（Instructions）定義 |
| `appPackage/` | アプリマニフェストとアイコン |
| `env/` | 環境変数ファイル |
| `m365agents.local.yml` | local 環境の Provision 定義 |
| `m365agents.yml` | dev 環境の Provision 定義 |

## 参考リンク

### 公式ドキュメント
- [Microsoft 365 Copilot のライセンスオプション](https://learn.microsoft.com/ja-jp/copilot/microsoft-365/microsoft-365-copilot-licensing)
- [Declarative agents for Microsoft 365 Copilot](https://learn.microsoft.com/en-us/microsoft-365-copilot/extensibility/overview-declarative-agent)
- [Set up your development environment](https://learn.microsoft.com/en-us/microsoft-365-copilot/extensibility/prerequisites)
- [Build declarative agents with TypeSpec](https://learn.microsoft.com/en-us/microsoft-365-copilot/extensibility/build-declarative-agents-typespec)

### ツール
- [Microsoft 365 Agents Toolkit](https://aka.ms/M365AgentsToolkit)
- [TypeSpec](https://typespec.io/)
