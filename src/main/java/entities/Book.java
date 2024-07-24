package entities;

import jakarta.validation.Valid;
import jakarta.validation.Validator;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;

@Valid
public class Book {
    @NotEmpty(message = "Title should not be empty")
    @Size(min = 2, max = 100, message = "Invalid book title")
    private String title;
    @NotEmpty(message = "Author should not be empty")
    private int author;
    @Min(value = 0, message = "Quantity should be greater than 0")
    private int quantity;
    public Book() {}
    public Book(String title, int author, int quantity) {
        this.title = title;
        this.author = author;
        this.quantity = quantity;
    }
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public int getAuthor() {
        return author;
    }
    public void setAuthor(int author) {this.author = author;}
    public int getQuantity() {return quantity;}
    public void setQuantity(int quantity) {this.quantity = quantity;}
}
