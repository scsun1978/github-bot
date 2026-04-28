# memory/ — 说明与每日记录模板

目录与用途
- 本目录用于存放短期/过程性记录（按日期归档）以及按主题的持久条目（`memory/persistent/`）。
- 约定：
  - 当日/临时记录：`memory/YYYY-MM-DD.md`（每天一个文件，append-only）
  - 持久专题：`memory/persistent/<topic>.md`（按主题分文件）
  - 附件/大文件：`memory/attachments/`（将原始输出或大文件放入此目录，并在当日记录中写索引链接）

核心原则（与 AGENTS.md 一致）
- 文件即记忆：重要信息必��写入仓库文件；不要依赖未落盘的会话上下文。
- 分层记忆：长期信息写入 `MEMORY.md`；当日/过程性信息写入 `memory/YYYY-MM-DD.md`。
- 日志为追加式：历史不被覆盖；如需更正，追加更正记录并注明时间与理由。
- 任务以“轻量列表 + 日志链接”管理，默认记录在当日文件的 Tasks 区块（参见 AGENTS.md 的 Tasks 约定）。

每日记录模板（复制/粘贴到 `memory/YYYY-MM-DD.md`）
```
日期: YYYY-MM-DD
作者: agent / <你的名字>
摘要:
- 一句话总结今天或本次记录的要点。

Context:
- 当前背景 / 任务来源（Issue/对话/PR 链接/简述）。

Tasks:
- - [ ] 任务 A（描述，关联 Issue/文件/链接）
- - [x] 已完成任务 B（产物：文件路径 / commit / PR 链接）

Detailed Notes:
- 任务 A:
  - 描述:
  - 关键命令 / 代码片段:
  - 结果 / 测试:
  - 风险 / 影响:
- 决策:
  - 决策内容与原因（如需长期保留，请标注“PROMOTE -> MEMORY.md”）

待办与后续:
- TODO 1: 负责人 / 预期完成时点
- TODO 2: ...

References / Links:
- 相关 Issue / PR / 文件 / 外部链接
```

写作与使用建议
- 简洁优先：记录关键事实、决策与产物链接；大段原始输出放到 `memory/attachments/` 并在日志写索引。
- 收尾动作：每次任务完成后在当天日志勾选并写产物链接；如有长期价值标注并迁移到 `MEMORY.md`（参见 AGENTS.md 的收尾 checklist）。
