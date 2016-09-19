
public struct Point: CustomStringConvertible {
    var x: Float
    var y: Float

    init(x: Float, y: Float) {
        self.x = x
        self.y = y
    }

    public var description: String {
        return "(\(self.x), \(self.y))"
    }
}

public struct Size: CustomStringConvertible {
    var width: Float
    var height: Float

    init(width: Float, height: Float) {
        self.width = width
        self.height = height
    }

    public var description: String {
        return "[w=\(self.width), h=\(self.height)]"
    }
}

public struct Rectangle: CustomStringConvertible {
    var origin: Point
    var size: Size

    init(origin point: Point, size: Size) {
        self.origin = point
        self.size = size
    }

    public var description: String {
        return "<Rectangle origin:\(self.origin) size:\(self.size)>"
    }
}

// MARK: - Interface

// second external name is ommited to simulate functions in Java and C++.
public func createRectangle(_ x: Float, _ y: Float, _ width: Float, _ height: Float) -> Rectangle {
    return Rectangle(origin: Point(x: x, y: y), size: Size(width: width, height: height))
}

public func createRectangle(originX x: Float, originY y: Float, width: Float, height: Float) -> Rectangle {
    return Rectangle(origin: Point(x: x, y: y), size: Size(width: width, height: height))
}
