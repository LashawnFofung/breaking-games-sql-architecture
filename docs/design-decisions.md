# Design Decisions

Keys, cleaning, and modeling rationale for the Breaking Games database. Each entry records the options, my pick, the trade-off, and the trigger that would make me reopen it.

**Status key:** Open (not yet decided) · Proposed (my pick, awaiting mentor input) · Decided · Reopened

## Decisions at a Glance

| ID | Decision | Project | Status | Date |
|---|---|---|---|---|
| D-01 | Revenue measure | 3 | Proposed | 2026-11-10 |
| D-02 | Meta `results`: blank vs zero, and mixed result types | 4 | Proposed | 2026-11-10 |
| D-03 | Product key | 2 | Proposed | 2026-11-10 |
| D-04 | Shipping rows in orders | 1, 3 | Proposed | 2026-11-10 |
| D-05 | "Top seller" definition | 3 | Open | 2026-11-10 |
| D-06 | Time period for every claim | All | Proposed | 2026-11-10 |
| D-07 | Attribution level | 2, 4 | Proposed | 2026-11-10 |
| D-08 | Referrer-to-channel mapping | 2, 4 | Open | 2026-11-10 |
| D-09 | Bot rule | 5 | Open | 2026-11-10 |
| D-10 | Blank and lowercase categories | 1 | Proposed | 2026-11-10 |
| D-11 | Third-party vendors in checkouts | 5 | Open | 2026-11-10 |
| D-12 | Counting checkouts | 1, 5 | Decided | 2026-11-10 |

---

### D-01 · Revenue Measure

- **Context:** `shopify_sales` has `net_sales` ($150,883, excludes tax) and `total_sales` ($159,612, includes tax).
- **Options:** (a) `total_sales` (b) `net_sales`
- **Pick:** (b) `net_sales`
- **Trade-off:** A lower headline number, but tax isn't money the business keeps. Option (a) would overstate revenue by about $8,700.
- **Reversible?** Yes, one column swap.
- **Reopen if:** Breaking Games' own reporting uses gross or total sales.

### D-02 · Meta `results`: Blank vs Zero, and Mixed Result Types

- **Context:** `results` counts different things per campaign: purchases, landing page views, or reach. 28 campaigns have no result recorded but spent $22,126. Treating blanks as zero moves the average from about 107K to about 36K.
- **Options:** (a) treat blanks as zero (b) treat blanks as "not recorded," leave them out of averages, and only compare campaigns with the same `result_indicator`
- **Pick:** (b)
- **Trade-off:** Fewer campaigns in each comparison, but every comparison is like for like.
- **Reversible?** Yes.
- **Reopen if:** Meta documentation or the mentor confirms blank means zero.

### D-03 · Product Key

- **Context:** Product titles differ across exports. Orders match `shopify_sales` on 50 of 51 titles; checkouts on only 91 of 176. Seventeen titles use the pipe-delimited format.
- **Options:** (a) join on raw titles (b) a stable `product_id` in a product table, plus a mapping table that ties every title variant to it
- **Pick:** (b)
- **Trade-off:** More setup in Project 2, but every join stays consistent, and a new variant needs one mapping row instead of query edits.
- **Reversible?** Yes, the mapping table can be rebuilt.
- **Reopen if:** a reliable SKU turns up in every table.
- **Check:** zero unmatched rows in the order-to-product join.

### D-04 · Shipping Rows in Orders

- **Context:** Each of the 92 August orders has one shipping row (`sale_id` ending in `-S`, blank product title).
- **Options:** (a) keep everywhere (b) delete (c) leave out of product metrics, keep in order totals
- **Pick:** (c)
- **Trade-off:** Two filters to remember, but both product counts and order totals stay correct.
- **Reopen if:** a question needs shipping as its own revenue line.

### D-05 · "Top Seller" Definition

- **Context:** Cheap add-ons rank high on units but low on revenue.
- **Options:** (a) units (b) net revenue (c) show both, rank on revenue
- **Leaning:** (c). Print quantity is about units, but print priority is about money.
- **Decide with:** Mike's actual question. Is it "what do we print the most of" or "what matters most to the business"?

### D-06 · Time Period for Every Claim

- **Context:** `shopify_sales` and `referrals` have no dates; `shopify_orders` covers August 2026 only; Meta reports one total for Jan 2025 – Sep 2026; checkouts span Oct 2016 – Oct 2026 unevenly.
- **Pick:** every metric names its period. A figure that combines tables (ROI, abandonment rate) states the time assumption it rests on, right next to the number.
- **Trade-off:** Some figures carry visible caveats, but none of them claims more than the data shows.
- **Reopen if:** the mentor confirms the period for `shopify_sales` or `referrals`.

### D-07 · Attribution Level

- **Context:** No field links a customer or order to a campaign.
- **Options:** (a) customer-level attribution (b) channel-level only
- **Pick:** (b). The "ad click to purchase" path in Project 2 is built at the channel level: Meta spend → Meta-referred traffic → checkouts.
- **Trade-off:** Less precise, but (a) would mean inventing links the data doesn't have.
- **Reopen if:** order-level UTM or campaign data becomes available.

### D-08 · Referrer-to-Channel Mapping

- **Context:** 469 referrer values. facebook, instagram, and internalfb are all Meta; google and googlesyndication mean different things; spam referrers such as trafficheap bring zero checkouts; 2,167 rows are blank.
- **Draft channels:** Meta, Google Search, Google Ads, Direct, Email, Spam, Other
- **Open:** whether a blank referrer means Direct (open question for the mentor).

### D-09 · Bot Rule

- **Context:** The course notes that some "customers" add the same item repeatedly in odd quantities.
- **To decide:** the threshold, and how many carts and dollars it removes. Record both numbers here.
- **Trade-off to weigh:** too strict removes real bulk buyers; too loose leaves noise in cart value.

### D-10 · Blank and Lowercase Categories

- **Context:** `product_type` has one lowercase `game` and seven blanks.
- **Pick:** merge `game` into `Game`; label blanks "Uncategorized" rather than guess.
- **Reopen if:** the mentor can supply the missing categories.

### D-11 · Third-Party Vendors in Checkouts

- **Context:** Checkouts include Blackbox (96 rows) and Secret Hitler (18 rows), plus "Breaking Games LLC" as a variant of "Breaking Games."
- **Options:** (a) include all vendors (b) Breaking Games titles only
- **Open:** pending the mentor's answer on scope.

### D-12 · Counting Checkouts

- **Context:** A checkout with several products spans several rows, and only the first row carries the totals. 1,579 rows = 1,197 checkouts.
- **Decided:** always count with `COUNT(DISTINCT name)` and take money fields only from the row that carries them.
- **Why it's decided, not proposed:** it follows from how Shopify structures the export, not from a judgment call.

---

## Template

```
### D-XX · <Decision>

- **Context:**
- **Options:** (a) (b)
- **Pick:**
- **Trade-off:**
- **Reversible?**
- **Reopen if:**
- **Check:**
```
