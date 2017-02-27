
public extension BookStore {

    public static func from(_ books: [[String: String]]) -> BookStore {
        var bookStore = BookStore()
        // Get distint author names
        bookStore.setDataSource {
            Set(books.flatMap { $0["author"] })
        }
        // Get total price of books to buy
        bookStore.setDataSource {
            books.flatMap { $0["price"] }.flatMap { Double($0) }.reduce(0, +)
        }
        // Get books to buy
        bookStore.setDataSource { (bookIndex) -> Book? in
            guard bookIndex < books.count else {
                return nil
            }
            let book = books[bookIndex]
            guard let priceString = book["price"], let price = Double(priceString) else {
                print("Cannot get price for book at index \(bookIndex): No price")
                return nil
            }
            guard let title = book["title"] else {
                print("Cannot get title for book at index \(bookIndex): No title")
                return nil
            }
            guard let author = book["author"] else {
                print("Cannot get author for book at index \(bookIndex): No author")
                return nil
            }
            return (title, author, price)
        }

        return bookStore
    }
}
