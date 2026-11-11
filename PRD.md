# PRD — Breaking Games Q4 Decision Database

**Owner:** Lashawn Fofung · **Version:** 0.1 · **Status:** Draft, Project 1 in progress · **Last rewritten:** 2026-11-10

> This is the one living proposal for the project. When something changes, I rewrite the affected section, add one line to [Version History](#version-history), and log the reasoning in [`docs/design-decisions.md`](docs/design-decisions.md). I don't append updates to the sections themselves.

## Problem

**Goal:** Help Breaking Games commit holiday print quantities and marketing spend with evidence, before the print-run deadline and ahead of Black Friday.

**Why now:** In the externship scenario, Mike must commit print quantities by Nov 1, with Black Friday six weeks later. A wrong call either ties up cash in unsold inventory or sells out during the highest-demand weeks of the year.

**Why it's hard:** The evidence lives in six exports that share no ID and cover different periods. Today, answering "what sells, and what sells it" means stitching spreadsheets together by hand.

## Users and Their Decisions

| User | Decision | How often | What they can't do today |
|---|---|---|---|
| Mike Bradley, Head of E-Commerce | How many units of each title to print for the holiday | Once a season, revisited weekly | Rank products by revenue and know what period the ranking covers |
| Jess Walker, Senior Marketing Ops | Which channels and campaigns get Q4 budget | Weekly | Compare Meta spend with Shopify traffic on a common footing |
| Shari Spiro, founder | Whether the holiday plan is worth the cash it ties up | At plan sign-off | See one page with the recommendation and its risk |

## Non-Goals

Full list with reasons in [`rejected.md`](rejected.md). In short:

- Wholesale and Kickstarter sales. Scope is Shopify direct-to-consumer only.
- Customer-level attribution. No field links a customer or order to a campaign.
- ROI or abandonment rates without a stated period. Every cross-table figure names the time assumption it rests on.
- A demand forecast. There is no dated sales history to build one on.

## Priorities

Candidate questions are scored on **business impact** (does the answer change a print or budget decision?) and **data readiness** (can the data answer it honestly?).

| Rank | Question | Impact | Data readiness | Why it ranks here |
|---|---|---|---|---|
| 1 | Which products drive most revenue? | High: sets print priority | High: `shopify_sales` totals reconcile on every row | Drives the print decision directly |
| 2 | Which traffic sources produce checkouts, not just visits? | High: sets channel budget | Medium: volumes are solid, rates need weighting | Google and Facebook send similar traffic but very different checkout volume |
| 3 | How much abandoned-cart value is real demand? | Medium: sizes the cart-recovery opportunity | Medium: needs a bot rule first | Tells marketing whether cart recovery is worth funding |
| — | Year-over-year holiday trend | High | Low: no dated sales history | Parked. See [`rejected.md`](rejected.md) |

*First-pass scores after Project 1, to confirm with the mentor.*

## Success Metrics

| Metric | Baseline | Target | How I'll check |
|---|---|---|---|
| Dashboard tiles that name the decision they inform and an action threshold | 0 | 100% | Review against [`docs/dashboard-decision-spec.md`](docs/dashboard-decision-spec.md) |
| Order lines that join to a product | 50 of 51 titles match exactly today | 100% | Unmatched-row count after the product mapping (D-03) |
| Metrics with a formula and a stated period | Not yet built | 100% | No blank "Period" cell in [`docs/metric-definitions.md`](docs/metric-definitions.md) |
| A stakeholder can make the decision from the dashboard alone | Untested | Mentor confirms at the final review | Final presentation feedback |

**30-day check (if this were live):** compare the top-10 print-priority list with actual November sell-through. If more than three of the ten underperform, reopen D-05, the "top seller" definition.

## Proposed Solution

1. **A connected SQLite database:** cleaned source tables, a product table with a stable product ID and a title-mapping table, and a channel table that groups the 469 referrers into a handful of channels.
2. **Documented queries,** one file per project in `sql/`, each opening with the question it answers and the period it covers.
3. **An HTML dashboard** with few tiles, each tied to a decision and a threshold, plus a "What this doesn't show" note.
4. **A one-page recommendation** for leadership: three findings, one recommendation, one risk.

## Key Assumptions

| Assumption | Evidence (profiled 2026-11-10) | What would break it |
|---|---|---|
| `shopify_sales` is reliable for ranking | Totals reconcile on all 116 rows | Learning it covers an unusual period |
| Revenue is concentrated in a few titles | The top 23 products (20% of the catalog) bring in 79.5% of total sales | A different revenue measure changing the ranking |
| Google drives more checkouts than Facebook | About 210K pageviews each; 1,044 vs 408 checkout sessions | The referrals period being unrepresentative |
| Meta purchase campaigns cost about $63 per purchase | $51,257 spend ÷ 813 Meta-reported purchases | Meta's purchase count not matching Shopify |

## Open Questions

1. What period does `shopify_sales` cover? This blocks any "this season" claim.
2. What period does `referrals` cover?
3. Are Blackbox and Secret Hitler products in scope?
4. Should a blank `referrer` count as Direct?
5. Can the `.db` file and CSVs be published?

## Risks

| Risk | Likelihood | Mitigation |
|---|---|---|
| A ranking on an unknown period misleads the print decision | Medium | State the period on every tile; resolve open question 1 |
| Meta `results` summed across result types inflates performance | High if unguarded | Rule in [`CLAUDE.md`](CLAUDE.md); always group by `result_indicator` |
| Bot carts inflate abandoned-cart value | Medium | Apply the bot rule (D-09) before any cart metric |

## Recommendation

*Written after Project 6: the recommendation in one sentence, the evidence behind it, the trade-off, and how to check it in 30 days.*

## Version History

Versions stay at 0.x while drafting and reach 1.0 with the final recommendation. A new version means a section changed meaningfully; wording fixes don't count. Each commit that changes this file starts its summary with the version, such as `PRD v0.2: …`.

| Version | Date | What changed | Why |
|---|---|---|---|
| 0.1 | 2026-11-10 | First draft after Project 1 profiling | — |
