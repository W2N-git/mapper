//: Playground - noun: a place where people can play

import UIKit

class TypeConverter {
    
    var fromType: Any
    var toType:   Any
    
    var convertingClosure: ((Any) -> (Any?)) = {_ in return nil}
    func convert(value: Any) -> Any? { return convertingClosure(value) }
    
    init(fromType: Any, toType: Any) {
        self.fromType = fromType
        self.toType = toType
    }
}

class TypeNormalizeContainer {
    var fromType: Any
    var toType:   Any
    init(fromType: Any, toType: Any) {
        self.fromType = fromType
        self.toType   = toType
    }
}

class FromDateConverter: TypeConverter {
    var dateFormatter = NSDateFormatter()
    init(format:String) {
        super.init(fromType: NSDate.self, toType: String.self)
        dateFormatter.dateFormat = format
        self.convertingClosure   = {[unowned self]
            date in
            if let date = date as? NSDate {
                return self.dateFormatter.stringFromDate(date)
            }
            return nil
        }
    }
}

let conv = FromDateConverter(format: "yyyy.MMMM.dd")
conv.fromType
conv.toType

conv.convert(NSDate())


