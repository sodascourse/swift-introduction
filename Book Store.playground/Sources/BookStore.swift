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
