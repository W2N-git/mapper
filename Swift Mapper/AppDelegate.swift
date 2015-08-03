//
//  AppDelegate.swift
//  Swift Mapper
//
//  Created by qqqqq on 27/07/15.
//  Copyright (c) 2015 Anton Belousov. All rights reserved.
//

import UIKit

protocol GenericType {
    static func firstGenericSubtype() -> Any.Type
    func firstGenericSubtype() -> Any.Type
}

extension Optional: GenericType {
    static func firstGenericSubtype() -> Any.Type { return T.self }
    func firstGenericSubtype() -> Any.Type { return T.self }
}


class TestClass: NSObject {
    
//    var object: NSObject?
    var number: NSNumber = NSNumber(bool: true)
//    var view: UIView?
    var string: NSString?
    
    var bool: Bool?
    var int: Int = 10
    var float: Float = 10
    var cgFloat: CGFloat?
    var double: Double = 0.5
//    var rect: CGRect?
    var timeInterval: NSTimeInterval?
    var date: NSDate =  NSDate()
    
//    var array: NSArray?
//    var dict: NSDictionary?

//    typealias Closure = (NSNumber) -> (NSDate)
//    var closure: Closure = {k -> (NSDate) in return NSDate()}
    
//    typealias Tuple = (NSNumber, NSDate)
//    var tuple: Tuple = (100500, NSDate())
}

class TypeNormalizer {
    var fromType : Any.Type
    var toType: Any.Type
    init(fromType: Any.Type, toType: Any.Type) {
        self.fromType = fromType
        self.toType = toType
    }
}


class ObjectMap {
    var propertiesMap: Dictionary<String, PropertyMap> = [:]
}

class PropertyMap: Printable {
    var type: Any.Type // without optionals, e.g. "Optional<Int>" makes "Int" etc.
    var name: String

    init(name:String, type: Any.Type) {
        self.name = name
        self.type = type
    }
    
    var isOptional = false
//    var innerType : Any! for optionals and arrays
//    var dictionaryKey: String?
//    var converter: Any?
    var description: String { return "PropertyMap. type:\(self.type), name:\(self.name), isOpt:\(self.isOptional)" }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

//        let dateString = "1999.12.12"
//        let converter  = DateConverter<NSDate, NSString>(format: "yyyy.MM.dd")
//        let date       = converter.convert(dateString)
//        println("dateString:\(dateString) string:\(date)")
//        
//        
//        let object    = TestClass()
//        let mirror    = reflect(object)
//        let valueType = mirror.valueType
        
//        let type = TestClass.self
//        let k = ObjectCreator.sharedCreator.createFromDictionary(["number":"12"], type: TestClass.self)

        
        let k: TestClass? = ObjectCreator.sharedCreator.createFromDictionary([
//            "object" : "null",
            "number" : NSNumber(double: 100.500),
            
//            "view" : "null",
            "string" : "AbraKadabra",
            "bool" : true,
            
            "int" : Int(666),
            "float" : Float(234.567),
            "cgFloat" : CGFloat(7878.7878),
            "double" : Double(90.90),
//            "rect" : "null",
            
            "timeInterval" : NSTimeInterval(23.34),
            "date" : NSDate(),
//            "array" : "null",
//            "dict" : "null",
//            "closure" : "null",
//            "tuple" : "tuple",
            ])
        
        
        
        return true
    }
}

class TypeConverter {

    var fromType: Any.Type
    var toType:   Any.Type
    
//    var convertingClosure: ((Any) -> (Any?)) = {_ in return nil}
    func convert(value: Any) -> Any? { return nil /*return convertingClosure(value)*/ }
    
    init(fromType: Any.Type, toType: Any.Type) {
        self.fromType = fromType
        self.toType   = toType
    }
}


class GenericTypeConverter<FROM, TO>: TypeConverter {
    override func convert(value: Any) -> Any? {
        println(value)
        println(FROM.self)
        if let fromValue = value as? FROM,
            let toValue = self.convertingClosure(fromValue) {
                return toValue
        }
        return nil
    }

    var convertingClosure: (FROM) -> (TO?) = {_ in return nil}
    
    init(fromType: FROM.Type, toType: TO.Type, convertingClosure: ((FROM) -> (TO?))? = nil) {
        super.init(fromType: fromType, toType: toType)
        if let convertingClosure = convertingClosure {
            self.convertingClosure = convertingClosure
        }
    }
}

class DateConverter<FROM, TO>: GenericTypeConverter<NSString, NSDate> {
    var dateFormatter = NSDateFormatter()
    init(format:String) {
    
        self.dateFormatter.dateFormat = format
        let dateFormatter = self.dateFormatter
        
        super.init(fromType: NSString.self, toType: NSDate.self, convertingClosure: {
            string in
            return dateFormatter.dateFromString(string as String)
        })
    }
}


