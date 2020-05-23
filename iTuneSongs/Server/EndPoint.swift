//
//  EndPoint.swift
//  iTuneSongs
//
//  Created by Dana Devoe on 5/20/20.
//  Copyright © 2020 Dana Devoe. All rights reserved.
//

import Foundation

struct EndPoints {
    
    enum XMLItem: Int {
        case mainTitle
        //case entryCoverArt
        case entryName
        case entryPreview
        case entryArtist
        case entryImage
    }
    
    static var topSong  = "https://itunes.apple.com/us/rss/topsongs/limit=100/xml"
    static var dataElement = "entry"
    static var dicthref = "href"
    static var XMLPaths = [ "feed.title" : XMLItem.mainTitle
                        //, "feed.entry.link@type,href" : XMLItem.entryCoverArt
                          , "feed.entry.title" : XMLItem.entryName
                          , "feed.entry.link@title,href" : XMLItem.entryPreview
                          , "feed.entry.im:artist" : XMLItem.entryArtist
                          , "feed.entry.im:image" : XMLItem.entryImage
    ]
    
}
