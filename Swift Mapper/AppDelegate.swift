//
//  AppDelegate.swift
//  Swift Mapper
//
//  Created by qqqqq on 27/07/15.
//  Copyright (c) 2015 Anton Belousov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
}


class ObjectCreator {
    static var sharedCreator = ObjectCreator()
    
    func createObjectWithType(type: Any, fromDictionary:Dictionary<NSObject, AnyObject>) -> Any? {
    
        return nil
    }
    
    func createFromSource<T>(source: AnyObject, type:T.Type) -> T? {
    
        if let source = source as? Dictionary<NSObject, AnyObject>,
            let l = self.createObjectWithType(type, fromDictionary: source) as? T {
                return l
        }
        return nil
    }
    
    
    
    //TODO: словарь -> объект (заложить опциональщину)
    //TODO: массив словарей -> массив объектов
    //TODO: кастомные конвертеры для пропертей (в т.ч. для дат), сразу заложить конвертирование через замыкание
    //TODO: маппер для пропертей (сложная структура объектов, маппинг через кей-пасс, точное указание ключа и/или имени проперти)
    //TODO: отдельный режим для работы с опциональными типами (если значение не опциональное, оно должно быть смаплено из исходных данных иначе ->  сообщение об ошибке)
    //TODO: дичь (массив дат и тп)
}
