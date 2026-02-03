# CLAUDE.md

Permanent behavior constraints
- Prefer evidence over guesswork: verify with gh API or local files when uncertain.
- Avoid making irreversible or privileged changes without explicit permission and PR review.

Security and supply-chain
- Pin GitHub Actions major/minor versions where possible; prefer exact action refs.
- Avoid piping remote scripts directly to a shell (no `curl | bash`).

Speed and minimal-change policy
- Prefer smallest patch that accomplishes the goal.
- If CI slows, add caching layers (pip/npm/local binaries) but do not reduce gates coverage or make checks optional.
