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

        # Full name must be exclusive
        constraint exclusive on ((.first_name, .last_name)) {
            errmessage := 'Full name must be unique'
        }
    }
}
