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
    
    //
    //MARK: - private section
    //
    var item: iTunesItem? = nil
    
    func set( item: iTunesItem ) {
        self.item = item
        
        self.textLabel?.text = item.title
    }
    
    
}
