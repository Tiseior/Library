package entities;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;

@Valid
public abstract class Human {
    private int id;
    @NotEmpty(message = "Name should not be empty")
    @Size(min = 2, max = 100, message = "Invalid name")
    private String name;
    @NotEmpty(message = "Surname should not be empty")
    @Size(min = 2, max = 100, message = "Invalid surname")
    private String surname;
    public Human() {}
    public Human(String name, String surname) {
        this.name = name;
        this.surname = surname;
    }
    public String getName() {return name;}
    public void setName(String name) {this.name = name;}
    public String getSurname() {return surname;}
    public void setSurname(String surname) {this.surname = surname;}
    public int getId() {return id;}
    public void setId(int id) {this.id = id;}
}
