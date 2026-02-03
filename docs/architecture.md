# アーキテクチャ概要

このドキュメントでは、M365 Agents Toolkit + TypeSpec を使った Declarative Agent 開発の全体像を説明します。

## 技術スタック

```
┌─────────────────────────────────────────────────────────────┐
│                    開発者が書くもの                          │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐       │
│  │ TypeSpec     │  │ manifest.json│  │ Adaptive     │       │
│  │ (.tsp)       │  │ (template)   │  │ Cards (.json)│       │
│  └──────────────┘  └──────────────┘  └──────────────┘       │
└─────────────────────────────────────────────────────────────┘
                           │
                           ▼ M365 Agents Toolkit (Provision)
┌─────────────────────────────────────────────────────────────┐
│                    自動生成されるもの                        │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐       │
│  │ OpenAPI      │  │ API Plugin   │  │ Declarative  │       │
│  │ (.yml)       │  │ (.json)      │  │ Agent (.json)│       │
│  └──────────────┘  └──────────────┘  └──────────────┘       │
└─────────────────────────────────────────────────────────────┘
                           │
                           ▼ Microsoft 365
┌─────────────────────────────────────────────────────────────┐
│                    実行環境                                  │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐       │
│  │ Teams        │  │ Copilot Chat │  │ Outlook      │       │
│  │ Developer    │  │ (Web/Teams)  │  │ Office       │       │
│  │ Portal       │  │              │  │              │       │
│  └──────────────┘  └──────────────┘  └──────────────┘       │
└─────────────────────────────────────────────────────────────┘
```

## なぜ TypeSpec を使うのか？

### 直接 JSON を書く場合の課題

Declarative Agent を構成するには、以下の JSON ファイルが必要です：

- `manifest.json` - Teams/M365 アプリ定義
- `declarativeAgent.json` - Copilot エージェント定義
- `*-apiplugin.json` - API Plugin 定義
- `*-openapi.yml` - OpenAPI 仕様

これらを**手動で同期**させるのは困難です。

### TypeSpec による解決

| 直接 JSON を書く場合の課題 | TypeSpec による解決 |
|---------------------------|-------------------|
| 4種類の JSON を手動で同期 | 1つのソースから自動生成 |
| スキーマ変更時に全ファイル修正 | TypeSpec 側で吸収 |
| タイポや型ミスに気づきにくい | コンパイル時にエラー検出 |
| IDE の補完が効きにくい | TypeSpec 拡張機能で補完 |

### TypeSpec の歴史

```
2019: Cadl として Microsoft 内部で開発開始（Azure REST API 仕様記述用）
2022: TypeSpec としてオープンソース化
2024: M365 Copilot 拡張に採用
```

Microsoft は Azure の API 設計ツールを Copilot エコシステムに流用しています。

## 現状の課題

TypeSpec を使った開発には、以下の課題もあります：

| 課題 | 詳細 |
|------|------|
| **学習コスト** | TypeSpec + OpenAPI + Teams Manifest + Declarative Agent の4つの概念を理解する必要 |
| **マッピングの不透明さ** | どの `.tsp` がどの `.json` になるか分かりにくい |
| **デバッグの困難さ** | 問題発生時、TypeSpec か生成 JSON かプラットフォームか特定しにくい |
| **ドキュメント不足** | TypeSpec for M365 Copilot の情報がまだ少ない |

これらの課題に対応するため、[typespec-mapping.md](typespec-mapping.md) で詳細なマッピング情報を提供しています。

## ドキュメントマップ

| 知りたいこと | 参照ドキュメント |
|-------------|----------------|
| プロジェクト概要・前提条件 | [README.md](../README.md) |
| F5 実行時に何が起こるか | [provision.md](provision.md) |
| TypeSpec とファイルの対応関係 | [typespec-mapping.md](typespec-mapping.md) |
| Step 1 の具体的な手順 | [step1.md](step1.md) |

## 関連リンク

- [TypeSpec 公式サイト](https://typespec.io/)
- [TypeSpec for M365 Copilot](https://learn.microsoft.com/en-us/microsoft-365-copilot/extensibility/build-declarative-agents-typespec)
- [Declarative agents for Microsoft 365 Copilot](https://learn.microsoft.com/en-us/microsoft-365-copilot/extensibility/overview-declarative-agent)
