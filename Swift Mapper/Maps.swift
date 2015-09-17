//
//  Maps.swift
//  Swift Mapper
//
//  Created by Anton Belousov on 03/08/15.
//  Copyright (c) 2015 Anton Belousov. All rights reserved.
//

import Foundation

class ObjectMap {
    var propertiesMap: Dictionary<String, PropertyMap> = [:]
}

class PropertyMap: CustomStringConvertible {
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