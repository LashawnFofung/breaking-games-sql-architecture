# Walkthrough

Project by project: what I had, what I asked first, what I decided, and what changed my mind. Each section is filled in as the project finishes.

## Project 1 — Load and Explore the Raw Data

**Status:** In progress

**Had:** six exports loaded into `breaking_games.db`.

**Asked first:** "What decision will this data drive?" The answer framed everything after it: print quantities and Q4 marketing spend before Black Friday.

**Did:** profiled every table and column with Claude; wrote [`docs/data-dictionary.md`](docs/data-dictionary.md) and [`docs/data-quality-report.md`](docs/data-quality-report.md); verified row counts with [`sql/01_exploration.sql`](sql/01_exploration.sql).

**Decided:** D-01, D-02, D-04, D-06, D-07, D-10 and D-12 (see [`docs/design-decisions.md`](docs/design-decisions.md)).

**What surprised me:** no two tables share an ID, and only August 2026 overlaps across orders, checkouts, and Meta. That shaped how ROI and the abandonment rate can be reported before I wrote a single analysis query ([`rejected.md`](rejected.md)).

**Early signals:** the top 20% of products bring in 79.5% of total sales. Google and Facebook send similar traffic (about 210K pageviews each), but Google drives about 2.5 times as many checkout sessions.

## Project 2 — Design a Database That Connects the Data

**Asked first:** How do six unlinked tables become one model without inventing links?

**Decided:** D-03 (product key), D-08 (channel mapping)

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
