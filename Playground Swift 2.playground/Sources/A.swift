import Foundation

//TODO: add custom converters to objects (create protocol)
public
struct PropertyMap: CustomStringConvertible {
    //    var type: Any.Type // without optionals, e.g. "Optional<Int>" makes "Int" etc.
    public let name: String // without optionals, e.g. "Optional<Int>" makes "Int" etc.
    public let type: Any // can be optional
    public let unwrappedType: Any // without Optional // Optional<Int> makes Int
    public let normalizedType: Any // Normalized from different kind of equivalent types (such as numbers, strings, arrays and others) to that primitives
    public let isOptional: Bool
    
    public var isNil = false
    
    public init(name:String, type: Any, unwrappedType: Any, normalizedType: Any, isOptional: Bool) {
        self.name           = name
        self.type           = type
        self.unwrappedType  = unwrappedType
        self.normalizedType = normalizedType
        self.isOptional     = isOptional
    }
    
    //    var dictionaryKey: String?
    //    var converter: Any?

    public var description: String { return "PropertyMap. name:\(self.name), type:\(self.unwrappedType), normalizedType:\(self.normalizedType), isOpt:\(self.isOptional)" }
}

public
struct ObjectMap {
    public init(){}
    public var propertiesMap: Dictionary<String, PropertyMap> = [:]

    public var description: String { return self.propertiesMap.map{ $0.1.description}.joinWithSeparator("\n") }
}