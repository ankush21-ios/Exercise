//
//  UIViewControllerExtension.swift
//  Exercise
//
//  Created by Ankush Mahajan on 11/04/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    enum AlertAction {
        case confirm , cancel
    }
    
    func alert(title : String = "Alert" ,
               message : String ) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
        }))
        self.present(ac, animated: true)
    }
    
}
