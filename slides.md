```
🄸 🄽 🅃 🅁 🄾 🄳 🅄 🄲 🅃 🄸 🄾 🄽  🄾 🄵 


███████╗██████╗░░██████╗░███████╗██████╗░██████╗░
██╔════╝██╔══██╗██╔════╝░██╔════╝██╔══██╗██╔══██╗
█████╗░░██║░░██║██║░░██╗░█████╗░░██║░░██║██████╦╝
██╔══╝░░██║░░██║██║░░╚██╗██╔══╝░░██║░░██║██╔══██╗
███████╗██████╔╝╚██████╔╝███████╗██████╔╝██████╦╝
╚══════╝╚═════╝░░╚═════╝░╚══════╝╚═════╝░╚═════╝░
```

                                        Ha Pham

> Together we learn

---

# WHAT IS EDGEDB
- A new generation of object-relational database
- Based on PostgreSQL
- New query language: EdgeQL
```edgeql
select Person {
    name,
    age,
    address: {
        number,
        street,
        state
    }
}
filter .age > 18
```
---
# LITTLE SHOW UP FIRST

### The old way
SQL:
```SQL
CREATE TABLE IF NOT EXISTS imports
(
    id                   BIGSERIAL        NOT NULL PRIMARY KEY,
    total_row            INT              NOT NULL,
    import_history_id    BIGINT           NOT NULL,
    company_id           BIGINT           NOT NULL,
    status               VARCHAR(16)      NOT NULL DEFAULT 'pending',
    created_at           TIMESTAMP        NOT NULL DEFAULT current_timestamp,
    updated_at           TIMESTAMP        NOT NULL DEFAULT current_timestamp
);

CREATE TABLE IF NOT EXISTS import_analytics
(
    id                   BIGSERIAL        NOT NULL PRIMARY KEY,
    row_number           INT              NOT NULL,
    import_id            BIGINT           NOT NULL,
    company_id           BIGINT           NOT NULL,
    status               VARCHAR(16)      NOT NULL DEFAULT 'success',
    description          TEXT,
    created_at           TIMESTAMP        NOT NULL DEFAULT current_timestamp,
    updated_at           TIMESTAMP        NOT NULL DEFAULT current_timestamp
);

```

---
# LITTLE SHOW UP FIRST

### The new-generation way

EdgeQL:
```EdgeQL
scalar type ImportStatus extending enum<Pending, InProgress, Finished>;

type Import {
    required property total_row -> int32;
    required property import_history_id -> int64;
    required property company_id -> int64;
    required property status -> ImportStatus;
    multi link import_analytics -> ImportAnalytics;

    property created_at -> datetime {
        default := datetime_current();
    }

    property updated_at -> datetime;
}
type ImportAnalytics {
    required property row_number -> int32;
    required property company_id -> int64;
    required property status -> str {
        constraint one_of('Open', 'Closed', 'Merged')
    }
    property description -> str;
}
```

---

# INSTALLATION

**Just one command**
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.edgedb.com | sh

```

---

# SETUP PROJECT
- Create new project `edgedb project init`

- Select DB instance info:
    - name
    - version
    - starting instance automatically on login


## File structure
```
drwxr-xr-x   - hapham  5 Mar 13:32 .
drwxr-xr-x   - hapham  5 Mar 13:32 ├── dbschema
.rw-r--r-- 193 hapham  5 Mar 13:32 │  ├── default.esdl
drwxr-xr-x   - hapham  5 Mar 13:32 │  └── migrations
.rw-r--r--  32 hapham  5 Mar 13:32 └── edgedb.toml
```

- The declarative database schema in `dbschema/default.esdl`
- Migrations will be generated automatically: `edgedb migration create`
- Applying the migrations: `edgedb migrate`

## Connect to database instance
Execute the command `edgedb`

## More useful commands
- Listing all instances: `edgedb instance list`
- Starting an instance: `edgedb instance start`
- Basic project information: `edgedb project info`
...

---

# EDGEQL BASIC

- No `TABLE`, just `TYPE`
- No `REFERENCE`, just `LINK`
- `INHERITANCE`

