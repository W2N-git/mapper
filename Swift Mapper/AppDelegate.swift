//
//  AppDelegate.swift
//  Swift Mapper
//
//  Created by qqqqq on 27/07/15.
//  Copyright (c) 2015 Anton Belousov. All rights reserved.
//

import UIKit

protocol GenericType {
    static func firstGenericSubtype() -> Any
}

extension Optional: GenericType {
    static func firstGenericSubtype() -> Any { return T.self }
}


class TestClass: NSObject {
    var number: NSNumber!
}


class ObjectMap {
    var propertiesMap: Dictionary<String, PropertyMap> = [:]
}

class PropertyMap {
    var type: Any!
    var name: String!
//    var innerType : Any! for optionals and arrays
//    var dictionaryKey: String?
//    var converter: Any?
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
//        let k = ObjectCreator.sharedCreator.createFromDictionary(["key" : 123], type: TestClass.self)
        
        return true
    }
}


class ObjectCreator {
    static var sharedCreator = ObjectCreator()
    //TODO: Dictionary -> Object

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

            let obj = Type()
            
            //???: Added temprorary, because of NSNumber. If you create NSNumber(), new object will have address 0x0, that causes problems. But actually you never  pass NSNumber as Type here
            if ObjectIdentifier(obj).uintValue == 0 {
                return nil
            }
            
            let objectMap = self.objectMap(obj)
            
            for (key, element) in dictionary {
                let propertyKey = objectMap.propertiesMap[key]
            }
            
            return obj as? T
        }
        
        return nil
    }
    
    func objectMap(object: AnyObject) -> ObjectMap {

        let mirror = reflect(object)
        
        for index in 0..<mirror.count {
            let mirrorElement = mirror[index]
            println("FUNC: \(__FUNCTION__), LINE:\(__LINE__), |\(mirrorElement.0)|, |\(mirrorElement.1)|")
        }
        
        return ObjectMap()
    }
    
    func convertValue(value: NSObject, fromType: Any, toType: Any) -> NSObject? {
        return nil
    }
    
    //TODO: Add optional types of propertise handling
    
    //TODO: Array of Dictionaries -> Array of Objects
    
    //TODO: Array of Any Types -> Array of Needed Types
    
    //TODO: кастомные конвертеры для пропертей (в т.ч. для дат), сразу заложить конвертирование через замыкание
    //TODO: маппер для пропертей (сложная структура объектов, маппинг через кей-пасс, точное указание ключа и/или имени проперти)
    //TODO: отдельный режим для работы с опциональными типами (если значение не опциональное, оно должно быть смаплено из исходных данных иначе ->  сообщение об ошибке)
    //TODO: дичь (массив дат и тп)
}
