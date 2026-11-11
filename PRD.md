# PRD: Breaking Games Q4 Decision Database

**Owner:** Lashawn Fofung · **Status:** Draft, Project 1 complete · **Last rewritten:** 2026-11-10

> This is the one living proposal. When something changes, I rewrite the affected section and log why in [`docs/decision-log.md`](docs/decision-log.md). I don't append "updates" below.

## 1. Problem

**Goal:** Help Breaking Games commit holiday print quantities and marketing spend with evidence, before the print deadline and six weeks ahead of Black Friday.

**Why now:** In the scenario, Mike must commit print quantities by Nov 1. A wrong call either strands cash in unsold inventory or sells out during the highest-demand weeks of the year.

**Why it's hard:** The evidence lives in six exports that share no ID and cover different time windows. Today nobody can answer "what sells, and what sells it" without hand-stitching spreadsheets.

## 2. Users and the decisions they make

| User | Decision they need to make | How often | What they can't do today |
|---|---|---|---|
| Mike Bradley, Head of E-Commerce | How many units of each title to print for the holiday | Once a season, revisited weekly | Rank products by revenue with confidence about the period covered |
| Jess Walker, Senior Marketing Ops | Which channels and campaigns get Q4 budget | Weekly | Compare Meta spend with Shopify traffic on a common footing |
| Leadership (Shari Spiro, founder) | Whether the holiday plan is worth the cash it ties up | At plan sign-off | See one page with the recommendation and its risk |

## 3. Non-goals

Full list with reasons: [`rejected.md`](rejected.md). The short version:

- Wholesale and Kickstarter sales (scope is Shopify direct-to-consumer only).
- Customer-level attribution (no field links a customer to a campaign).
- A cross-table ROAS figure (no overlapping time window supports it).
- A forecasting model (no dated sales history to train on).

## 4. Priorities: which questions the dashboard answers first

Candidate questions are scored on **business impact** (does it change a print or spend decision?) and **data readiness** (can the data answer it honestly?).

| Rank | Question | Impact | Data readiness | Why it's here |
|---|---|---|---|---|
| 1 | Which products drive most revenue? | High: sets print priority | High: `shopify_sales` reconciles on every row | Directly drives the print decision |
| 2 | Which traffic sources produce checkouts, not just visits? | High: sets channel budget | Medium: volumes solid, rates need weighting | Google and Facebook send similar traffic but very different checkout volume |
| 3 | How much abandoned cart value is real demand? | Medium: sizes the recovery opportunity | Medium: needs a bot rule first | Tells marketing whether cart recovery is worth funding |
| — | Year-over-year holiday trend | High | **Low:** no dated sales history | Parked. See `rejected.md` |

*Scores are my first pass after Project 1; to be confirmed with the mentor.*

## 5. Success metrics and validation

| Metric | Baseline | Target | How I'll check |
|---|---|---|---|
| Every dashboard tile names the decision it informs and its action threshold | 0 tiles | 100% | Review against [`docs/dashboard-decision-spec.md`](docs/dashboard-decision-spec.md) |
| Order lines that join to a product | Not yet built (50 of 51 titles match exactly today) | 100% | Unmatched-row count after the product mapping |
| Every metric traceable to a query and a stated time window | Not yet built | 100% | Metric definitions sheet has no blank "window" cell |
| Stakeholder can make the decision from the dashboard alone | Untested | Mentor confirms in the final review | Final presentation feedback |

**30-day validation (if this were live):** compare the top-10 print-priority list against actual November sell-through. If more than three of the top ten underperform, revisit D-05 (the "top seller" definition).

## 6. Proposed solution

1. A **connected SQLite database**: cleaned source tables, plus a `dim_product` table with a stable product ID and a title-mapping table, and a `dim_channel` table that maps referrers into a handful of channels.
2. A **set of documented queries**, one file per business question.
3. An **HTML dashboard** with few tiles, each tied to a decision and a threshold, plus a "what this doesn't show" note.
4. A **one-page recommendation** for leadership: three findings, one recommendation, one risk.

## 7. Key assumptions, with their evidence

| Assumption | Evidence (receipt) | What would break it |
|---|---|---|
| `shopify_sales` is reliable for ranking | Totals reconcile on all 116 rows (profiled 2026-11-10) | Learning it covers an unusual period |
| Revenue is concentrated in a few titles | Top 23 products (20%) bring in 79.5% of total sales (profiled 2026-11-10) | A different revenue measure changing the ranking |
| Google drives more checkouts than Facebook | ~210K pageviews each; 1,044 vs 408 checkout sessions (`referrals`, profiled 2026-11-10) | The referrals period being unrepresentative |
| Meta purchase campaigns cost about $63 per purchase | $51,257 spend / 813 Meta-reported purchases (profiled 2026-11-10) | Meta's purchase count not matching Shopify |

## 8. Open questions

1. What period does `shopify_sales` cover? (Blocks any "this season" claim.)
2. What period does `referrals` cover?
3. Are Blackbox and Secret Hitler products in scope?
4. Should a blank `referrer` count as Direct?
5. Can the `.db` file and CSVs be published?

## 9. Risks

| Risk | Likelihood | Mitigation |
|---|---|---|
| Ranking products on an unknown time window misleads the print decision | Medium | State the window on every tile; confirm question 1 |
| Meta `results` summed across objectives inflates performance | High if unguarded | Rule in `CLAUDE.md`; always group by `result_indicator` |
| Bot carts inflate abandoned cart value | Medium | Bot rule (D-09) applied before any cart metric |

## 10. Recommendation

*Written after Project 6. Format: the recommendation in one sentence, the evidence behind it, the trade-off, and how to validate it in 30 days.*
