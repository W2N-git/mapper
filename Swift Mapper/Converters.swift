//
//  Converters.swift
//  Swift Mapper
//
//  Created by Anton Belousov on 03/08/15.
//  Copyright (c) 2015 Anton Belousov. All rights reserved.
//

import Foundation

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