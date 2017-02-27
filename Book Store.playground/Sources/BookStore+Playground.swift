import PlaygroundSupport
import UIKit


extension BookStore {

    enum DataError: Error {
        case invalidAuthor(expected: Set<String>, actual: Set<String>)
        case invalidTotalPrice(expected: Double, actual: Double)
    }

    public func showInPlayground() {
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 420, height: 640))
        do {
            window.rootViewController = try self.createRootViewController()
        } catch DataError.invalidAuthor(let expectedAuthors, let actualAuthors) {
            print("Error: Invalid authors, expect: \(expectedAuthors), get: \(actualAuthors)")
        } catch DataError.invalidTotalPrice(let expectedPrice, let actualPrice) {
            print("Errpr: Invalid total price, expect: \(expectedPrice), get: \(actualPrice)")
        } catch {
            print("Error: Unknown reason ...")
        }

        window.makeKeyAndVisible()
        window.setNeedsDisplay()
        PlaygroundPage.current.liveView = window
    }

    func validateData() throws {
        let validAuthors = Set(self.books.map { $0.author })
        let actualAuthors = Set(self.authors)
        guard validAuthors == actualAuthors  else {
            throw DataError.invalidAuthor(expected: validAuthors, actual: actualAuthors)
        }

        let validTotoalPrice = self.books.map { $0.price }.reduce(0, +)
        guard validTotoalPrice == self.totalBookPrice else {
            throw DataError.invalidTotalPrice(expected: validTotoalPrice, actual: self.totalBookPrice)
        }
    }

    func createRootViewController() throws -> UIViewController {
        try self.validateData()
        let bookListViewController = BookListViewController(style: .plain)
        bookListViewController.authors = self.authors
        bookListViewController.books = self.books
        bookListViewController.totalPrice = self.totalBookPrice
        return UINavigationController(rootViewController: bookListViewController)
    }

}
