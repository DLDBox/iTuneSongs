//
//  iTuneSongsTests.swift
//  iTuneSongsTests
//
//  Created by Dana Devoe on 5/18/20.
//  Copyright © 2020 Dana Devoe. All rights reserved.
//

import XCTest
@testable import iTuneSongs

class iTuneSongsTests: XCTestCase, XMLParserDelegate, XMLDelegate {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let exception = expectation(description: "Wait for test to complete")

        //TODO:
        let xml =
        """
        <items>\
            <item>\
                <author>Robi</author>\
                <description>My article about Olympics</description>\
                <tag name = "Olympics" count = "3"/>\
                <tag name = "Rio"/>\
                <id im:id="1234">Id  text datat</id>
                <im:name>ID name</im:name>
            </item>\
            <item>\
                <author>Joel</author>\
                <description>I can't wait Spa-Francorchamps!!</description>\
                <tag name = "Formula One"/>\
                <tag name = "Eau Rouge" count = "5"/>\
                <id im:id="4567">Id  text datat</id>
                <im:name>ID name</im:name>
            </item>\
        </items>
        """

        let parser = XMLPathParser( xmlString: xml,delegate: self )
        
        parser.addPath(path: "items.item.author", id: 1)
        parser.addPath(path: "items.item.description", id: 2)
        parser.addPath(path: "items.item.tag", id: 3)
        parser.addPath(path: "items.item.im:name", id: 4)
        parser.addPath(path: "items.item.id", id: 5)

        parser.parse()
        
