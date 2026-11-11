# Submission Gate

The go/no-go check before submitting each project. Nothing is submitted until every line has evidence, not just a tick. Silence is not a go.

## Every Project

| Check | Evidence |
|---|---|
| The business question and the decision it informs are written at the top of the SQL file | File and line |
| Every figure names its period, or states its time assumption | Metric and period |
| Every new choice with a real alternative is in [`design-decisions.md`](design-decisions.md) | Decision IDs |
| No rule in [`../CLAUDE.md`](../CLAUDE.md) is broken | Spot-check: checkout counts, shipping rows, Meta `results` |
| Key numbers were re-run and match what's written | Query and result |
| Anything left out is in [`../rejected.md`](../rejected.md) | Entry |
| [`../WALKTHROUGH.md`](../WALKTHROUGH.md) section is filled in | Section |
| [`../PRD.md`](../PRD.md) is rewritten if anything in it changed | Section |
| No `.db` or `.csv` file is staged in Git | GitHub Desktop changes list |

## Project-Specific Checks

| Project | Extra check |
|---|---|
| 1 — Load and explore | Row counts match: 116, 277, 1,579, 4,450, 42, 102 |
| 2 — Connected database | Zero unmatched order lines after the product mapping (D-03); every referrer belongs to a channel (D-08) |
| 3 — What's selling | The "top seller" definition is decided (D-05); the ranking uses `net_sales` (D-01) |
| 4 — Marketing | Meta results compared only within one result type (D-02); ROI shows its time assumption (D-06) |
| 5 — Abandoned carts | The bot rule and how many carts and dollars it removed are logged (D-09) |
| 6 — Dashboard | Every tile matches [`dashboard-decision-spec.md`](dashboard-decision-spec.md); the "What this doesn't show" note is on the page |

## Log

| Project | Date | Go / No-go | Notes |
|---|---|---|---|
| 1 | | | |
| 2 | | | |
| 3 | | | |
| 4 | | | |
| 5 | | | |
| 6 | | | |
