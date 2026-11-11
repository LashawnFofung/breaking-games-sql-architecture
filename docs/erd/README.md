# Entity-Relationship Diagrams

## Current State: Six Unlinked Tables

As loaded, no table shares a key with another. The dotted lines are the links that can be built in Project 2, and how strong each one is.

```mermaid
erDiagram
    shopify_sales {
        text product_title
        text product_type
        int net_items_sold
        real net_sales
    }
    shopify_orders {
        text sale_id
        text order_name
        text day
        text product_title
        real total_sales
    }
    shopify_checkouts {
        text name
        text customer_id
        text lineitem_name
        real total
        text created_at
    }
    referrals {
        text referrer
        text landing_page
        int pageviews
        int checkout_sessions
    }
    meta_campaigns {
        text campaign_name
        text result_indicator
        real results
        real spend_usd
    }
    meta_ad_sets {
        text ad_set_name
        text result_indicator
        real results
        real spend_usd
    }
    shopify_orders }o..|| shopify_sales : "title, strong (50 of 51 match)"
    shopify_checkouts }o..|| shopify_sales : "title, weak (91 of 176 match)"
    referrals }o..o{ shopify_sales : "landing page URL, needs mapping"
    referrals }o..o{ meta_campaigns : "channel level only"
    meta_ad_sets }o..o| meta_campaigns : "name pattern, weak"
```

## Target Design

*Added in Project 2: `dim_product` with a stable `product_id`, a title-mapping table, and `dim_channel`. See D-03 and D-08 in [`../design-decisions.md`](../design-decisions.md).*
