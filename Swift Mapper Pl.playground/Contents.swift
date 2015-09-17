//: Playground - noun: a place where people can play

import UIKit


let someObject: Any? = "String"

let propertyName = "property" as NSString

let setterName = "set" + propertyName.substringToIndex(1).uppercaseString + propertyName.substringFromIndex(1) + ":"

func normalizedTypeForType(type: Any.Type) -> Any.Type {
    
    switch type {
    case
    let _ as Bool.Type,
    let _ as Int.Type,
    let _ as Float.Type,
    let _ as Double.Type,
    let _ as CGFloat.Type,
    let _ as NSNumber.Type:
        return NSNumber.self
        
    case let _ as String.Type:
        return NSString.self
        
    case let type as NSDate.Type:
        return NSDate.self
    default:
        return type
    }
}

let date = NSNumber(bool: true)
reflect(date).valueType
let tp = normalizedTypeForType(reflect(date).valueType)
reflect(tp).summary

class PropertyMap {
    var type: Any.Type
    init(type: Any.Type) {
        self.type = type
    }
}

let pMap = PropertyMap(type: NSClassFromString("NSObject") as! Any.Type)

if let type = pMap.type as? NSObject.Type {
    let object = type()
}

//
//func set(number: Any, inout toNumber:  Any) {
//    toNumber = number
//}
//
//class NumberClass {
//    var number: Any = 456
//}
//
//var number = 100
//var otherNumber: AnyObject = 666
//
//var numObject = NumberClass()
//
//var numObjectPropValue = reflect(numObject)[0].1.value
//
//set(number as Any, &numObjectPropValue)
//numObjectPropValue
//numObject.number


class NumberClass: NSObject {
    let number: NSNumber = 100
}


//numberObj.number.dynamicType
//numberObj.setValue(666.5, forKey: "number")



//let type1: NSObject.Type? = reflect(NSDate()).valueType as? NSObject.Type
////let type2: AnyClass? = reflect(NSDate()).valueType as? AnyClass
//let type2: NSObject.Type? = NSDate.self as? NSObject.Type
//object_getClassName
//if (type1?.isKindOfClass(type2!) != nil) {
//    println("")
//}

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

let numberObj = NumberClass()
reflect(numberObj)[1].1.quickLookObject//.disposition.description



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
    var string: NSString?
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

func foo(object: Any) {

    if reflect(object).disposition == .Optional,
        let r = object as? GenericType {
    
            let type = r.firstGenericSubtype()

            if let type = type as? NSDate.Type {
            
                println("property is date")
            }
    }
    
    let mirror = reflect(object)
    mirror.valueType
    if let type = mirror.valueType as? NSNumber.Type {
        
    }
}

var obj: NSString = NSString(string: "s")//NSNumber(bool: true)
//foo(obj)
//foo(property)

//problem with nsnumber, nsdate, nsstring


//if propertyDisposition == .Optional,
//    let r = property as? GenericType {
//        let type = r.firstGenericSubtype()
//        if let type = type as? NSString.Type {
//            println("property is string")
//        }
//}



var array: [NSObject] = ["a", "b", "c"]
foo(array[2])

var optInt = NSDate(timeIntervalSinceNow: 0)

let optIntType = reflect(optInt).valueType

if optIntType is NSDate.Type {
    println("")
}
