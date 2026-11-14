# Breaking Games — SQL & Database Architecture

SQL and database architecture project for **[Breaking Games](https://breakinggames.com)**, completed through the **Extern, Inc.** SQL & Database Architecture Externship (8 weeks, starting November 2026).

> **Start here:** [`PRD.md`](PRD.md) is the one living proposal for this project. Every other document supports a decision in it.

## About Breaking Games

Breaking Games is an indie tabletop game publisher in Netcong, New Jersey, and the publishing arm of Ad Magic, Inc. It sells everything from $10 party games like POOP and Sparkle*Kitty to $99+ strategy boxes like Dwellings of Eldervale. Ad Magic also manufactures and fulfills games for other publishers, including Cards Against Humanity.

## The Problem

Breaking Games' direct-to-consumer (Shopify) business runs on six disconnected data exports stitched together in a spreadsheet. None of the files share an ID, so basic questions take hours to answer by hand:

- Which of 100+ products actually make money, and what should be restocked before the holiday print-run deadline?
- Is the Meta (Facebook/Instagram) ad spend paying off, and where should the budget go next?
- How many abandoned carts are real shoppers, and how many are bots?

This project turns those exports into a connected, analytics-ready database and a recommendation the team can act on.

## Who This Is For

| Reader | Decision they make | What they need from this project |
|---|---|---|
| Mike Bradley, Head of E-Commerce | How many units of each title to print for the holiday | A product ranking with the time period it covers stated plainly |
| Jess Walker, Senior Marketing Ops | Which channels get the Q4 marketing budget | Channel results compared on a common footing |
| Shari Spiro, founder | Whether the holiday plan is worth the cash it ties up | One page: the recommendation, the evidence, and the risk |
| Reviewers and hiring managers | Whether the analysis can be trusted | Every number traceable to a rule, and every rule to a decision |

## How I Work

Claude drafts and cross-checks the SQL. I decide what question to answer, what the data can honestly support, and what to leave out. This repo records those decisions, not only the queries.

- **One living proposal.** [`PRD.md`](PRD.md) is rewritten when something changes, never appended to. Git keeps the history.
- **Every judgment call is logged.** [`docs/design-decisions.md`](docs/design-decisions.md) records the options, my pick, the trade-off, and what would make me reopen it.
- **What I chose not to do is written down too.** [`rejected.md`](rejected.md) lists each cut and why.
- **Numbers keep their receipts.** Each figure points to the query, table, and date that produced it.
- **The AI co-pilot follows written rules.** [`CLAUDE.md`](CLAUDE.md) holds the data traps found so far, so they aren't relearned every session.
- **Nothing is submitted without a check.** [`docs/submission-gate.md`](docs/submission-gate.md) is the go/no-go list for each project.

## Data Sources

All data comes from Shopify and Meta Ads Manager and is anonymized (customer names and emails are placeholders). Wholesale and Kickstarter sales are out of scope.

The original database is included, unchanged, in [`data/`](data/README.md), with a checksum and a privacy note, so every query can be re-run from the same starting point (D-13).

| Table | Source | Rows | What it holds | Date range |
|---|---|---:|---|---|
| `shopify_sales` | Shopify | 116 | Revenue, units, discounts, and returns per product | Summary |
| `shopify_orders` | Shopify | 277 | One row per order line item, plus shipping rows | Aug 2026 |
| `shopify_checkouts` | Shopify | 1,579 | Checkouts, including abandoned carts | Oct 2016 – Oct 2026 |
| `referrals` | Shopify Analytics | 4,450 | Traffic source, landing page, and conversion metrics | — |
| `meta_campaigns` | Meta Ads Manager | 42 | Campaign-level ad performance and spend | Jan 2025 – Sep 2026 |
| `meta_ad_sets` | Meta Ads Manager | 102 | Ad-set-level performance (campaigns contain ad sets) | Jan 2025 – Sep 2026 |

Column-by-column definitions are in [`docs/data-dictionary.md`](docs/data-dictionary.md), and what each table can and can't be trusted for is in [`docs/data-quality-report.md`](docs/data-quality-report.md).

### Known data quirks

- **No shared keys.** Tables can only be linked by product title (which has variants and typos) or by cleaned-up traffic source.
- **Inconsistent values,** such as `Game` vs `game` in `shopify_sales.product_type`.
- **NULL vs zero.** Blank results in the Meta tables mean "not recorded," not zero, which changes averages.
- **Pipe-delimited product names,** such as `Expancity | Family Strategy City Building Game | 2-4 Players`.
- **Mismatched date windows** across files.
- **Bot-like checkouts** that inflate abandoned-cart counts.
- **Shipping rows in orders.** Each order has a separate shipping line with a blank product title.
- **Multi-line checkouts.** Only the first row of a checkout carries its totals, so checkouts are counted with `COUNT(DISTINCT name)`, not `COUNT(*)` (1,197 checkouts across 1,579 rows).
- **Meta "results" mean different things.** Purchases for some campaigns, landing page views or reach for others, so they are only compared within the same result type.
- **No dates in `shopify_sales` or `referrals`.** They can rank products and sources, but not say when sales or visits happened.

## Project Roadmap

| # | Project | Outcome | Key judgment call |
|---|---|---|---|
| 1 | Load and explore the raw data | Database verified; first queries against real revenue data | Which quirks to fix, which to flag, and which to ask the mentor about |
| 2 | Design a database that connects the data | Tables, primary/foreign keys, and joins from ad click to purchase | How to key products and group traffic sources when no IDs are shared |
| 3 | Find out what's actually selling | Product revenue ranking, summary tables, restock recommendation | Whether "top seller" means revenue or units |
| 4 | See which marketing is working | Traffic sources cleaned into channels; ad and channel ROI | How far ROI can be claimed when sales and ad data cover different periods |
| 5 | Investigate why carts get abandoned | Bot filtering and a true abandonment rate | Where to draw the bot line, and what period the rate covers |
| 6 | Build a dashboard and make a recommendation | Shareable HTML dashboard and final recommendation | Which few tiles earn a place, each tied to a decision |

> **A note on Projects 2, 4 and 5:** the data has no customer or order link to a campaign, and the sales, orders, and ad tables cover different periods. Ad-to-purchase joins, ROI, and the abandonment rate are built at the channel level, with the time assumption stated next to every figure. See [`rejected.md`](rejected.md) and decisions D-06 and D-07.

## Product Judgment Artifacts

Alongside the database, each project produces a short written record of the decisions behind it.

| Artifact | What it answers | When it's written |
|---|---|---|
| [`PRD.md`](PRD.md) | What are we trying to achieve, for whom, and how will we know it worked? | Before Project 2; rewritten as things change |
| [`docs/design-decisions.md`](docs/design-decisions.md) | What were the options, what did I pick, and what did it cost? | As each decision comes up |
| [`rejected.md`](rejected.md) | What am I deliberately not solving, and why? | Running |
| [`docs/data-quality-report.md`](docs/data-quality-report.md) | What shouldn't the business trust yet? | Project 1 |
| [`docs/metric-definitions.md`](docs/metric-definitions.md) | How is each number calculated, over what period? | Before each query |
| [`docs/dashboard-decision-spec.md`](docs/dashboard-decision-spec.md) | What decision does each dashboard tile inform? | Before Project 6 |
| [`docs/submission-gate.md`](docs/submission-gate.md) | Is this project ready to submit? | End of each project |
| [`docs/handover.md`](docs/handover.md) | Where does the work stand, and what's next? | End of each work session |
| [`docs/retro.md`](docs/retro.md) | What did I learn, and what rule does it add? | End of each project |
| [`WALKTHROUGH.md`](WALKTHROUGH.md) | What happened in each project, and what changed my mind? | End of each project |

## Tech Stack

- **Database:** SQLite
- **Database tool:** [DB Browser for SQLite](https://sqlitebrowser.org)
- **AI co-pilot:** Claude, for drafting and cross-checking SQL
- **Dashboard:** HTML
- **Version control:** Git & GitHub

## Repository Structure

```
breaking-games-sql-architecture/
├── docs/
│   ├── erd/                        # Entity-relationship diagrams
│   ├── data-dictionary.md          # Table and column definitions
│   ├── design-decisions.md         # Keys, cleaning, and modeling rationale (decision log)
│   ├── data-quality-report.md      # What's wrong in each table and what not to trust yet
│   ├── metric-definitions.md       # Each metric's formula, period, owner, and caveat
│   ├── dashboard-decision-spec.md  # Each dashboard tile: question, decision, threshold
│   ├── submission-gate.md          # Go/no-go checklist before submitting each project
│   ├── handover.md                 # Where the work stands and what's next
│   └── retro.md                    # Lessons learned per project
├── sql/
│   ├── 01_exploration.sql          # Project 1: first queries and row checks
│   ├── 02_schema.sql               # Project 2: tables, keys, and views
│   ├── 03_product_revenue.sql      # Project 3
│   ├── 04_marketing.sql            # Project 4
│   └── 05_abandoned_carts.sql      # Project 5
├── data/
│   ├── breaking_games.db           # Original database, unchanged (D-13)
│   └── README.md                   # Checksum, contents, and privacy note
├── dashboard/
│   └── dashboard.html              # Project 6
├── beyond-the-externship/          # SQLite vs MongoDB architecture comparison
├── screenshots/
├── PRD.md                          # The living project proposal
├── WALKTHROUGH.md                  # Project-by-project story
├── rejected.md                     # Out of scope, with reasons
├── CLAUDE.md                       # Rules for the AI co-pilot
├── AGENTS.md                       # Points other AI tools to the same rules
└── README.md
```

## Getting Started

1. Install [DB Browser for SQLite](https://sqlitebrowser.org).
2. Clone this repository:
   ```bash
   git clone https://github.com/LashawnFofung/breaking-games-sql-architecture.git
   ```
3. Make a working copy of `data/breaking_games.db` (for example, `breaking_games_work.db`) and open the copy in DB Browser. The original stays unchanged; see [`data/README.md`](data/README.md).
4. Verify the row counts:
   ```sql
   SELECT COUNT(*) FROM shopify_sales;      -- 116
   SELECT COUNT(*) FROM shopify_orders;     -- 277
   SELECT COUNT(*) FROM shopify_checkouts;  -- 1579
   SELECT COUNT(*) FROM referrals;          -- 4450
   SELECT COUNT(*) FROM meta_campaigns;     -- 42
   SELECT COUNT(*) FROM meta_ad_sets;       -- 102
   ```
5. Run the scripts in `sql/` in order.

## Progress

- [ ] Project 1: Load and explore the raw data
- [ ] Project 2: Design a connected database
- [ ] Project 3: Product revenue analysis
- [ ] Project 4: Marketing attribution
- [ ] Project 5: Abandoned cart analysis
- [ ] Project 6: Dashboard and recommendation
- [ ] Beyond the Externship: SQLite vs MongoDB architecture comparison

## Beyond the Externship

A planned extension comparing the relational design built here with a document model in MongoDB: how the same order and marketing data would be shaped, queried, and scaled differently, and when each approach fits. See [`beyond-the-externship/`](beyond-the-externship/README.md).

## Author

**Lashawn Fofung** — SQL & Database Architecture Extern, Extern, Inc.
[LinkedIn](#) · [GitHub](https://github.com/LashawnFofung)

## Acknowledgments

Thanks to **Breaking Games** and **Extern, Inc.** for the opportunity to work on this project. Jess Walker and Mike Bradley are fictional characters from the externship scenario.

The documentation approach (one living proposal, a decision log with reopen triggers, a rejected list, and a submission gate) is adapted from Paweł Huryn's [product-engineering](https://github.com/phuryn/product-engineering) collection.

---

*Completed for educational purposes as part of an externship. Customer data is anonymized and does not identify real Breaking Games customers.*
