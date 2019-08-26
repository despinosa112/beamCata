//
//  UIViewController.swift
//  Beam
//
//  Created by Daniel Espinosa on 7/27/19.
//  Copyright © 2019 Daniel Espinosa. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlertWith(title: String, message: String, actions: [UIAlertAction]){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alertController.addAction(action)
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    func addObservers(observerNames: [String]){
        for observerName in observerNames {
            let name = Notification.Name(rawValue: observerName)
            NotificationCenter.default.addObserver(self, selector: #selector(didObserveNotification), name: name, object: nil)
        }
    }
    
    @objc func didObserveNotification(notification: NSNotification){        
    }
    
    
    
}

