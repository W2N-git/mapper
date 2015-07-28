//: Playground - noun: a place where people can play

import UIKit

extension MirrorDisposition: Printable {
    
    public var description: String {
        switch (self) {
        case .Struct:
            return "Struct"
        case .Class:
            return "Class"
        case .Enum:
            return "Enum"
        case .Tuple:
            return "Tuple"
        case .Aggregate:
            return "Aggregate"
        case .IndexContainer:
            return "IndexContainer"
        case .KeyContainer:
            return "KeyContainer"
        case .MembershipContainer:
            return "MembershipContainer"
        case .Container:
            return "Container"
        case .Optional:
            return "Optional"
        case .ObjCObject:
            return "ObjCObject"
        }
    }
}

protocol GenericType {
    static func firstGenericSubtype() -> Any
    func firstGenericSubtype() -> Any
}

extension Optional: GenericType {
    static func firstGenericSubtype() -> Any { return T.self }
    func firstGenericSubtype() -> Any { return T.self }
}

extension Array: GenericType {
    static func firstGenericSubtype() -> Any { return Element.self }
    func firstGenericSubtype() -> Any { return Element.self }
}

class TestClass: NSObject {
    var number = 10
    var string: NSString!
}

let object = TestClass()

let mirror = reflect(object)

let type = mirror.valueType
mirror.objectIdentifier
mirror.count
mirror.summary
mirror.quickLookObject
mirror.disposition.description


mirror[0].0
mirror[0].1.value
mirror[0].1.valueType


mirror[1].0
mirror[1].1.value
mirror[1].1.valueType


mirror[2].0
let property            = mirror[2].1.value
let propertyType        = mirror[2].1.valueType
let propertyDisposition = mirror[2].1.disposition

if let r = property as? GenericType {
    println(r.firstGenericSubtype())
}

if propertyDisposition == .Optional,
    let propertyType = propertyType as? GenericType.Type {
        println(propertyType)
//        propertyType.firstGenericSubtype()
}







