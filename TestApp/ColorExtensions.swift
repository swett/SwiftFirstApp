
import UIKit

extension UIColor {
    
    static var appColor = UIColor(rgb: 0x007AFF, alpha: 1)
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: alpha
        )
    }
    
    convenience init(rgb: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            alpha: alpha
        )
    }
}

extension UIColor {
    class func color(withData data:Data) -> UIColor {
         return NSKeyedUnarchiver.unarchiveObject(with: data) as! UIColor
    }

    func encode() -> Data {
         return NSKeyedArchiver.archivedData(withRootObject: self)
    }
}

//extension UIImage {
//    class func color(withData data:Data) -> UIImage {
//         return NSKeyedUnarchiver.unarchiveObject(with: data) as! UIImage
//    }
//
//    func encode() -> Data {
//         return NSKeyedArchiver.archivedData(withRootObject: self)
//    }
//}
