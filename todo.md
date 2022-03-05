# Query the list of documents and the linked employee
```
select Document {
    file_name,
    employee := .<documents[is Employee] {
        full_name
    }
};
```

# Filter document by employee name

```
select Document {
    file_name
}
filter .<documents[is Employee].first_name like '%Ha%';
```

# Filter employees who have document
```
select Employee {
    full_name
}
filter exists .documents;

select Employee {
    full_name
}
filter count(.documents) > 1;
```
# Filter some documents based on employees
```
with employees := (select Employee filter count(.documents) > 1),
select Document {
    file_name,
    employee_name := .<documents [is Employee].full_name
}
filter .<documents [is Employee] in employees;

```
