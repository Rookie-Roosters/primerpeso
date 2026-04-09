-- DigitalOcean App Platform *dev* PostgreSQL: the app user often cannot CREATE SCHEMA or
-- create objects in public until a database owner grants rights. Run **one** of the options
-- below in the DO database **Query** / **Console** (or psql as admin), then redeploy the API.
--
-- Find your app DB name and role from the connection string (or App → primerpeso-db → Connection details).
-- Names with hyphens must be double-quoted in PostgreSQL.

-- ---------------------------------------------------------------------------
-- Option A — Let the app use schema "primerpeso" (matches DATABASE_SCHEMA=primerpeso)
-- ---------------------------------------------------------------------------
-- Replace "primerpeso-db" with your database name and "primerpeso-db" role with your app user name.
GRANT CREATE ON DATABASE "primerpeso-db" TO "primerpeso-db";

-- After redeploy, EnsureSchema can run CREATE SCHEMA primerpeso.

-- ---------------------------------------------------------------------------
-- Option B — Stay in schema public only (then remove DATABASE_SCHEMA in the API component)
-- ---------------------------------------------------------------------------
-- GRANT ALL PRIVILEGES ON SCHEMA public TO "primerpeso-db";
-- GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO "primerpeso-db";
-- GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO "primerpeso-db";
