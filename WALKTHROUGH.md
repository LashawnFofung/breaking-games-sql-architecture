# Walkthrough

Project by project: what I had, what I asked first, what I decided, and what changed my mind. Each section is filled in as the project finishes.

## Project 1 — Load and Explore the Raw Data

**Status:** Complete (submitted 2026-11-14)

**Had:** six exports loaded into `breaking_games.db`.

**Asked first:** "What decision will this data drive?" The answer framed everything after it: print quantities and Q4 marketing spend before Black Friday.

**Did:** profiled every table and column with Claude; wrote [`docs/data-dictionary.md`](docs/data-dictionary.md) and [`docs/data-quality-report.md`](docs/data-quality-report.md); built Mike's top-10 reorder list; found and previewed the `game`/`Game` fix; tested blank vs zero in Meta results; answered Mike's five Monday questions. All queries are in [`sql/01_exploration.sql`](sql/01_exploration.sql).

**Decided:** D-12 (counting checkouts) and D-13 (publishing the database). **Proposed, awaiting the mentor:** D-01, D-02, D-04, D-06, D-07 and D-10 (see [`docs/design-decisions.md`](docs/design-decisions.md)).

**What surprised me:** no two tables share an ID, and only August 2026 overlaps across orders, checkouts, and Meta. That shaped how ROI and the abandonment rate can be reported before I wrote a single analysis query ([`rejected.md`](rejected.md)).

**Early signals:** the top 20% of products bring in 79.6% of net sales. Google and Facebook send similar traffic (about 210K pageviews each), but Google drives about 2.5 times as many checkout sessions. Two free gift-wrap items made the top 10 by units, which is why the reorder list ranks by revenue.

**Five instant answers:** 116 products; $98,542.56 in Meta spend (only 16 of 42 campaigns spent anything); 1,197 checkout sessions, not 1,579 rows. Mike's Monday questions now take seconds instead of about two hours.

## Project 2 — Design a Database That Connects the Data

**Asked first:** How do six unlinked tables become one model without inventing links?

**Decides:** D-03 (product key), D-08 (channel mapping)

**What changed my mind:**

**Check:** unmatched order lines after the product mapping =

## Project 3 — Find Out What's Actually Selling

**Asked first:** Is Mike asking "what do we print the most of" or "what matters most"? (D-05)

**Decided:**

**Finding:**

## Project 4 — See Which Marketing Is Working

**Asked first:** How far can ROI be claimed when sales and ad data cover different periods?

**Decided:**

**Finding:**

## Project 5 — Investigate Why Carts Get Abandoned

**Asked first:** Where is the line between a bulk buyer and a bot?

**Decided:** D-09 (bot rule): threshold = , carts removed = , dollars removed =

**Finding:**

## Project 6 — Build a Dashboard and Make a Recommendation

**Asked first:** Which few decisions does leadership need to make this week?

**Built:** the tiles in [`docs/dashboard-decision-spec.md`](docs/dashboard-decision-spec.md)

**Recommendation:** (also written into [`PRD.md`](PRD.md))
