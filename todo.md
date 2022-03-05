# Generate migration
```
edgedb migration create
```

# Apply migration
```
edgedb migrate
```

# Insert some companies
```
insert Company {
    name := "Fram",
    address := "Ho Chi Minh city",
};

for data in {
    ("Sioux", "Da Nang"),
    ("MGM", "Da Nang"),
    ("Paradox", "Ha Noi")
}
union(
    insert Company {
        name := data.0,
        address := data.1
    }
);

```

# Query companies
```
select Company;

select Company { name };

select Company { name, address };

select Company { name, address };
select Company { name, address } filter .address like '%Nang';
```

# Delete company

```
select (delete Company filter .name = 'Paradox').name;

delete Company;
```
