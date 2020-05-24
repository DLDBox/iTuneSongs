//
//  iTunesDetailViewController.swift
//  iTuneSongs
//
//  Created by Dana Devoe on 5/23/20.
//  Copyright © 2020 Dana Devoe. All rights reserved.
//

import Foundation
import UIKit
import WebKit

/* Use to display the detail earth quake data
 */
class iTunesDetailViewController: UIViewController {
    
    //
    //MARK: - IBOutlet section
    //
       
    @IBOutlet weak var webView: WKWebView!
    
    //
    //MARK: - Private member section
    //
    private var detailURL: URL? = nil // encapsulate the member, OOD
    
    
    //
    //MARK: - View Controller life cycel
    //
    override func viewDidLoad() {
        
        if let detailURL = self.detailURL {
            let _ : WKNavigation? = self.webView.load(URLRequest(url: detailURL))
            self.webView.allowsBackForwardNavigationGestures = true
        } else {
            print( "No URL provided" )
        }
        
    }
    
    // Setup the URL before the window instantiates
    func loadWeb( _ url: String ) {
        self.detailURL = URL( string: url )
    }
}
