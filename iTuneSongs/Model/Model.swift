//
//  Model.swift
//  iTuneSongs
//
//  Created by Dana Devoe on 5/20/20.
//  Copyright © 2020 Dana Devoe. All rights reserved.
//

import Foundation
import UIKit

/* This is the iTune data that will be display in the Table view
 */
class iTunesItem {
    
    var title: String? = nil // Album Title
    var artist: String? = nil // Artist name
    var art: String? = nil // The album info page url string
    var image: String? = nil // The album cover art url string
    var preview: String? = nil // The audio preview url string
}

