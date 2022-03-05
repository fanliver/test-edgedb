# Insert some employees
```
for data in {
    ("Ha", "Pham"),
    ("Trung", "Truong"),
    ("Long", "Chau"),
} 
union (
    insert Employee {
        first_name := data.0,
        last_name := data.1
    }
);
```

# Query employees
```
select Employee;

select Employee { first_name, last_name, full_name };

select Employee { full_name } filter .first_name = 'Trung';

select Employee { name, address } filter .last_name like '%h%';
```

# Update company to set employees
```
update Company 
filter .name = 'Fram'
set {
    employees += (insert Employee { first_name := 'Huy', last_name := 'Duong' })
};

update Company 
filter .name = 'Fram'
set {
    employees += (select Employee filter .full_name like '%u%')
};

```

# Query company with employees

```
select Company {
    name,
    address,
    employees: {
        full_name
    }
};
```

# Delete employees

```
delete Employee filter .full_name = 'Long Chau'
```
