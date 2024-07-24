package entities;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;

public class User extends Human {
    @Email
    private String email;
    @NotEmpty(message = "Password should not be empty")
    @Size(min = 3, max = 50, message = "Invalid password length")
    private String password;
    private String access;
    public User() {}
    public User(String name, String surname, String login, String password) {
        super(name, surname);
        this.email = login;
        this.password = password;
    }
    public String getEmail() {return email;}
    public void setEmail(String login) {this.email = login;}
    public String getPassword() {return password;}
    public void setPassword(String password) {this.password = password;}
    public String getAccess() {return access;}
    public void setAccess(String access) {this.access = access;}
}
