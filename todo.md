# Insert some documents
```
insert Certificate {
    file_name := '/cert/toeic-hapham.pdf',
    issue_date := <datetime>'2022-01-01T08:52:37+07:00'
};

insert Contract {
    file_name := '/contract/huy.duong.pdf',
    length := 3
};

insert Contract {
    file_name := '/contract/ha.pham.pdf',
    length := 3
};
```
# Query the documents
```
select Document { file_name };

select Document { file_name, is_contract := Document is Contract };

select Document {
    file_name,
    [is Certificate].issue_date,
    [is Contract].length,
};
```

# Assign documents for employees
```
update Employee
filter .last_name = 'Pham'
set {
    documents := (select Document filter .file_name like '%pham%')
};

update Employee
filter .first_name = 'Huy'
set {
    documents += (select Document filter .file_name like '%huy%')
};
```

# Query employee to see documents
```
select Employee {
    full_name,
    documents: {
        file_name
    }
};
```
