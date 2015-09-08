import Foundation

public
protocol GenericType {
    static func firstGenericSubtype() -> Any
    func firstGenericSubtype() -> Any
}

extension Optional: GenericType {
    public static func firstGenericSubtype() -> Any { return Wrapped.self }
    public func firstGenericSubtype() -> Any { return Wrapped.self }
}

extension Array: GenericType {
    public static func firstGenericSubtype() -> Any { return Element.self }
    public func firstGenericSubtype() -> Any { return Element.self }
}