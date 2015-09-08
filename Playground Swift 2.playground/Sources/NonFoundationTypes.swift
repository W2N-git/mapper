import Foundation
import CoreGraphics

extension CGFloat: MapReflectable {
    public static func normalizedType() -> Any { return NSNumber.self }
}
extension CGFloat: MapTypeNormalizable {}