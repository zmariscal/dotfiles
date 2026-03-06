# Rails Performance Skill
# Focus: Database efficiency, memory management, and Sidekiq optimization.

## 🗄 Database & ActiveRecord
- **N+1 Queries:** Always check for missing .includes, .preload, or .eager_load.
- **Selective Loading:** Use .select or .pluck instead of loading full AR objects when only specific columns are needed.
- **Indexes:** Suggest database indexes for any column used in a .where, .find_by, or .order clause.
- **Batching:** Use .find_each or .in_batches for operations on more than 1,000 records.

## ⚡️ Background Jobs (Sidekiq)
- **Small Arguments:** Never pass AR objects to jobs; pass IDs only.
- **Idempotency:** Ensure jobs can be safely retried without side effects.

## 🚀 Caching
- Suggest Fragment Caching (cache @record) for expensive partials.
- Suggest Low-Level Caching (Rails.cache.fetch) for expensive API calls or calculations.