class ObjectCreator {
    static var sharedCreator = ObjectCreator()

    var typeNormalizers: [TypeNormalizer] = []
    
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

        case let _ as String.Type,
            let _ as NSString.Type:
            return NSString.self

        case let type as NSDate.Type:
            return NSDate.self
        default:
            return type
        }
    }
    
    //TODO: Dictionary -> Object
    //TODO: Add optional types of properties handling
    
    ///  Generic method for generating objects of needed type from source dictionary
    ///
    ///  :param: dictionary Source dictionary
    ///  :param: type       Needed object type, can be nil. If nil needed type must be provided implicitly, like this
    ///      let k: NSNumber? = ObjectCreator.sharedCreator.createFromDictionary(["key" : 123])
    ///
    ///  :returns: Object of needed type or nil (should be rewritten on Swift 2.0)
    func createFromDictionary<T>(dictionary: Dictionary<String, NSObject>, type: T.Type? = nil) -> T? {

        println("FUNC: \(__FUNCTION__), LINE:\(__LINE__), type: \(T.self)")

        //???: Now can create only subclass of NSObject
        if let Type = T.self as? NSObject.Type {
            println("FUNC: \(__FUNCTION__), LINE:\(__LINE__), type: \(T.self)")

            let generetadObject = Type()
            
            //???: Added temprorary, because of NSNumber. If you create NSNumber(), new object will have address 0x0, that causes problems. But actually you never  pass NSNumber as Type here
            if ObjectIdentifier(generetadObject).uintValue == 0 {
                return nil
            }
            println("FUNC: \(__FUNCTION__), LINE:\(__LINE__), type: \(T.self)")

            let objectMap = self.objectMap(generetadObject)
            println("FUNC: \(__FUNCTION__), LINE:\(__LINE__), type: \(T.self)")

            for (propertyName, propertyMap) in objectMap.propertiesMap {
           
                if let element = dictionary[propertyName] {
                    let elementType            = reflect(element).valueType
                    let normalizedElementType  = self.normalizedTypeForType(elementType)
                    let normalizedPropertyType = self.normalizedTypeForType(propertyMap.type)
                    println("FUNC: \(__FUNCTION__), LINE:\(__LINE__), property: \(propertyName) FROM TYPE:\(normalizedElementType), TO TYPE:\(normalizedPropertyType)")

                    if propertyMap.isOptional && normalizedPropertyType is NSNumber.Type && !(propertyMap.type is NSNumber.Type) {
                        println("FUNC: \(__FUNCTION__), LINE:\(__LINE__), only NSNumber can be set to non-NSNumber Optional Property, current property type: Optional<\(propertyMap.type)>")
                        continue;
                    }
                    
                    if reflect(normalizedElementType).summary == reflect(normalizedPropertyType).summary {
                        generetadObject.setValue(element, forKey: propertyName)
                    }
                    
                }
            }
            
            return generetadObject as? T
        }
        return nil
    }
    
    
    func objectMap(object: AnyObject) -> ObjectMap {

        let mirror    = reflect(object)
        let objectMap = ObjectMap()
        
        for index in 0..<mirror.count {
            let mirrorElement    = mirror[index]
            let propertyName     = mirrorElement.0
            let propertyMirror   = mirrorElement.1
            let propertyRawType  = propertyMirror.valueType
            let propertyRawValue = propertyMirror.value
            
            let propertyMap: PropertyMap
            
            if reflect(propertyRawValue).disposition == .Optional,
                let r = propertyRawValue as? GenericType {
                    let type               = r.firstGenericSubtype()
                    propertyMap            = PropertyMap(name: propertyName, type: type)
                    propertyMap.isOptional = true

            } else {
                propertyMap = PropertyMap(name: propertyName, type: propertyRawType)
            }
            
            objectMap.propertiesMap[propertyName] = propertyMap
        }
        return objectMap
    }
    
    typealias Converter = (Any) -> (Any?)
    
    func converterFromType(type: Any.Type, toType: Any.Type) -> Converter? {
        return nil
    }
    
    
    //TODO: Array of Dictionaries -> Array of Objects
    
    //TODO: Array of Any Types -> Array of Needed Types
    
    //TODO: кастомные конвертеры для пропертей (в т.ч. для дат), сразу заложить конвертирование через замыкание
    //TODO: маппер для пропертей (сложная структура объектов, маппинг через кей-пасс, точное указание ключа и/или имени проперти)
    //TODO: отдельный режим для работы с опциональными типами (если значение не опциональное, оно должно быть смаплено из исходных данных иначе ->  сообщение об ошибке)
    //TODO: дичь (массив дат и тп)
}
