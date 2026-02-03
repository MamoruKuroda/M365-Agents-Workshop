import "@typespec/http";
import "@typespec/openapi3";
import "@microsoft/typespec-m365-copilot";
import "./actions/github.tsp";
import "./prompts/instructions.tsp";
import "./env.tsp";

using TypeSpec.M365.Copilot.Agents;

@agent(
  "GitHubIssueSearch",
  "GitHub Issue を検索・表示する Declarative Agent です。M365 Agents Toolkit で構築されたサンプルです。"
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
namespace GitHubIssueSearch {
  // GitHub API Plugin: Issue 検索機能を有効化
  op searchIssues is global.GitHubAPI.searchIssues;
}