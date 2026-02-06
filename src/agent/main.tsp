import "@typespec/http";
import "@typespec/openapi3";
import "@microsoft/typespec-m365-copilot";
import "./actions/github.tsp";
import "./prompts/instructions.tsp";
import "./env.tsp";

using TypeSpec.M365.Copilot.Agents;

@agent(
  "ProductEngineeringAgent",
  "Product Engineering チーム向けのアシスタント。GitHub Issue、SharePoint、Teams、Email、組織の人物情報、Web 検索を活用して回答します。"
)
@instructions(Prompts.INSTRUCTIONS)
// Conversation Starters: ユーザーにエージェントの使い方を示すヒント
@conversationStarter(#{
  title: "GitHub Issue を検索",
  text: "M365 Agents Toolkit の最新の Issue を教えて"
})
@conversationStarter(#{
  title: "オープンな Issue 一覧",
  text: "現在オープンになっている Issue は何件ある？"
})
@conversationStarter(#{
  title: "ドキュメントを検索",
  text: "SharePoint にある技術ドキュメントを検索して"
})
@conversationStarter(#{
  title: "Teams の会話を確認",
  text: "Teams で最近共有されたプロジェクト資料について教えて"
})
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
namespace ProductEngineeringAgent {
  // GitHub API Plugin: Issue 検索機能を有効化
  op searchIssues is global.GitHubAPI.searchIssues;

  // OneDrive/SharePoint Capability
  // ⚠️ ワークショップ参加者: 下記URLを自分のSharePointサイトURLに置き換えてください
  // 形式: https://[tenant].sharepoint.com/sites/[sitename]
  op oneDriveAndSharePoint is AgentCapabilities.OneDriveAndSharePoint<ItemsByUrl = [
    { url: "https://m365cpi44038270.sharepoint.com/sites/ProductionDepartment" }
  ]>;

  // Teams Messages Capability
  // ⚠️ ワークショップ参加者: 下記URLを自分のTeamsチームURLに置き換えてください
  // 取得方法: Teams > チーム設定 > チームへのリンクを取得
  op teamsMessages is AgentCapabilities.TeamsMessages<TeamsMessagesByUrl = [
    { url: "https://teams.microsoft.com/l/team/19%3AWim9gpf5w5OFnS_42VCeHzwI_Bbz1gqaHGpZvmpPwo01%40thread.tacv2/conversations?groupId=d75a2f39-48dc-4572-a2cb-cb2ca0643971&tenantId=c2e56432-f0b0-4353-85a2-4454b86676d7" }
  ]>;

  // Email Capability: ユーザーのメールボックスを検索
  op email is AgentCapabilities.Email;

  // People Capability: 組織内の人物情報を検索
  op people is AgentCapabilities.People;

  // WebSearch Capability: Web 検索
  op webSearch is AgentCapabilities.WebSearch;
}