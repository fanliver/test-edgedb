# Query the employee types
```
select Employee { employee_type };
```

# Insert new employee
```
insert Employee { first_name := 'Nam', last_name := 'Tran' };

insert Employee { first_name := 'Quan', last_name := 'Tran', employee_type := EmployeeType.External };
```

# Query the employee by type
```
select Employee { full_name } filter .employee_type = EmployeeType.External;
```
