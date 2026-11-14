# Handover

Where the work stands and what's next. Rewritten at the end of every work session, so the next session (mine, the AI co-pilot's, or the mentor's) starts from here instead of from memory.

**Last updated:** 2026-11-14

## Where It Stands

- **Project 1** is in progress. All six tables are profiled; the data dictionary and data quality report are written; row counts verify.
- **Decisions:** 7 proposed, 2 decided, 4 open (see [`design-decisions.md`](design-decisions.md)).
- **Repo:** PRD at v0.2. The original database is published unchanged in [`../data/`](../data/README.md) with a checksum (D-13).

## Waiting On

| Item | From | Blocks |
|---|---|---|
| What period `shopify_sales` covers | Mentor | Any "this season" claim; Project 3 |
| What period `referrals` covers | Mentor | Channel results in Project 4 |
| Whether Blackbox and Secret Hitler are in scope | Mentor | D-11; Project 5 |
| Whether a blank referrer means Direct | Mentor | D-08; Project 2 |

## Next Session

1. Confirm or change the proposed decisions (D-01, D-02, D-03, D-04, D-06, D-07, D-10).
2. Run the Project 1 checks in [`submission-gate.md`](submission-gate.md) and submit.
3. Start Project 2 with D-03 (product key) and D-08 (channel mapping).

## Watch Out For

- Count checkouts with `COUNT(DISTINCT name)`, not rows.
- Never add up Meta `results` across result types.
- State the period beside every figure.
- Never edit `data/breaking_games.db`. Work on a copy.
