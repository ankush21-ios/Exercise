//
//  UIApplicationExtension.swift
//  Exercise
//
//  Created by Ankush Mahajan on 06/04/22.
//

import Foundation
import UIKit

extension UIApplication {
    
    class func window() -> UIWindow {
        
        var window: UIWindow?
        
        if #available(iOS 13.0, *) {
            window = UIApplication.shared.windows.first
        } else {
            window = UIApplication.shared.keyWindow
        }
        
        return window ?? UIWindow()
    }
}
