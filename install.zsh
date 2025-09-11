#!/usr/bin/env -S zsh -f
set -eu -o pipefail

readonly INSTALL_FILE="zsh_macros"

[[ -f "$INSTALL_FILE" ]] || exit 1
if command -v realpath >/dev/null 2>&1; then
  abs=$(realpath "$INSTALL_FILE")
else
  abs="$(cd "$(dirname "$INSTALL_FILE")" 2>/dev/null && pwd)/$(basename $INSTALL_FILE)"
fi
zshrc="${ZDOTDIR:-$HOME}/.zshrc"
[[ -f $zshrc ]] || touch "$zshrc"
grep -Fqx "[[ -f \"$abs\" ]] && source \"$abs\"" "$zshrc" || printf '\n[[ -f "%s" ]] && source "%s"\n' "$abs" "$abs" >> "$zshrc"
