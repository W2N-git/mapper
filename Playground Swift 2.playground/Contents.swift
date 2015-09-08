//: Playground - noun: a place where people can play

import UIKit

class TestClass: NSObject {
    
    var _number: NSNumber = NSNumber(bool: true)
    var _string: NSString?
    var _bool: Bool?
    
    var _int: Int = 10
    var _float: Float = 10
    var _cgFloat: CGFloat?
    
    var _double: Double = 0.5
    var _timeInterval: NSTimeInterval!
    var _date: NSDate =  NSDate()
    var _date_q: NSDate? =  NSDate()
}


let test = TestClass()

let mirror = Mirror(reflecting: test)
mirror.objectMapFromObejct().description

let type_1: Any.Type = NSObject.self
let type_2_x: Any = NSString.self
let type_2: Any.Type = type_2_x as! Any.Type

if type_1 == NSObject().dynamicType.self {
    print("==")
} else {
    print("<>")
}