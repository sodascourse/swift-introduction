/*:

 # Your shopping cart

 Again, it's your turn to create your shopping list.
 But this time, let's try to use `closures` which would be more straightforward.

 Assume that you want to buy following books:

 * "Digital Fortress" by "Dan Brown", $9.99
 * "Angels & Demons" by "Dan Brown", $17.00
 * "The Da Vinci Code" by "Dan Brown", $9.99
 * "Deception Point" by "Dan Brown", $17.00
 * "Harry Potter and the Goblet of Fire" by "J.K. Rowling", $12.99
 * "Harry Potter and the Order of Phoenix" by "J.K. Rowling", $12.99
 * "Harry Potter and the Deathly Hallows" by "J.K. Rowling", $14.99
 * "旅行與讀書" by "詹宏志", $12.00
 * "偵探研究" by "詹宏志", $10.00
 * "國宴與家宴" by "王宣一", $7.99

 Then, let's create a book store first:

 */

var bookStore = BookStore()

/*:

 Now start to feed data to the book store.

 You have to prepare following closures:
 1. A closure which returns the name of authors in a set or a list.
 _Note, you have to remove duplicated authors._
 2. A closure which returns the totoal price of books to purchase
 3. A closure which returns the number of books to buy
 4. A closure which returns a book with its title, author, and price by a given index.
    If the index is out of bound, return `nil`.

 */

// A closure which returns the name of authors in a set.
//bookStore.setDataSource(authorsGetter: { () -> Set<String> in ... })

// A closure which returns the totoal price of books to purchase
//bookStore.setDataSource(priceCalculator: { () -> Double in return 0 })

// A closure which returns the number of books and another closure returns a book by index
//bookStore.setDataSource(bookGetter: { (bookIndex) -> Book? in return nil })

/*:

 Finally, let's show the book store shopping cart:

 */

bookStore.showInPlayground()

//: ---
//: [<- Previous](@previous) | [Next ->](@next)
