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

    //
    //MARK: - public section
    //
    
    func loadSongs( completion: @escaping ClosureWithBool ) {
        
        NetMinder.shared.accessible( { yes in
            
            self.dataSource.songList(completion: { items in
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
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let iTuneCell = tableView.dequeueReusableCell(withIdentifier: K.cellName) as? iTunesTableCell
        let iTuneItem = self.dataSource.item(at: indexPath.row)!
        
        iTuneCell?.set( item: iTuneItem, index: indexPath.row )
        iTuneCell?.accessoryType = .disclosureIndicator
        
        self.dataSource.loadImageFor(item: iTuneItem, completion: { image in
            iTuneCell?.albumIcon.image = image
        })
                
        return iTuneCell!
    }
    
    
}


