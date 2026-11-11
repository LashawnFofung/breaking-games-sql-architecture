# Decision Log

Every choice with a real alternative. Each entry names the trigger that would reopen it, so decisions don't go stale silently.

**Status key:** Open (not yet decided) · Proposed (my pick, awaiting mentor input) · Decided · Reopened

| ID | Decision | Status | Date |
|---|---|---|---|
| D-01 | Revenue measure | Proposed | 2026-11-10 |
| D-02 | Meta `results`: NULL vs zero, and mixed units | Proposed | 2026-11-10 |
| D-03 | Product key | Proposed | 2026-11-10 |
| D-04 | Shipping rows in orders | Proposed | 2026-11-10 |
| D-05 | "Top seller" definition | Open | 2026-11-10 |
| D-06 | Time window for claims | Proposed | 2026-11-10 |
| D-07 | Attribution level | Proposed | 2026-11-10 |
| D-08 | Referrer to channel mapping | Open | 2026-11-10 |
| D-09 | Bot rule | Open | 2026-11-10 |
| D-10 | Blank and lowercase categories | Proposed | 2026-11-10 |
| D-11 | Third-party vendors in checkouts | Open | 2026-11-10 |
| D-12 | Counting checkouts | Decided | 2026-11-10 |

---

### D-01 · Revenue measure
- **Context:** `shopify_sales` has `net_sales` ($150,883, excludes tax) and `total_sales` ($159,612, includes tax).
- **Options:** (a) `total_sales` (b) `net_sales`
- **Pick:** (b) `net_sales`
- **Trade-off:** Lower headline number; but tax isn't money the business earns, so (a) would overstate revenue by ~$8.7K.
- **Reversible?** Yes, one column swap.
- **Reopen if:** the stakeholder's own reporting uses gross or total sales.

### D-02 · Meta `results`: NULL vs zero, and mixed units
- **Context:** `results` counts different things per campaign (purchases, landing page views, reach). 28 campaigns have no result recorded but spent $22,126. Treating blanks as zero moves the average from ~107K to ~36K.
- **Options:** (a) treat blanks as zero (b) treat blanks as "not recorded" and exclude them from averages; compare only within the same `result_indicator`
- **Pick:** (b)
- **Trade-off:** Fewer campaigns in each comparison; but every comparison is like for like.
- **Reversible?** Yes.
- **Reopen if:** Meta documentation or the mentor confirms blank means zero.

### D-03 · Product key
- **Context:** Titles differ across exports. Orders match `shopify_sales` on 50 of 51 titles; checkouts on only 91 of 176. 17 titles use a pipe format.
- **Options:** (a) join on raw titles (b) stable surrogate `product_id` in `dim_product`, with a title-mapping table for every variant
- **Pick:** (b)
- **Trade-off:** More setup now; every join and metric stays consistent later, and new variants need one mapping row instead of query edits.
- **Reversible?** Yes, the mapping table can be rebuilt.
- **Reopen if:** a reliable SKU turns up in every table.
- **Validation:** zero unmatched rows in the order-to-product join.

### D-04 · Shipping rows in orders
- **Context:** Each of the 92 August orders has one shipping row (`sale_id` ending `-S`, blank product title).
- **Options:** (a) keep everywhere (b) delete (c) exclude from product metrics, keep in order totals
- **Pick:** (c)
- **Trade-off:** Two filters to remember; but product counts and order totals are both right.
- **Reopen if:** a question needs shipping as its own revenue line.

### D-05 · "Top seller" definition
- **Context:** Cheap add-ons rank high on units but low on revenue.
- **Options:** (a) units (b) net revenue (c) show both, rank on revenue
- **Leaning:** (c), because print quantity is about units but print priority is about money.
- **To decide with:** Mike's actual question. Is it "what to print most of" or "what matters most"?

### D-06 · Time window for claims
- **Context:** `shopify_sales` and `referrals` have no dates; `shopify_orders` covers Aug 2026 only; Meta is one block (Jan 2025 – Sep 2026); checkouts span Oct 2016 – Oct 2026 unevenly.
- **Pick:** every metric states its window; no cross-table metric without an overlapping window.
- **Trade-off:** Some tempting numbers (ROAS, abandonment rate) don't get computed.
- **Reopen if:** the mentor supplies the period for `shopify_sales` or `referrals`.

### D-07 · Attribution level
- **Context:** No field links a customer or order to a campaign.
- **Options:** (a) customer-level attribution (b) channel-level only
- **Pick:** (b)
- **Trade-off:** Less precise; but (a) would mean inventing links the data doesn't have.
- **Reopen if:** order-level UTM or campaign data becomes available.

### D-08 · Referrer to channel mapping
- **Context:** 469 referrer values; facebook, instagram and internalfb are all Meta; google vs googlesyndication differ; spam referrers (e.g. trafficheap) bring zero checkouts; 2,167 rows are blank.
- **Draft channels:** Meta, Google Search, Google Ads, Direct, Email, Spam, Other
- **Open:** whether blank means Direct (question to mentor).

### D-09 · Bot rule
- **Context:** The course says some "customers" add the same item repeatedly in odd quantities.
- **To decide:** the threshold, and how many carts and dollars it removes. Log both numbers here.
- **Trade-off to weigh:** too strict removes real bulk buyers; too loose leaves noise in cart value.

### D-10 · Blank and lowercase categories
- **Context:** `product_type` has 1 lowercase `game` and 7 blanks.
- **Pick:** merge `game` into `Game`; label blanks "Uncategorized" rather than guessing.
- **Reopen if:** the mentor can supply the missing categories.

### D-11 · Third-party vendors in checkouts
- **Context:** Checkouts include Blackbox (96 rows) and Secret Hitler (18 rows), plus "Breaking Games LLC" as a variant name.
- **Options:** (a) include all (b) Breaking Games titles only
- **Open:** pending the mentor's answer on scope.

### D-12 · Counting checkouts
- **Context:** Multi-line checkouts repeat the checkout across rows; only the first row carries totals. 1,579 rows = 1,197 checkouts.
- **Decided:** always `COUNT(DISTINCT name)`; take money fields from the row that carries them.
- **Why it's decided, not proposed:** it's how the export is structured, not a judgment call.

---

**Template for new entries**

```
### D-XX · <decision>
- Context:
- Options: (a) (b)
- Pick:
- Trade-off:
- Reversible?
- Reopen if:
- Validation:
```
