//
//  iTunesListViewController.swift
//  iTuneSongs
//
//  Created by Dana Devoe on 5/22/20.
//  Copyright © 2020 Dana Devoe. All rights reserved.
//

import Foundation
import UIKit

/* This class uses the iTunesTableVieDataSource object to download
 and supply the iTunes data for display
 
 Each network request is performed within a NetMinder.acess() closure to determine
 if network connection exist, if not, the closure is execute once
 the network connection is re-established.
 
 NOTE: The re-establishment of the network connection does not seem
       to operated correctly on the simulator. So please test the
       network loss detection on an actual device.
 */
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
                        self.performSegue( withIdentifier: K.detailSegue, sender: item.art )
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

    // The play button function, to play the audio just launch the preview URL into a webkit view
    @IBAction func didTouchPlay(_ sender: UIButton) {
        NetMinder.shared.accessible { yes in
            
            if yes {
                let index = sender.tag
            
                DispatchQueue.main.async {
                    if let item = self.dataSource.item( at: index )  {
                        self.performSegue( withIdentifier: K.detailSegue, sender: item.preview )
                    }
                }
            }
        }
    }
    
}
