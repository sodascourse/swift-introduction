/*:
 
 # Book Store

 This is a simple playground which is a shopping cart of an online book store.
 
 The shopping cart shows authors and books the user wants to buy.
 It shows the total price in the title bar.
 
 For example, I want to buy following books. Each books is represented by 
 a dictionary with 3 keys: `author`, `title`, and `price`.
 
 > You have to open the **Timeline view** if you cannot see the shopping cart.
 
 */

let books: [[String: String]] = [
    ["author": "Dan Brown", "title": "Digital Fortress", "price": "9.99"],
    ["author": "Dan Brown", "title": "Deception Point", "price": "17.00"],
    ["author": "J.K. Rowling", "title": "Harry Potter and the Sorcerer's Stone", "price": "10.99"],
    ["author": "J.K. Rowling", "title": "Harry Potter and the Goblet of Fire", "price": "12.99"],
    ["author": "J.K. Rowling", "title": "Harry Potter and the Deathly Hallows", "price": "14.99"],
    ["author": "村上春樹", "title": "1Q84: Books 1 & 2", "price": "6.99"],
    ["author": "村上春樹", "title": "1Q84: Books 3", "price": "5.99"],
]

/*:
 
 And, let's show the book store shopping cart:
 
 */

var bookStore = BookStore.from(books)
bookStore.showInPlayground()

//: ---
//: [Next ->](@next)
