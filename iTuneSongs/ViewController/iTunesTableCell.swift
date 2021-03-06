//
//  iTunesTableCell.swift
//  iTuneSongs
//
//  Created by Dana Devoe on 5/22/20.
//  Copyright © 2020 Dana Devoe. All rights reserved.
//

import Foundation
import UIKit

/* This is the table view cell used to dispaly the iTunesItem
 
 NOTE: the play button is triggered in the iTunesListViewController code
 */

class iTunesTableCell: UITableViewCell {
    
    @IBOutlet weak var albumIcon: UIImageView!
    @IBOutlet weak var iTunesTitle: UILabel!
    @IBOutlet weak var artist: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    //
    //MARK: - public section
    //
    
    //Set the iTuneItem data for this Cell
    func set( item: iTunesItem, index: Int ) {
        
        self.iTunesTitle.text = item.title
        self.artist.text = item.artist
        
        playButton.tag = index
    }
    
}
