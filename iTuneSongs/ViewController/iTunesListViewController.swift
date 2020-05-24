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
    
    //
    //MARK: - UITableViewControllerDelegate section
    //
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        NetMinder.shared.accessible { yes in
            
            if yes {
                DispatchQueue.main.async {
                    if let item = self.dataSource.item( at: indexPath.row )  {
                        self.performSegue( withIdentifier: "DetailSegue", sender: item.art )
                    }
                }
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let urlString = sender as! String
        
        if let iTuneDetail = segue.destination as? iTunesDetailViewController {
            iTuneDetail.loadWeb(urlString)
        } else {
            print( "Error finding the DetailViewController" )
        }
    }
    
    //
    //MARK: - helper section
    //
    @IBAction func didTouchPlay(_ sender: UIButton) {
        NetMinder.shared.accessible { yes in
            
            if yes {
                let index = sender.tag
            
                DispatchQueue.main.async {
                    if let item = self.dataSource.item( at: index )  {
                        self.performSegue( withIdentifier: "DetailSegue", sender: item.preview )
                    }
                }
            }
        }
    }
    
}
