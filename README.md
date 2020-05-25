#iTuneSongs
List popular iTunes songs
Written by Dana Devoe

##A coding challenge

This is a simple application used to demonstrate downloading a list XML file containing a list of of popular songs on iTunes parsing the XML into items of iTune elements and displaying the covert art for each item along with Song title and artist in a tableview.

For this challenge I followed the Object Oriented coding concepts.  I used Data encapsulation and aggregation.  I used TDD but I did not completely construct the test to proved automated feedback but mostly to help debug the code as I was creating it.  The XMLParsing is where I spent most of my time.  I flushed it out perhaps a bit more then I should have and I could have added the ability to convert the XML paths into JSON and then use decoder to make the data loading a bit more straightforward.  However, I think that would have taken a bit more time.
## Server Access
And EndPoint structure contains the server url strings. Along with XML parsing paths.  The object `iTunesServer` is designed to access the url at EndPoint.topSongs.  It download the XML and delivers it in a closure. 

####`func topSongXML( _ completion: @escaping ClosureWithString, failure: @escaping ClosureWithError )`

 The object also handle the loading of the album art in the call:

####`func loadImageFor( item: iTunesItem, completion: @escaping (_ image: UIImage ) -> () )`

XML Parsing

`iTunesDataSource` uses `iTuneServer` to access and retrieve the iTune XML.  While `iTunesDataSource` create a generic data source which can be aggregated into any number of UI datasources such as UICollectionDataSource, but for this exercise aggregate it into a UITableViewDataSource.

`func songList( completion: @escaping ClosureWithiTunes, failure: @escaping ClosureWithError )`

The above call returns a 

####iTunesTableViewDataSource

This object implements UITableViewDataSource protocol, while aggregating the iTunesDataSource.

###XML Path Parsing
This application will demonstrate a XML object XMLPathParse which is designed to make parsing complex XML files much simpler.  A path is provided which represent the XML element to a string, or attribute of interest with in the XML.  The XMLPathParse is giving the paths with an accompanying ID.  As the XMLPathParse executes, it calls out to the XMLDelegate when it finds Path matches.  

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

For XML as complex as used by iTunes, there might be duplicate tags with attributes.  I added code to allow a developer to specify not only the path to a particular element but to uniquely identify an element with attribute from other with the same name but different attribute elements.

        let xml =
        """
        <items>\
            <item>\
                <id im:id="1234">Id  text datat</id>
                <im:name>ID name</im:name>
            </item>\
            <item>\
                <id attrib1="1111" attrib2="222222" attrib3="333333">Id  text datat</id>
                <id attrib4="444" attrib5="55555" attrib6="66666">Id  text datat</id>
                <tag name="Buddy" age="23" job="cook">ID name</tag>
                <tag name="Fred" age="44" job="teacher">ID name</tag>
            </item>\
        </items>
        """

        let parser = XMLPathParser( xmlString: xml, delegate: self )
        
        parser.addPath(path: "items.item.id@attrib1,attrib2", id: 1)
        parser.addPath(path: "items.item.tag@name,job", id: 2)

        parser.parse()

## Network Access and Monitoring 
To monitor network access I used NWPathMonitor.  When ever net access changes, the accessibility is stored.  If the access is not possible, an Alert is displayed.  By wrapping the network code in a closure, whenever connectivity is restore, the desired call is made. 

####`func access( _ completion: @escaping (yes)->() )`

Example usage:

        NetMinder.shared.accessible( { yes in
            
            self.dataSource.songList(completion: { items in
                self.items = items
                completion(true)
            }, failure: {error in
                completion(false)
            })
            
        })
If there is not connectivity the closure is not called, until a connection is made.

