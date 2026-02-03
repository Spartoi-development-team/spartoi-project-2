# AGENTS.md (Repo Contract)

## Non-negotiables (Fail-Closed)
- Write operations are SINGLE-STREAM: one agent writes at a time.
- No force-push, no history rewrite, no automatic conflict resolution.
- Any change must include: (a) what changed, (b) why, (c) how verified.

## Default Workflow
1) Plan first (produce a concise plan)
2) Execute with smallest diff possible
3) Self-check: run the required commands
4) Summarize outputs & next risks

## Required Commands (run before you claim DONE)
- git status --porcelain
- git diff --stat
- (project-specific checks go here)
