//
//  Model.swift
//  iTuneSongs
//
//  Created by Dana Devoe on 5/20/20.
//  Copyright © 2020 Dana Devoe. All rights reserved.
//

import Foundation
import UIKit

class iTunesItem {
    
    var title: String? = nil
    var artist: String? = nil
    var art: String? = nil
    var image: String? = nil
    var preview: String? = nil
}

class iTunes {
    
    let title: String?
    let artist: String?
    let art: URL?
    let image: UIImage?
    let preview: URL?
    
    init( title: String?, artist: String?, art: URL?, image: UIImage?, preview: URL?) {
        self.title = title
        self.artist = artist
        self.art = art
        self.image = image
        self.preview = preview
    }
}
