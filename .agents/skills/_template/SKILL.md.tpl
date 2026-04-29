# SKILL: {{NAME}}

名称：{{NAME}}

一句话用途：{{DESC}}

入口路径：.agents/skills/{{NAME}}/SKILL.md

触发条件 / 适用场景：
- 描述该技能的触发条件与典型使用场景。

输入（参数）：
- date (可选)：YYYY-MM-DD，默认当天
- author (可选)：作者标识，默认 "{{AUTHOR}}"

输出：
- 在 memory/ 下创建 memory/YYYY-MM-DD.md（如果不存在则创建）

示例实现（占位）：
请查看 .agents/skills/{{NAME}}/run.sh（如存在）

最后更新：{{DATE}}
