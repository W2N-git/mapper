//
//  Aux.swift
//  Swift Mapper
//
//  Created by Anton Belousov on 03/08/15.
//  Copyright (c) 2015 Anton Belousov. All rights reserved.
//

import Foundation

protocol GenericType {
    static func firstGenericSubtype() -> Any.Type
    func firstGenericSubtype() -> Any.Type
}

extension Optional: GenericType {
    static func firstGenericSubtype() -> Any.Type { return T.self }
    func firstGenericSubtype() -> Any.Type { return T.self }
}

extension Array: GenericType {
    static func firstGenericSubtype() -> Any.Type { return Element.self }
    func firstGenericSubtype() -> Any.Type { return Element.self }
}

class TypeNormalizer {
    var fromType : Any.Type
    var toType: Any.Type
    init(fromType: Any.Type, toType: Any.Type) {
        self.fromType = fromType
        self.toType = toType
    }
}

protocol INITABLE {
    init()
}

extension Array: INITABLE {}
extension NSArray : INITABLE {}


func foo<T:INITABLE>(type: T.Type? = nil) -> T? {
    println("FUNC: \(__FUNCTION__), LINE:\(__LINE__), T:\(T.self)")
    let obj = T()
    println("FUNC: \(__FUNCTION__), LINE:\(__LINE__), obj:\(obj)")
    return obj
}