        // exception.fulfill()

        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testAdditional() throws {
        
        let exception = expectation(description: "Wait for test to complete")

        //TODO:
        let xml =
        """
        <items>\
            <item>\
                <id im:id="1234">Id  text datat</id>
                <im:name>ID name</im:name>
            </item>\
            <item>\
                <id im:id="4567">Id  text datat</id>
                <im:name>ID name</im:name>
            </item>\
        </items>
        """

        let parser = XMLPathParser( xmlString: xml, delegate: self )
        
        parser.addPath(path: "items.item.im:name", id: 4)
        parser.addPath(path: "items.item.id", id: 5)

        parser.parse()
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testAttributeXML() throws {
        
        let exception = expectation(description: "Wait for test to complete")

        //TODO:
        let xml =
        """
        <items>\
            <item>\
                <id im:id="1234">Id  text datat</id>
                <im:name>ID name</im:name>
            </item>\
            <item>\
                <id attrib1="1111" attrib2="222222" attrib3="333333">Id  text datat</id>
                <tag name="Buddy" age="23" job="cook">ID name</tag>
                <tag name="Fred" age="44" job="teacher">ID name</tag>
            </item>\
        </items>
        """

        let parser = XMLPathParser( xmlString: xml, delegate: self )
        
        parser.addPath(path: "items.item.id@attrib1,attrib2", id: 1)
        parser.addPath(path: "items.item.tag@name,job", id: 2)

        parser.parse()
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testAppleXML() throws {
        
        let exception = expectation(description: "Wait for test to complete")

        //TODO:
        let xml =
        """
        <feed xmlns:im="http://itunes.apple.com/rss" xmlns="http://www.w3.org/2005/Atom" xml:lang="en">\
            <id>https://itunes.apple.com/us/rss/topsongs/limit=10/xml</id>
            <title>iTunes Store: Top Songs</title>
            <updated>2020-05-19T12:05:55-07:00</updated>
            <link rel="alternate" type="text/html" href="https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewTop?cc=us&amp;id=1&amp;popId=1"/>
            <link rel="self" href="https://itunes.apple.com/us/rss/topsongs/limit=10/xml"/>
            <icon>http://itunes.apple.com/favicon.ico</icon>
            <author>
                <name>iTunes Store</name>
                <uri>http://www.apple.com/itunes/</uri>
            </author>
            <rights>Copyright 2008 Apple Inc.</rights>

            <entry>
            <updated>2020-05-19T12:05:55-07:00</updated>
            <id im:id="1513779431">https://music.apple.com/us/album/long-way-home-the-voice-performance/1513779427?i=1513779431&amp;uo=2</id>
            <title>Long Way Home (The Voice Performance) - Todd Tilghman</title>
            <im:name>Long Way Home (The Voice Performance)</im:name>
            <link rel="alternate" type="text/html" href="https://music.apple.com/us/album/long-way-home-the-voice-performance/1513779427?i=1513779431&amp;uo=2"/>
            <im:contentType term="Music" label="Music">
                <im:contentType term="Track" label="Track"/></im:contentType>
            <category im:id="6" term="Country" scheme="https://music.apple.com/us/genre/music-country/id6?uo=2" label="Country"/>
            <link title="Preview" rel="enclosure" type="audio/x-m4a" href="https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview113/v4/d8/d9/fd/d8d9fd0b-afa1-85c5-64ca-014d8a4bb682/mzaf_6258254849742725717.plus.aac.p.m4a" im:assetType="preview">
                <im:duration>30000</im:duration>
            </link>
            <im:artist href="https://music.apple.com/us/artist/todd-tilghman/1481165305?uo=2">Todd Tilghman</im:artist>
            <im:price amount="1.29000" currency="USD">$1.29</im:price>
            <im:image height="55">https://is5-ssl.mzstatic.com/image/thumb/Music113/v4/e4/2e/f2/e42ef2bc-a172-db8c-21c3-f85c7ca038dc/20UMGIM40380.rgb.jpg/55x55bb.png</im:image>
            <im:image height="60">https://is2-ssl.mzstatic.com/image/thumb/Music113/v4/e4/2e/f2/e42ef2bc-a172-db8c-21c3-f85c7ca038dc/20UMGIM40380.rgb.jpg/60x60bb.png</im:image>
            <im:image height="170">https://is4-ssl.mzstatic.com/image/thumb/Music113/v4/e4/2e/f2/e42ef2bc-a172-db8c-21c3-f85c7ca038dc/20UMGIM40380.rgb.jpg/170x170bb.png</im:image>
            <rights>&#8471; 2020 Republic Records, a division of UMG Recordings, Inc.</rights>
            <im:releaseDate label="May 18, 2020">2020-05-18T00:00:00-07:00</im:releaseDate>
            <im:collection>
                <im:name>Long Way Home (The Voice Performance) - Single</im:name>
                <link rel="alternate" type="text/html" href="https://music.apple.com/us/album/long-way-home-the-voice-performance-single/1513779427?uo=2"/>
                <im:contentType term="Music" label="Music">
                    <im:contentType term="Album" label="Album"/></im:contentType>
            </im:collection>
        </entry>
        </feed>
        """

        let parser = XMLPathParser( xmlString: xml, delegate: self )
        
        parser.addPath(path: "feed.entry.im:artist", id: 4)
        parser.addPath(path: "feed.entry.im:name", id: 5)
        parser.addPath(path: "feed.id", id: 6)

        parser.parse()
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testServer() throws {
        let _ = expectation(description: "Wait for test to complete")
        
        let server = iTunesServer()
        
        server.topSongXML({ items in }, failure: { error in })
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testTunesDataSource() throws {
        let _ = expectation(description: "Wait for test to complete")
        
        let tunesDataSource = iTunesDataSource()
        
        tunesDataSource.songList(completion: { items in
            
        }, failure: {error in } )
        
        self.waitForExpectations(timeout: 10, handler: nil)

    }
    
    //
    //MARK: XMLPathParser section
    //
    func didStartElement( parser: XMLPathParser, element: String ){
        
    }
    
    func didEndElement( parser: XMLPathParser, element: String ){
        
    }

    func didEncounterPath( parser: XMLPathParser, path: String, id: Any, string: String) {
        print( "Found Path: \(path) = \(string)" )
    }

    func didEncounterPath( parser: XMLPathParser, path: String, id: Any, string: String, attributes: [String:String] ) {
        print( "Found Path: \(path) = \(attributes)" )
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
