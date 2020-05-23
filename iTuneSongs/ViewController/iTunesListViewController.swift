//
//  iTunesListViewController.swift
//  iTuneSongs
//
//  Created by Dana Devoe on 5/22/20.
//  Copyright © 2020 Dana Devoe. All rights reserved.
//

import Foundation
import UIKit

class iTunesListViewController: UITableViewController {
    
    //
    //MARK: - private member section
    //
    let dataSource = iTunesTableViewDataSource()
    
    //
    //MARK: - view life cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.tableView.dataSource = self.dataSource
        super.tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.dataSource.loadSongs(completion: { success in
            DispatchQueue.main.async {
                super.tableView.reloadData()
            }
        })
    }
    
}
