
public protocol 🍜: Equatable, CustomStringConvertible {
    var flavor: String { get }
}

// MARK: - Comparison

public func ==<T: 🍜, U: 🍜>(lhs: T, rhs: U) -> Bool {
    return lhs.flavor == rhs.flavor
}

// MARK: toString

extension 🍜 {
    public var description: String {
        return "\(self.flavor)ラーメン"
    }
}

// MARK: - Subclasses

public struct 醤油🍜: 🍜 {
    public var flavor: String {
        return "醤油"
    }
    public init() {}
}

public struct 塩🍜: 🍜 {
    public var flavor: String {
        return "塩"
    }
    public init() {}
}
