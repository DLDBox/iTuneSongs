//
//  iTunesTableViewDataSource.swift
//  iTuneSongs
//
//  Created by Dana Devoe on 5/21/20.
//  Copyright © 2020 Dana Devoe. All rights reserved.
//

import Foundation
import UIKit

class iTunesTableViewDataSource: NSObject, UITableViewDataSource {
    
    struct K {
        static var cellName = "iTuneIdentifier"
    }
    
    //
    //MARK: - private member section
    //
    private let dataSource = iTunesDataSource()
    private var items: [iTunesItem]? = nil

    //
    //MARK: - public section
    //
    
    func loadSongs( completion: @escaping ClosureWithBool ) {
        
        NetMinder.shared.accessible( { yes in
            
            self.dataSource.songList(completion: { items in
                self.items = items
                completion(true)
            }, failure: {error in
                completion(false)
            })
            
        })
        
    }
    
    func item( at: Int ) -> iTunesItem? {
        return self.dataSource.item(at:at)
    }
    
    //
    //MARK: - UITableViewDataSource section
    //
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let items = self.items {
            return items.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let iTuneCell = tableView.dequeueReusableCell(withIdentifier: K.cellName) as? iTunesTableCell
        
        iTuneCell?.set( item: self.items![indexPath.row] )
        iTuneCell?.accessoryType = .disclosureIndicator
        
        self.dataSource.loadImageFor(item: self.items![indexPath.row], completion: { image in
            iTuneCell?.albumIcon.image = image
        })
                
        return iTuneCell!
    }
    
    
}


