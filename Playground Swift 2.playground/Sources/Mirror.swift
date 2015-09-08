import Foundation

public
extension Mirror {
    
    public
    func objectMapFromObejct() -> ObjectMap {
        var objectMap = ObjectMap()
        
        for child in self.children {
            let repr = self.mapRepresentationForChild(child)
            let propertyMap = PropertyMap(name: repr.name, type: repr.type, unwrappedType: repr.unwrappedType, normalizedType: repr.normalizedType, isOptional: repr.isOptional)
            objectMap.propertiesMap[repr.name] = propertyMap
        }
        
        return objectMap
    }

    func mapRepresentationForChild(child: Child) -> (isOptional: Bool, name: String, type: Any, unwrappedType: Any, normalizedType: Any) {
        
        let childMirror = Mirror(reflecting: child.value)
        
        
        let childType = childMirror.subjectType
        
        let unwrappedType: Any
        let isOptional: Bool
        if childMirror.displayStyle == .Optional {
            unwrappedType = self.unwrapOptionalType(childMirror.subjectType)
            isOptional = true
        } else {
            unwrappedType = childType
            isOptional = false
        }
        
        var normalizedType: Any
        
        if let type = unwrappedType as? MapTypeNormalizable.Type {
            normalizedType = type.normalizedType()
        } else {
            normalizedType = childType
        }
        
        return (isOptional: isOptional, name: child.label!, type: childType, unwrappedType: unwrappedType, normalizedType: normalizedType)
    }
    
    func unwrapOptionalType(type: Any) -> Any {
        if let type = type as? GenericType.Type {
            return type.firstGenericSubtype()
        }
        return type
    }
}
