# .agents/skills/INDEX.md — Skills Registry (项目级)

目的：快速发现可复用技能、避免重复安装、记录来源便于维护。
规则：新增/安装技能后必须更新此索引（1 行也行）。

- **skill-name**：一句话用途  
  - 入口：`.agents/skills/skill-name/SKILL.md`  
  - 适用：触发条件 / 典型任务  
  - 来源：GitHub / Skills.sh 链接（可选但推荐）

示例（模板）：

- **generate-daily-log**：根据模板生成当日日志文件并在 memory/ 中创建条目  
  - 入口：`.agents/skills/generate-daily-log/SKILL.md`  
  - 适用：每天初始化工作空间、自动创建 daily 文件  
  - 来源：本地实现（自建）

说明：这是一个超轻量的索引，目的是让技能发现与维护变得简单可靠。每次新增技能时请顺手更新本文件（即便只有一行）。
