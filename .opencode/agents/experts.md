# Experts agent

Role: Specialist worker agents for scanning, testing, and documentation.

providerID: github-copilot
modelID: github-copilot/gpt-4.1

permissions:
  call_omo_agent: false
  allow_tools:
    - read
    - webfetch
  deny_tools:
    - write
    - bash
    - mcp

max_subagent_depth: 0

description: |
  Experts perform specialist analysis and produce artifacts. They are explicitly
  forbidden from delegating to other agents to prevent recursion and privilege
  escalation.
