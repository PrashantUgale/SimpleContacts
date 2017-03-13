//
//  UIViewControllerExtension.swift
//  Simple Contacts
//
//  Created by Prashant Ugale on 13/03/17.
//  Copyright © 2017 prashantWork. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithAction(title: String?, message: String, okHandler: @escaping ((UIAlertAction) -> Void), cancelHandler: @escaping ((UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: okHandler)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelHandler)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}
