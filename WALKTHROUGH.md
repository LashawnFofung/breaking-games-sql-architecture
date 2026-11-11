# Walkthrough

The project step by step: what I had, what I asked, what I decided, and what changed my mind. Fill in each step as the project runs; Project 1 is done.

## Project 1: Load and explore ✅

**Had:** six CSVs loaded into `breaking_games.db`.
**Asked first:** "What decision will this data drive?" The answer framed everything: print quantities and Q4 spend before Black Friday.
**Did:** profiled every column with Claude; wrote [`docs/data-quality-report.md`](docs/data-quality-report.md) and [`sources.json`](sources.json).
**Decided:** D-01, D-02, D-04, D-06, D-07, D-10, D-12 (see the [decision log](docs/decision-log.md)).
**What surprised me:** no two tables share an ID, and only August 2026 overlaps across orders, checkouts and Meta. That ruled out ROAS and a true abandonment rate before I wrote a single analysis query ([`rejected.md`](rejected.md)).
**Early signals:** the top 20% of products bring in 79.5% of sales; Google and Facebook send similar traffic but Google drives about 2.5x more checkout sessions.

## Project 2: Design the database

**Had:**
**Asked first:** How do six unlinked tables become one model without inventing links?
**Decided:** D-03 (product key), D-08 (channel mapping)
**What changed my mind:**
**Validation:** unmatched-row count in the order-to-product join =

## Project 3: What's actually selling

**Asked first:** Is Mike asking "what to print most of" or "what matters most"? (D-05)
**Decided:**
**Finding:**

## Project 4: Which marketing is working

**Asked first:**
**Decided:**
**Finding:**

## Project 5: Abandoned carts and bots

**Asked first:**
**Decided:** D-09 (bot rule): threshold = , carts removed = , dollars removed =
**Finding:**

## Project 6: Dashboard and recommendation

**Asked first:** Which three decisions does leadership need to make this week?
**Built:** tiles from [`docs/dashboard-decision-spec.md`](docs/dashboard-decision-spec.md)
**Recommendation:** (also written into `PRD.md` section 10)

## Retro

- What I'd change:
- What I'd build with two more weeks:
- Which decision I'd revisit first, and the trigger that would make me:
