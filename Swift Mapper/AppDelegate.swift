//
//  AppDelegate.swift
//  Swift Mapper
//
//  Created by qqqqq on 27/07/15.
//  Copyright (c) 2015 Anton Belousov. All rights reserved.
//

import UIKit



class TestClass: NSObject {
    
    var number: NSNumber = NSNumber(bool: true)
    var string: NSString?
    
    var bool: Bool?
    var int: Int = 10
    var float: Float = 10
    var cgFloat: CGFloat?
    var double: Double = 0.5
    var timeInterval: NSTimeInterval!
    var date: NSDate =  NSDate()
}



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

//        let k: TestClass? = ObjectCreator.sharedCreator.createFromDictionary([
//            "number" : NSNumber(double: 100.500),
//        
//            "string" : "AbraKadabra",
//            "bool" : true,
//            
//            "int" : Int(666),
//            "float" : Float(234.567),
//            "cgFloat" : CGFloat(7878.7878),
//            "double" : Double(90.90),
//            
//            "timeInterval" : NSTimeInterval(23.34),
//            "date" : NSDate(),
//            ])
        if var array: Array<String> = foo() {
            array.append("asdf")
            print("FUNC: \(__FUNCTION__), LINE:\(__LINE__), array:\(array)", terminator: "")
            print("FUNC: \(__FUNCTION__), LINE:\(__LINE__), reflect:\(array.firstGenericSubtype())", terminator: "")
        }
        

//        let k: Array<String>? = ObjectCreator.sharedCreator.createFromDictionary([:])
        
        
        return true
    }
}




