//
//  iTunesTableCell.swift
//  iTuneSongs
//
//  Created by Dana Devoe on 5/22/20.
//  Copyright © 2020 Dana Devoe. All rights reserved.
//

import Foundation
import UIKit

class iTunesTableCell: UITableViewCell {
    @IBOutlet weak var albumIcon: UIImageView!
    @IBOutlet weak var iTunesTitle: UILabel!
    @IBOutlet weak var artist: UILabel!
    
    //
    //MARK: - private section
    //
    var item: iTunesItem? = nil
    
    func set( item: iTunesItem ) {
        self.item = item
        
        self.iTunesTitle.text = item.title
        self.artist.text = item.artist
        
    }
    
    @IBAction func didTouchPlay(_ sender: Any) {
    }
    
}
