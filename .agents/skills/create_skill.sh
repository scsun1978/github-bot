#!/usr/bin/env bash
set -euo pipefail

TEMPLATE_DIR=".agents/skills/_template"
SKILLS_DIR=".agents/skills"

if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <skill-name> \"<one-line-description>\" [author]"
  exit 1
fi

SKILL_NAME="$1"
SKILL_DESC="$2"
AUTHOR="${3:-agent / $(git config user.name || echo scsun1978)}"
NOW="$(date -u +%F)"

TARGET_DIR="${SKILLS_DIR}/${SKILL_NAME}"
if [ -d "$TARGET_DIR" ]; then
  echo "ERROR: skill directory already exists: $TARGET_DIR"
  exit 2
fi

mkdir -p "$TARGET_DIR"

# Helper: render a template file path -> target file path
render() {
  local tpl="$1"
  local dest="$2"
  sed \
    -e "s/{{NAME}}/${SKILL_NAME}/g" \
    -e "s/{{DESC}/$(printf '%s' "$SKILL_DESC" | sed -e 's/[\/&]/\\&/g')/g" \
    -e "s/{{AUTHOR}}/$(printf '%s' "$AUTHOR" | sed -e 's/[\/&]/\\&/g')/g" \
    -e "s/{{DATE}}/${NOW}/g" \
    "$tpl" > "$dest"
}

# Render SKILL.md
if [ -f "${TEMPLATE_DIR}/SKILL.md.tpl" ]; then
  render "${TEMPLATE_DIR}/SKILL.md.tpl" "${TARGET_DIR}/SKILL.md"
fi

# Render run.sh if template exists
if [ -f "${TEMPLATE_DIR}/run.sh.tpl" ]; then
  render "${TEMPLATE_DIR}/run.sh.tpl" "${TARGET_DIR}/run.sh"
  chmod +x "${TARGET_DIR}/run.sh"
fi

# Render action if provided
if [ -f "${TEMPLATE_DIR}/action.yml.tpl" ]; then
  render "${TEMPLATE_DIR}/action.yml.tpl" "${TARGET_DIR}/action.yml"
fi

# Add .gitkeep to keep directory if nothing else
touch "${TARGET_DIR}/.gitkeep"

# Optionally update INDEX.md
INDEX_FILE="${SKILLS_DIR}/INDEX.md"
if [ -f "${TEMPLATE_DIR}/INDEX-entry.tpl" ] && [ -f "${INDEX_FILE}" ]; then
  TMP_ENTRY="$(mktemp)"
  render "${TEMPLATE_DIR}/INDEX-entry.tpl" "${TMP_ENTRY}"
  echo "" >> "${INDEX_FILE}"
  cat "${TMP_ENTRY}" >> "${INDEX_FILE}"
  rm -f "${TMP_ENTRY}"
  git add "${INDEX_FILE}"
fi

# Stage new files and create a commit on current branch (do not push)
git add "${TARGET_DIR}"
git commit -m "Add skill: ${SKILL_NAME} — ${SKILL_DESC}" || echo "No changes to commit"

echo "Skill created at ${TARGET_DIR}"
echo "Next: review files, push branch or open PR as desired."
