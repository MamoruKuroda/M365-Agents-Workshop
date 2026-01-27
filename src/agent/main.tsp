import "@typespec/http";
import "@typespec/openapi3";
import "@microsoft/typespec-m365-copilot";
import "./actions/github.tsp";
import "./prompts/instructions.tsp";
import "./env.tsp";

using TypeSpec.M365.Copilot.Agents;

@agent(
  "SupportTicketAgent",
  "サポートチケット管理を支援する Declarative Agent です。GitHub の Issue 検索や、組織のナレッジを活用して回答します。"
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
namespace SupportTicketAgent {
  // GitHub API Plugin: Issue 検索機能を有効化
  op searchIssues is global.GitHubAPI.searchIssues;
}