//
//  NetMinder.swift
//  DevoeQuakeLocator
//
//  Created by Dana Devoe on 5/13/20.
//  Copyright © 2020 Dana Devoe. All rights reserved.
//

import Foundation
import UIKit
import Network

/* Manages the connection status and provides a mechanism to
 trigger a closure to handle a desired action when the
 connection status changes
 
 NOTE: NWPathMonitor seem to have a bug in the simular and does not
        correctly report when the network connection is re-established, so
        please test netconnectivity recovery on a physical device.
 */
class NetMinder {
    
    //
    //MARK: - Private section
    //
    private let netMonitor: NWPathMonitor
    private var connectClosure: ClosureWithBool?
    private var isInternetAccessible: Bool
    private var alert: UIAlertController?

    //
    //MARK: - Public section
    //
    static let shared = NetMinder()
    
    init() {
        self.netMonitor = NWPathMonitor()
        self.isInternetAccessible = false
        self.connectClosure = nil

        self.setupCallBack()
    }
    
    /* This function is used to test for connectivity and to postpone
     the execution of the closure until connectivity has be re-established.
     
     PARAMETER:
        completion - will return a bool indicating that there is not connectivity
                    and that the call has not been made.  The closure will be called
                    once a connection has been created.
     */
    func accessible( _ completion: @escaping ClosureWithBool ) {
        if self.isInternetAccessible {
            completion(true)
        } else {
            self.connectClosure = completion
        }
    }
    
    //
    //MARK: - helper section
    //
    
    /* This function sets up the NetMinder object
     */
    private func setupCallBack() {
        self.netMonitor.pathUpdateHandler = { path in
            
            if path.status == .satisfied {
                self.isInternetAccessible = true
                
                if let connectClosure = self.connectClosure {
                    connectClosure(true)
                    self.connectClosure = nil
                }
                
                DispatchQueue.main.async {
                    self.alert?.hideNow()
                    self.alert = nil
                }
                
            } else {
                self.isInternetAccessible = false
                
                if self.alert == nil {
                    DispatchQueue.main.async {
                        self.alert = UIAlertController( title:"Network Access Error", message: "Please connect to the internet", preferredStyle: .alert )
                        //self.alert?.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
                         //   self.alert = nil
                        //}))
                        
                        self.alert?.showNow()
                    }
                }
            }
        }
        
        let queue = DispatchQueue.global(qos: .background)
        self.netMonitor.start(queue: queue)
    }
    
}

