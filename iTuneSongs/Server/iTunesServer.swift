//
//  iTunesServer.swift
//  iTuneSongs
//
//  Created by Dana Devoe on 5/21/20.
//  Copyright © 2020 Dana Devoe. All rights reserved.
//

import Foundation
import UIKit

class iTunesServer {
    
    //
    //MARK: - Private members
    //
    let session = URLSession(configuration: .default)
    var task: URLSessionDataTask?
    let imageCache = NSCache<NSString, UIImage>()
    
    func topSongXML( _ completion: @escaping ClosureWithString, failure: @escaping ClosureWithError ) {
        
        var urlRequest = URLRequest(url: URL(string: EndPoints.topSong)! )
        
        urlRequest.httpMethod = "GET"
        self.task = self.session.dataTask(with: urlRequest) { [weak self] data, response, error in
            
          defer {
            self?.task = nil
          }
          
          if let _ = error {
            failure( .unknown )
          } else if let data = data,let response = response as? HTTPURLResponse, response.statusCode == 200 {
            if let xmlString = String(data: data, encoding: .utf8) {
                completion(xmlString)
            } else {
                failure( .noData )
            }
          } else {
            failure( .noData )
          }
        }
        
        self.task?.resume()
    }
    
    func loadImageFor( item: iTunesItem, completion: @escaping (_ image: UIImage ) -> () ) {
        
        if let imageURL = item.image,let cachedImage = imageCache.object(forKey: NSString(string: imageURL)) {
            completion( cachedImage )
        } else if let imageURL = item.image, let url = URL(string: imageURL ) {
            
            self.task = self.session.dataTask(with: url, completionHandler: { (data, response, error) in
                
                defer {
                  self.task = nil
                }
                
                DispatchQueue.main.async {
                    if error == nil {
                        if let data = data {
                            if let image = UIImage(data: data) {
                                self.imageCache.setObject(image, forKey: NSString(string: imageURL))
                                completion( image )
                            }
                        }
                    } else {
                        completion( UIImage() )//TODO: replace with real image
                    }
                }
            })
            
            self.task?.resume()
        }
    }

    //
    //MARK: - private methods section
    //
    
}
