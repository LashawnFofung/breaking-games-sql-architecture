# Retro

What each project taught me, and the rule it adds. A lesson only counts once it changes something: a new line in [`../CLAUDE.md`](../CLAUDE.md), a decision, or the way I start the next project.

## How Each Entry Works

| Field | What goes in it |
|---|---|
| What went well | Keep doing it |
| What went wrong | The specific moment, not a general feeling |
| Rule it adds | The exact line added to `CLAUDE.md` or `design-decisions.md`, with the date |
| Do differently next time | One change, not five |

## Project 1 — Load and Explore the Raw Data

- **What went well:** Asking which decision the data drives before running any query. No blockers: the course documents were accessible and SQLite and DB Browser set up without problems.
- **What went wrong:** Nothing blocked the work. Near misses instead: two course queries would have reached Mike misleading as written. The units top 10 includes two $0 gift-wrap items, and the "average results per campaign" mixes reach with purchases.
- **Rule it adds:** Count checkouts with `COUNT(DISTINCT name)` (added to `CLAUDE.md` 2026-11-10, after 1,579 rows turned out to be 1,197 checkouts). Exclude $0 items from unit rankings, and check spend before reading a blank Meta result as "never ran" (both added to `CLAUDE.md` 2026-11-14).
- **Do differently next time:** Ask the mentor what period `shopify_sales` covers in the first live session. It's still open and blocks any "this season" claim in Project 3.
## Project 2 — Design a Connected Database

- **What went well:**
- **What went wrong:**
- **Rule it adds:**
- **Do differently next time:**

## Project 3 — Find Out What's Actually Selling

- **What went well:**
- **What went wrong:**
- **Rule it adds:**
- **Do differently next time:**

## Project 4 — See Which Marketing Is Working

- **What went well:**
- **What went wrong:**
- **Rule it adds:**
- **Do differently next time:**

## Project 5 — Investigate Why Carts Get Abandoned

- **What went well:**
- **What went wrong:**
- **Rule it adds:**
- **Do differently next time:**

## Project 6 — Build a Dashboard and Make a Recommendation

- **What went well:**
- **What went wrong:**
- **Rule it adds:**
- **Do differently next time:**

## Final Retro

- **What I'd change:**
- **What I'd build with two more weeks:**
- **The decision I'd revisit first, and what would trigger it:**
