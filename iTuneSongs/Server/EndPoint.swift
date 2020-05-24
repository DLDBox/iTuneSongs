//
//  EndPoint.swift
//  iTuneSongs
//
//  Created by Dana Devoe on 5/20/20.
//  Copyright © 2020 Dana Devoe. All rights reserved.
//

import Foundation

/* Literal which are used for the URL endpoints and
 the XML paths which are to be retrieved from the server.
 */
struct EndPoints {
    
    enum XMLItem: Int {
        case mainTitle
        case entryArt
        case entryName
        case entryPreview
        case entryArtist
        case entryImage
    }
    
    static var topSong  = "https://itunes.apple.com/us/rss/topsongs/limit=100/xml"
    static var dataElement = "entry"
    static var dicthref = "href"
    static var imageKey = "height"
    static var imageValue = "55"
    static var XMLPaths = [ "feed.title" : XMLItem.mainTitle
                          , "feed.entry.id" : XMLItem.entryArt
                          , "feed.entry.title" : XMLItem.entryName
                          , "feed.entry.link@title,im:assetType" : XMLItem.entryPreview
                          , "feed.entry.im:artist" : XMLItem.entryArtist
                          , "feed.entry.im:image" : XMLItem.entryImage
    ]
    
}
