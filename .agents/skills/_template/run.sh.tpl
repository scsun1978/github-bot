#!/usr/bin/env bash
set -euo pipefail

DATE=${1:-$(date -u +%F)}
AUTHOR=${2:-"{{AUTHOR}}"}
FILE="memory/${DATE}.md"

mkdir -p memory

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
echo "created: $FILE"
