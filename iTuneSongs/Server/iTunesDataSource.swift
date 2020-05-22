//
//  iTunesDataSource.swift
//  iTuneSongs
//
//  Created by Dana Devoe on 5/21/20.
//  Copyright © 2020 Dana Devoe. All rights reserved.
//

import Foundation

class iTunesDataSource: XMLDelegate {
    
    //
    //MARK: - private member section
    //
    private var tuneServer = iTunesServer()
    private var items = [iTunesItem]()
    private var currentItem: iTunesItem? = nil
    
    func songList( completion: @escaping ClosureWithiTunes, failure: @escaping ClosureWithError ) {
     
        tuneServer.topSongXML( { xmlString in
            let xmlPathParser = XMLPathParser(xmlString: xmlString, delegate: self )
            
            xmlPathParser.addPaths(paths: EndPoints.XMLPaths)
            xmlPathParser.parse()
            
            completion( self.items )
        }, failure: failure )
    }
    
    //
    //MARk: - XMLDelegate Section
    //
    
    func didEncounterPath(parser: XMLPathParser, path: String, id: Any, string: String) {
        
        if var current = self.currentItem {
            switch id as! EndPoints.XMLItem {
            case .entryName:
                current.title = string
            case .entryArtist:
                current.artist = string
            default:break
            }
        }
    }
    
    func didEncounterPath(parser: XMLPathParser, path: String, id: Any, string: String, attributes: [String : String]) {
        
        if let current = self.currentItem {
            switch id as! EndPoints.XMLItem {
            case .entryPreview:
                current.preview = attributes[EndPoints.dicthref]
            case .entryArtist:
                current.artist = attributes[EndPoints.dicthref]
            case .entryImage:
                current.image = string
            default:break
            }
        }
    }
    
    func didStartElement( parser: XMLPathParser, element: String ) {
        if element == EndPoints.dataElement {
            self.currentItem = iTunesItem()
        }
    }
    
    func didEndElement( parser: XMLPathParser, element: String ) {
        if element == EndPoints.dataElement, let currentItem = self.currentItem {
            self.items.append(currentItem)
            self.currentItem = nil
        }
    }
    
    func parse(_ parser: XMLPathParser, _ error: Error) {
        print( "\(#function)" )
    }
    
    func validation(_ parser: XMLPathParser, _ error: Error) {
        print( "\(#function)" )
    }
    
}
