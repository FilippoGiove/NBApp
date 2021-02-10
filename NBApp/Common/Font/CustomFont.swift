//
//  CustomFont.swift
//  AesyBite
//
//  Created by Filippo Giove on 10/02/2021.
//  Copyright © 2020 Filippo Giove. All rights reserved.
//

import Foundation
import UIKit

public struct CustomFont: FontConvertible {
    
    public let name: String
    public let fontName: String
    public let pointSize: CGFloat
    
    public init(name: String, fontName: String, pixelSize: CGFloat) {
        self.name = name
        self.fontName = fontName
        self.pointSize = pixelSize
    }
    
    public init(font: UIFont) {
        self.name = font.fontName
        self.fontName = font.fontName
        self.pointSize = font.pointSize
    }
    
}

extension FontConvertible {
    
    public var uiFont: UIFont! {
        return UIFont(name: self.fontName, size: self.pointSize)!
    }
    
}
