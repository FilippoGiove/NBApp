//
//  FontConvertible.swift
//  AesyBite
//
//  Created by Filippo Giove on 10/02/2021.
//  Copyright © 2020 Filippo Giove. All rights reserved.
//

import UIKit

public protocol FontConvertible {
    
    var name: String { get }
    var fontName: String { get }
    var pointSize: CGFloat { get }
    
}
