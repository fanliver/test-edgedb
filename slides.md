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
- Based on PostgreSQL
- A new generation of object-relational database
- New query language: EdgeQL

---

# LITTLE SHOW UP FIRST

### The old SQL way
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

### The new-generation EdgeQL way
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

# LITTLE SHOW UP FIRST

### The old-SQL way

```sql
with authors_with_many_books as (
    select authors.id
    from authors 
        inner join books on book.author_id = authors.id
    group by authors.id
    having count(book.id) > 1
)
select books.title, authors.full_name
from books
    inner join authors on books.author_id = author.id
where book.author_id in authors_with_many_books

```

---

# LITTLE SHOW UP FIRST

### The new-generation EdgeQL way

```EdgeQL
select Book {
    title,
    author := .<books[is Author].full_name
}
filter .<books[is Author] in (select Author filter count(.books) > 1)

```


---

# INSTALLATION

Just one command
`curl --proto '=https' --tlsv1.2 -sSf https://sh.edgedb.com | sh`


---

# SETUP PROJECT
- Create new project `edgedb project init`

- Select DB instance info:
    - name
    - version
    - starting instance automatically on login

---

# SETUP PROJECT
## File structure
```
drwxr-xr-x   - hapham  5 Mar 13:32 .
drwxr-xr-x   - hapham  5 Mar 13:32 ├── dbschema
.rw-r--r-- 193 hapham  5 Mar 13:32 │  ├── default.esdl
drwxr-xr-x   - hapham  5 Mar 13:32 │  └── migrations
.rw-r--r--  32 hapham  5 Mar 13:32 └── edgedb.toml
```

- The declarative database schema in `dbschema/default.esdl`
- Auto-generated migrations in `dbschema/migrations/`
- Project config in `edgedb.toml`

---

# MIGRATION

## Migrations will be generated automatically
`edgedb migration create`
## Applying the migrations
`edgedb migrate`

---

# CONNECT TO DATABASE

`edgedb`
- No other arguments (instance name, user, password)

---

# MORE COMMANDS
- Listing all instances: `edgedb instance list`
- Starting an instance: `edgedb instance start`
- Basic project information: `edgedb project info`
...

---

# EDGEQL

- Strongly typed
- No `NULL`, just `{}`
- No `TABLE`, just `TYPE`
- No `REFERENCE`, no `JOIN`, just `LINK`
- Support `INHERITANCE`

---

# CLIENTS

- JavaScript/TypeScript
- Python
- Go
- HTTP (EdgeQL/GraphQL)

---

# TIME TO PRACTICE

```
██████╗░██████╗░░█████╗░░█████╗░████████╗██╗░█████╗░███████╗
██╔══██╗██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██║██╔══██╗██╔════╝
██████╔╝██████╔╝███████║██║░░╚═╝░░░██║░░░██║██║░░╚═╝█████╗░░
██╔═══╝░██╔══██╗██╔══██║██║░░██╗░░░██║░░░██║██║░░██╗██╔══╝░░
██║░░░░░██║░░██║██║░░██║╚█████╔╝░░░██║░░░██║╚█████╔╝███████╗
╚═╝░░░░░╚═╝░░╚═╝╚═╝░░╚═╝░╚════╝░░░░╚═╝░░░╚═╝░╚════╝░╚══════╝
```
