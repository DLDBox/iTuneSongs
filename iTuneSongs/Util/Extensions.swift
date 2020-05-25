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
           if let navVC = controller as? UINavigationController,
               let visibleVC = navVC.visibleViewController {
               presentFromController(controller: visibleVC, animated: animated, completion: completion)
           } else
               if let tabVC = controller as? UITabBarController,
                   let selectedVC = tabVC.selectedViewController {
                   presentFromController(controller: selectedVC, animated: animated, completion: completion)
               } else {
                   controller.present(self, animated: animated, completion: completion);
           }
       }
}

