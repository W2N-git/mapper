import Foundation

//MARK: -
//MARK: - Base

public
protocol MapReflectable {
    static func normalizedType() -> Any
}

public
protocol MapTypeNormalizable {
    static func normalizedType() -> Any
    func normalizedType() -> Any
}

extension MapTypeNormalizable {
    
    static func normalizedType() -> Any {
        if let type = self as? MapReflectable.Type {
            return type.normalizedType()
        } else {
            return self
        }
    }

    public func normalizedType() -> Any {
        return self.dynamicType.normalizedType()
    }
}

//MARK: -
//MARK: - Numbers

extension Bool: MapReflectable {
    public static func normalizedType() -> Any { return NSNumber.self }
}

extension UInt: MapReflectable {
    public static func normalizedType() -> Any { return NSNumber.self }
}

extension Int: MapReflectable {
    public static func normalizedType() -> Any { return NSNumber.self }
}

extension Float: MapReflectable {
    public static func normalizedType() -> Any { return NSNumber.self }
}

extension Double: MapReflectable {
    public static func normalizedType() -> Any { return NSNumber.self }
}

extension NSNumber: MapReflectable {
    public static func normalizedType() -> Any { return NSNumber.self }
}

extension Bool: MapTypeNormalizable {}
extension UInt: MapTypeNormalizable {}
extension Int: MapTypeNormalizable {}
extension Float: MapTypeNormalizable {}
extension Double: MapTypeNormalizable {}
extension NSNumber: MapTypeNormalizable {}

//MARK: -
//MARK: - Strings

extension String: MapReflectable {
    public static func normalizedType() -> Any { return NSString.self }
}

extension NSString: MapReflectable {
    public static func normalizedType() -> Any { return NSString.self }
}

extension String: MapTypeNormalizable {}
extension NSString: MapTypeNormalizable {}

//MARK: -
//MARK: - Array

extension Array: MapReflectable {
    public static func normalizedType() -> Any { return NSArray.self }
}

extension NSArray: MapReflectable {
    public static func normalizedType() -> Any { return NSArray.self }
}

extension Array: MapTypeNormalizable {}
extension NSArray: MapTypeNormalizable {}

//MARK: -
//MARK: - Dictionary

extension Dictionary: MapReflectable {
    public static func normalizedType() -> Any { return NSDictionary.self }
}

extension NSDictionary: MapReflectable {
    public static func normalizedType() -> Any { return NSDictionary.self }
}

extension Dictionary: MapTypeNormalizable {}
extension NSDictionary: MapTypeNormalizable {}

//MARK: -
//MARK: - NSDate

extension NSDate: MapReflectable {
    public static func normalizedType() -> Any { return NSDate.self }
}

extension NSDate: MapTypeNormalizable{}
