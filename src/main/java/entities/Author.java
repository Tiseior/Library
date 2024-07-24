package entities;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;

@Valid
public class Author extends Human {
    public Author() {
    }
    public Author(String name, String surname) {
        super(name, surname);
    }
}
