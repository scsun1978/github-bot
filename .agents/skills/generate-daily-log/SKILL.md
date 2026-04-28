# SKILL: generate-daily-log

名称：generate-daily-log

一句话用途：根据 memory/README.md 的模板自动生成当天的 daily 日志文件并在 memory/ 目录中创建初始条目（append-only 的模版头部）。

入口路径：.agents/skills/generate-daily-log/SKILL.md

触发条件 / 适用场景：
- 每日工作开始时快速创建当天的日志文件（例如在每天工作第一件事），避免手动复制模板。
- CI/cron 任务在工作日自动初始化 daily 文件（如果不存在则创建并提交占位条目）。

输入（参数）：
- date (可选)：目标日期字符串，格式 YYYY-MM-DD。默认：当天日期。
- author (可选)：作者标识，默认 "agent / scsun1978"。
- template-path (可选)：使用的模板文件路径，默认 `memory/README.md` 中的模板段或指定模板文件。

输出：
- 在 `memory/` 下创建文件 `memory/YYYY-MM-DD.md`（如果已存在则不覆盖），并写入模板头部（Context/Tasks 栏位等）。
- 返回创建结果（created / existed）和文件路径。

实现要点与示例命令：
- 简单脚本（bash / node / python）流程：
  1. 计算目标日期（默认当天）。
  2. 检查 `memory/YYYY-MM-DD.md` 是否存在；若存在，退出并返回 existed。
  3. 读取 `memory/README.md` 中的模板区块或使用内置模板字符串填充日期与作者。
  4. 写入新文件并 `git add` + `git commit`（commit message："Create daily log: YYYY-MM-DD"）并推送（依据权限/策略）。

示例：Bash 最小实现（伪代码）

```bash
#!/usr/bin/env bash
DATE=${1:-$(date +%F)}
FILE="memory/${DATE}.md"
AUTHOR=${2:-"agent / scsun1978"}
if [ -f "$FILE" ]; then
  echo "existed: $FILE"
  exit 0
fi
cat > "$FILE" <<EOF
日期: ${DATE}
作者: ${AUTHOR}
摘要:
- 

Context:
- 

Tasks:
- - [ ] 

Detailed Notes:
- 

References / Links:
- 
EOF

git add "$FILE"
git commit -m "Create daily log: ${DATE}"
# git push (可选，依权限和策略)

echo "created: $FILE"
```

权限与安全：
- 脚本在自动提交时需要拥有写仓库权限（PAT 或 CI runner 的权限），请确保不在脚本中写入明文凭证。推荐使用 CI secret 或自托管 runner 的安全令牌。

维护与扩展建议：
- 将脚本放在 `.agents/skills/generate-daily-log/run.sh` 或 `scripts/` 目录，并在 SKILL.md 中引用。
- 可选：把创建操作包装为 GitHub Action，配置每天（工作日）运行并在创建时打开一个 PR（如果需要人工审查）或直接提交（若允许）。
- 在 .agents/skills/INDEX.md 中确保有对应条目（已存在）。

来源 / 版权：
- 作者：agent / scsun1978
- 许可：遵循仓库许可（若无则默认 MIT 风格说明可选）。

最后更新：2026-04-28
