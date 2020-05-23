//
//  iTunesDataSource.swift
//  iTuneSongs
//
//  Created by Dana Devoe on 5/21/20.
//  Copyright © 2020 Dana Devoe. All rights reserved.
//

import Foundation

/* This object is designed to encapsulate the iTuneServer process
 It handle download and the parsing of the iTune XML file

 */
class iTunesDataSource: XMLDelegate {
    
    //
    //MARK: - private member section
    //
    private var tuneServer = iTunesServer()     // The object download the XML
    private var items = [iTunesItem]()          // the list of parsed iTune items
    private var currentItem: iTunesItem? = nil  // The next iTune item to be inserted into the items array
    
    func songList( completion: @escaping ClosureWithiTunes, failure: @escaping ClosureWithError ) {
     
        // Load XML string for parsing
        tuneServer.topSongXML( { xmlString in
            let xmlPathParser = XMLPathParser(xmlString: xmlString, delegate: self) // setup the XML parser
            
            xmlPathParser.addPaths(paths: EndPoints.XMLPaths)   // Add the parsing criteria (see the XMLPathParser object)
            xmlPathParser.parse()       // parse the XML using the supplied paths
            
            completion( self.items )
        }, failure: failure )
    }
    
    func loadiTunesItemURLs( item: iTunesItem ) -> iTunesItem {
        return tuneServer.loadItem(item: item)
    }
    
    //
    //MARk: - XMLDelegate Section
    //
    
    func didEncounterPath(parser: XMLPathParser, path: String, id: Any, string: String) {
        
        if let current = self.currentItem {
            
            switch id as! EndPoints.XMLItem {
                case .entryName: current.title = string
                case .entryArtist: current.artist = string
                default:break
            }
        }
    }
    
    func didEncounterPath(parser: XMLPathParser, path: String, id: Any, string: String, attributes: [String : String]) {
        
        if let current = self.currentItem {
            switch id as! EndPoints.XMLItem {
                case .entryPreview: current.preview = attributes[EndPoints.dicthref]
                case .entryArtist: current.artist = attributes[EndPoints.dicthref]
                case .entryImage: current.image = string
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
