import UIKit
import PlaygroundSupport

public typealias Book = (title: String, author: String, price: Double)


// MARK: - Book Store (Model and Main class)

public struct BookStore {

    public init() {}

    // MARK: Function interfaces

    var totalBookPrice: Double = 0
    var books: [Book] = []
    var authors: [String] = []

    public mutating func setDataSource(priceCalculator totalBookPrice: (() -> Double)) {
        self.totalBookPrice = totalBookPrice()
    }

    public mutating func setDataSource<Authors: Collection>(authorsGetter distinctAuthors: (() -> Authors))
        where Authors.Iterator.Element == String {
            self.authors = Array(distinctAuthors())
    }

    public mutating func setDataSource(booksCounter: (() -> Int), bookGetter: ((Int) -> Book?)) {
        var books = [Book]()
        for bookIndex in 0..<booksCounter() {
            guard let book = bookGetter(bookIndex) else {
                print("Cannot get book at index: \(bookIndex)")
                return
            }
            books.append(book)
        }
        self.books = books
    }

    // MARK: View init and Playground support

    public func showInPlayground() {
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 480, height: 640))
        window.rootViewController = self.createRootViewController()
        window.makeKeyAndVisible()
        window.setNeedsDisplay()
        PlaygroundPage.current.liveView = window
    }

    func createRootViewController() -> UIViewController {
        let bookListViewController = BookListViewController(style: .plain)
        bookListViewController.authors = self.authors
        bookListViewController.books = self.books
        bookListViewController.totalPrice = self.totalBookPrice

        return UINavigationController(rootViewController: bookListViewController)
    }
}


// MARK: - Book List (View and Controller)

class BookListViewController: UITableViewController {

    var authors: [String] = []
    var books: [Book] = []
    var totalPrice: Double = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Book Shopping Cart ($\(self.totalPrice))"
    }

    // MARK: Table View Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.authors.count
        case 1:
            return self.books.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Authors"
        case 1:
            return "Books"
        default:
            return nil
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "BookCell"
        let cell = (tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) ??
            UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier))

        if indexPath.section == 0 {
            self.setup(authorCell: cell, at: indexPath.row)
        } else if indexPath.section == 1 {
            self.setup(bookCell: cell, at: indexPath.row)
        }

        return cell
    }

    func setup(authorCell cell: UITableViewCell, at index: Int) {
        let author = self.authors[index]
        cell.textLabel!.text = author
    }

    func setup(bookCell cell: UITableViewCell, at index: Int) {
        let book = self.books[index]
        cell.textLabel!.text = "\(book.title) ($\(book.price))"
        cell.detailTextLabel!.text = book.author
    }

    // MARK: Table View Delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}


// MARK: - Solution Shortcuts

public extension BookStore {

    public static func from(_ books: [[String: String]]) -> BookStore {
        func distinctAuthors() -> Set<String> {
            var authors = Set<String>()
            for book in books {
                if let author = book["author"] {
                    authors.insert(author)
                }
            }
            return authors
        }
        func totalBookPrice() -> Double {
            var result = 0.0
            for book in books {
                if let priceString = book["price"], let price = Double(priceString) {
                    result += price
                }
            }
            return result
        }
        func booksCount() -> Int {
            return books.count
        }
        func getBook(at index: Int) -> (title: String, author: String, price: Double)? {
            guard index < books.count else {
                return nil
            }
            let book = books[index]
            guard let priceString = book["price"], let price = Double(priceString) else {
                print("Cannot get price for book at index \(index)")
                return nil
            }
            guard let title = book["title"] else {
                print("Cannot get title for book at index \(index)")
                return nil
            }
            guard let author = book["author"] else {
                print("Cannot get author for book at index \(index)")
                return nil
            }
            return (title, author, price)
        }

        var bookStore = BookStore()
        bookStore.setDataSource(authorsGetter: distinctAuthors)
        bookStore.setDataSource(priceCalculator: totalBookPrice)
        bookStore.setDataSource(booksCounter: booksCount, bookGetter: getBook(at:))
        return bookStore
    }

    /*
    // Closure and Collection API Version:

    public static func from(_ books: [[String: String]]) -> BookStore {
        var bookStore = BookStore()
        bookStore.setDataSource {
            Set(books.flatMap { $0["author"] })
        }
        bookStore.setDataSource {
            books.flatMap { $0["price"] }.flatMap { Float($0) }.reduce(0) { $0 + $1 }
        }
        bookStore.setDataSource(booksCount: { books.count }) { (bookIndex) -> Book? in
            guard bookIndex < books.count else {
                return nil
            }
            let book = books[bookIndex]
            guard let priceString = book["price"], let price = Float(priceString) else {
                print("Cannot get price for book at index \(bookIndex)")
                return nil
            }
            guard let title = book["title"] else {
                print("Cannot get title for book at index \(bookIndex)")
                return nil
            }
            guard let author = book["author"] else {
                print("Cannot get author for book at index \(bookIndex)")
                return nil
            }
            return (title, author, price)
        }

        return bookStore
    }
 
    */
}
