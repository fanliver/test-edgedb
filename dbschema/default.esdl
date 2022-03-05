module default {
    type Company {
        required property name -> str;
        required property address -> str; 
        multi link employees -> Employee;
    }

    type Employee {
        required property first_name -> str;
        required property last_name -> str;
        property full_name := .first_name ++ ' ' ++ .last_name;
    }
}
