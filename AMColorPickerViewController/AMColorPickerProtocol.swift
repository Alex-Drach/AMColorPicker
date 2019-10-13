//
//  AMColorPickerProtocol.swift
//  SampleAMColorPicker
//
//  Created by am10 on 2019/04/21.
//  Copyright © 2019 am10. All rights reserved.
//

import UIKit

public protocol AMColorPicker: NSObject {
}

public protocol AMColorPickerDelegate: class {
    func colorPicker(_ colorPicker: AMColorPicker, didSelect color: UIColor)
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat) {
        let hexString = hex.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hexString)
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            let red = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let green = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let blue = CGFloat(color & 0x0000FF) / 255.0
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        } else {
            assertionFailure("invalid hex string")
            self.init()
        }
    }
    
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red: red, green: green, blue: blue, alpha: alpha)
    }
    
    var hsba: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var hue:CGFloat = 0
        var saturation:CGFloat = 0
        var brightness:CGFloat = 0
        var alpha:CGFloat = 0
        self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return (hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
    
    var colorCode: String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let rgb = (Int)(red*255)<<16 | (Int)(green*255)<<8 | (Int)(blue*255)<<0
        return String(format: "%06x", rgb)
    }
}

extension CGFloat {
    var colorFormatted: String {
        return String(format: "%.0f", self)
    }
}

extension Float {
    var colorFormatted: String {
        return String(format: "%.0f", self)
    }
}

extension String {
    var cgFloatValue: CGFloat {
        return CGFloat(Float(self)!)
    }
}
