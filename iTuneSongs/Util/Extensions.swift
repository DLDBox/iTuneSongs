//
//  DateExtension.swift
//  DevoeQuakeLocator
//
//  Created by Dana Devoe on 5/14/20.
//  Copyright © 2020 Dana Devoe. All rights reserved.
//

import Foundation
import UIKit

//
//MARK: - UIAlertController Extension section
//

/* Create some convenience functions for the UIAlertController
 */
extension UIAlertController {

    public func showNow() {
        present(animated: true, completion: nil)
    }
    
    public func hideNow() {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if let rootVC = window?.rootViewController {
            rootVC.dismiss(animated: true, completion: nil)
        }
    }

    func present(animated: Bool, completion: (() -> Void)?) {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if let rootVC = window?.rootViewController {
            presentFromController(controller: rootVC, animated: animated, completion: completion)
        }
    }

     private func presentFromController(controller: UIViewController, animated: Bool, completion: (() -> Void)?) {
           if let nav = controller as? UINavigationController,
               let currentViewController = nav.visibleViewController {
               presentFromController(controller: currentViewController, animated: animated, completion: completion)
           } else {
               controller.present(self, animated: animated, completion: completion);
           }
       }
}

