module default {
    type Company {
        required property name -> str {
            constraint exclusive;
        };
        required property address -> str {
            constraint max_len_value(30);
        }
        multi link employees -> Employee;
    }

    type Employee {
        required property first_name -> str;
        required property last_name -> str;
        property full_name := .first_name ++ ' ' ++ .last_name;
        property employee_type -> EmployeeType {
            default := EmployeeType.Internal
        };
        multi link documents -> Document;

        # Full name must be exclusive
        constraint exclusive on ((.first_name, .last_name)) {
            errmessage := 'Full name must be unique'
        }
    }

    scalar type EmployeeType extending enum<Internal, External>;

    type Document {
        required property file_name -> str;
        required property upload_date -> datetime {
            default := datetime_current();
        }
    }

    type Certificate extending Document {
        required property issue_date -> datetime;
    }

    type Contract extending Document {
        required property length -> int16 {
            default := 1;
        }
    }
}

