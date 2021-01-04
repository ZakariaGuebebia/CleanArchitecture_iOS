//
//  SizeHelper.swift
//  CombineProject
//
//  Created by zakaria.guebebia on 22/12/2020.
//  Copyright © 2020 zakaria.guebebia. All rights reserved.
//

import Foundation
import SwiftUI

let defaultReferenceScreenWidth: CGFloat = (UIDevice().userInterfaceIdiom == .pad) ? 630 : 375.0


extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

func getFormattedSize(_ size: CGFloat) -> CGFloat {
    let widthScreen: CGFloat =  UIScreen.main.bounds.size.width
    let result = CGFloat(size) * (widthScreen / defaultReferenceScreenWidth)
    return result
}
