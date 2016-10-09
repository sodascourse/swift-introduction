/*:

 # Your shopping cart

 Now, it's your turn to create your shopping list.
 
 Assume that you want to buy following books:

 * "Digital Fortress" by "Dan Brown", $9.99
 * "Angels & Demons" by "Dan Brown", $17.00
 * "The Da Vinci Code" by "Dan Brown", $9.99
 * "Deception Point" by "Dan Brown", $17.00
 * "Harry Potter and the Goblet of Fire" by "J.K. Rowling", $12.99
 * "Harry Potter and the Half-Blood Prince" by "J.K. Rowling", $12.99
 * "Harry Potter and the Deathly Hallows" by "J.K. Rowling", $14.99
 * "旅行與讀書" by "詹宏志", $12.00
 * "國宴與家宴" by "王宣一", $7.99

 Then, let's create a book store first:
 
 */

var bookStore = BookStore()

/*:
 
 Now start to feed data to the book store.
 
 You have to prepare following functions:
 1. A function which returns the name of authors in a set or a list. 
    _Note, you have to remove duplicated authors._
 2. A function which returns the totoal price of books to purchase
 3. A function which returns the number of books to buy
 4. A function which returns a book with its title, author, and price by a given index.
 
 */

// Use this
//func distinctAuthors() -> Set<String> { ... }
// or this
//func distinctAuthors() -> [String] { ... }
// then
//bookStore.setDataSource(authorsGetter: distinctAuthors)

//func totalBookPrice() -> Double { ... }
//bookStore.setDataSource(priceCalculator: totalBookPrice)

//func countBooks() -> Int { ... }
//func getBook(at index: Int) -> (title: String, author: String, price: Double)? { ... }
//bookStore.setDataSource(booksCounter: countBooks, bookGetter: getBook(at:))

/*:

 Finally, let's show the book store shopping cart:

 */

bookStore.showInPlayground()

//: ---
//: [<- Previous](@previous) | [Next ->](@next)
