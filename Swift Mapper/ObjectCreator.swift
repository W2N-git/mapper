//
//  ObjectCreator.swift
//  Swift Mapper
//
//  Created by Anton Belousov on 03/08/15.
//  Copyright (c) 2015 Anton Belousov. All rights reserved.
//

import UIKit

class ObjectCreator {
    static var sharedCreator = ObjectCreator()
    
    func normalizedTypeForType(type: Any.Type) -> Any.Type {
        
        switch type {
        case
        _ as Bool.Type,
         _ as Int.Type,
         _ as Float.Type,
         _ as Double.Type,
         _ as CGFloat.Type,
         _ as NSNumber.Type:
            return NSNumber.self
            
        case
         _ as String.Type,
         _ as NSString.Type:
            return NSString.self
            
        case  _ as NSDate.Type:
            return NSDate.self

        case  _ as NSArray.Type:
            return NSArray.self
        
        case  _ as NSDictionary.Type:
            return NSDictionary.self
            
        default:
            return type
        }
    }
    
    func normalizedTypeNameForType(type: Any.Type) -> String {
        return Mirror(reflecting: self.normalizedTypeForType(type)).description//reflect(self.normalizedTypeForType(type)).summary
    }
    
    //TODO: Dictionary -> Object
    //TODO: Add optional types of properties handling
    
    ///  Generic method for generating objects of needed type from source dictionary
    ///
    ///  - parameter dictionary: Source dictionary
    ///  - parameter type:       Needed object type, can be nil. If nil needed type must be provided implicitly, like this
    ///      let k: NSNumber? = ObjectCreator.sharedCreator.createFromDictionary(["key" : 123])
    ///
    ///  - returns: Object of needed type or nil (should be rewritten on Swift 2.0)
    func createFromDictionary<T>(dictionary: Dictionary<String, NSObject>, type: T.Type? = nil) -> T? {
        
        //???: Now can create only subclass of NSObject
        print("FUNC: \(__FUNCTION__), LINE:\(__LINE__), \(T.self)")

        
        if let Type = T.self as? NSArray.Type {
            print("FUNC: \(__FUNCTION__), LINE:\(__LINE__)")
        }
        
        if let Type = T.self as? NSObject.Type {
            print("FUNC: \(__FUNCTION__), LINE:\(__LINE__), type: \(T.self)")
            
            let generetadObject = Type.init()
            /*
            //???: Added temprorary, because of NSNumber. 
                If you create NSNumber(), new object will have address 0x0, that causes problems.
                But actually you never pass NSNumber as Type here. 
                (correction: NSNumber can be passed when nested types)
            */
            if ObjectIdentifier(generetadObject).uintValue == 0 {
                return nil
            }

            self.fillObject(generetadObject, withDictionary: dictionary)
            
            return generetadObject as? T
        }
        return nil
    }
    
    
    func fillObject(object: NSObject, withDictionary dictionary: Dictionary<String, NSObject>) {

        let objectMap = object.objectMap

        for (propertyName, propertyMap) in objectMap.propertiesMap {
            
            if let element = dictionary[propertyName] {
                
                let normalizedElementType  = self.normalizedTypeNameForType(element.dynamicType)
                let normalizedPropertyType = self.normalizedTypeNameForType(propertyMap.type)
                
                if propertyMap.isOptional &&
                    normalizedPropertyType == "NSNumber" &&
                    !(propertyMap.type is NSNumber.Type) {
                        
                    print("Warning!!! Only NSNumber can be set to non-NSNumber Optional Property, property name:\(propertyName) property type: Optional<\(propertyMap.type)>")
                    print("If you want optional use NSNumber, or wait for additional functionality")
                    continue
                }
                
                
                if reflect(normalizedElementType).summary == reflect(normalizedPropertyType).summary {
                    
                    let propertyName = propertyName as NSString
                    let setterName   = "set" + propertyName.substringToIndex(1).uppercaseString + propertyName.substringFromIndex(1) + ":"
                    if object.respondsToSelector(Selector(setterName)) {
                        object.setValue(element, forKey: propertyName as String)
                    }
                }
            }
        }
    }

    //TODO: Array of Dictionaries -> Array of Objects
    
    //TODO: Array of Any Types -> Array of Needed Types
    
    //TODO: кастомные конвертеры для пропертей (в т.ч. для дат), сразу заложить конвертирование через замыкание
    //TODO: маппер для пропертей (сложная структура объектов, маппинг через кей-пасс, точное указание ключа и/или имени проперти)
    //TODO: отдельный режим для работы с опциональными типами (если значение не опциональное, оно должно быть смаплено из исходных данных иначе ->  сообщение об ошибке)
    //TODO: дичь (массив дат и тп)
}

extension NSObject {
    var objectMap: ObjectMap {
        let mirror    = reflect(self)
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
}
