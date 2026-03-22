# prstack

`prstack` is a Codex-native workflow stack inspired by `gstack`, with optional Ralph loop integration.

It provides:

- repo-local planning and task state
- review, QA, product, security, and architecture review reports
- bounded autonomous build loops through Ralph
- simple file-based templates that are easy to inspect and customize

## Repository Shape

- `bin/prstack`: CLI
- `templates/`: markdown state and report templates
- `roles/`: specialist role briefs
- `ralph/`: optional Ralph loop assets
- `examples/`: example project configs

## Commands

From a project root:

```bash
/path/to/prstack/bin/prstack bootstrap
/path/to/prstack/bin/prstack install
/path/to/prstack/bin/prstack dev
/path/to/prstack/bin/prstack plan "Slice Title"
/path/to/prstack/bin/prstack slice "Slice Title"
/path/to/prstack/bin/prstack ralph-install
/path/to/prstack/bin/prstack ralph-ping
/path/to/prstack/bin/prstack loop 1 --no-commit
/path/to/prstack/bin/prstack ceo-review
/path/to/prstack/bin/prstack security-review
/path/to/prstack/bin/prstack architect-review
/path/to/prstack/bin/prstack review
/path/to/prstack/bin/prstack qa
/path/to/prstack/bin/prstack ship
/path/to/prstack/bin/prstack handoff
/path/to/prstack/bin/prstack status
```

## Project Config

`prstack` reads project commands from `.prstack/project.env` in the target repo:

```bash
INSTALL_CMD="npm run setup:all"
DEV_CMD="npm run dev"
FRONTEND_BUILD_CMD="cd frontend && npm run build"
BACKEND_TEST_CMD="cd backend && uv run --with pytest pytest -q"
QA_CMD="cd backend && uv run python smoke.py"
RALPH_ENABLED="true"
PROJECT_NAME="city_expansion_sim"
PROJECT_DOMAIN="city strategy simulation"
PRODUCT_POSITIONING="Build a city-growth simulator that feels like a strategy product rather than a static demo"
SECURITY_POSTURE="Local prototype is acceptable; hosted deployment still needs stricter controls"
ARCHITECTURE_DECISIONS="District-based world model is the shipping core"
RALPH_PRD_PATH=".agents/tasks/prd.json"
```

See [project.env.example](/home/prithiv/Prithiv_Projects/prstack/examples/city-expansion-sim/project.env.example).

## Ralph

`prstack` keeps Ralph bounded and subordinate:

- `prstack` owns workflow and reporting
- Ralph is an optional execution loop inside that workflow
- `prstack loop 1` is the intended autonomous path, not an open-ended loop
- the bundled loop reads a PRD, selects the next `todo` story, runs one bounded agent execution, and marks it done only after the completion signal

Install the bundled Ralph assets into a project with:

```bash
/path/to/prstack/bin/prstack ralph-install
```

## Notes

- state is stored under `.prstack/state`
- reports are markdown, not hidden binary metadata
- specialist roles are built in through `ceo-review`, `security-review`, and `architect-review`
- projects can override templates or extend the generated state after bootstrap
