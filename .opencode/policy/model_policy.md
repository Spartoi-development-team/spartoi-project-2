# Model Policy (Fail-Closed)

Default:
- model: github-copilot/gpt-5-mini
- small_model: github-copilot/gpt-5-mini

Escalation (opt-in, auditable):
- Only escalate when `OPENCODE_ESCALATE_MODEL` is explicitly set by the operator (human or acceptance script).
- Every run must write evidence of:
  - requested model id
  - actual stdout proof ("OK <model_id>")
  - exit code

Rationale:
- On paid Copilot plans, GPT-5 mini is an included model and does not consume premium requests.
- Pinning small_model prevents silent premium burn in background / small tasks.
