//
//  iTunesServer.swift
//  iTuneSongs
//
//  Created by Dana Devoe on 5/21/20.
//  Copyright © 2020 Dana Devoe. All rights reserved.
//

import Foundation


class iTunesServer {
    
    //
    //MARK: - Private members
    //
    let session = URLSession(configuration: .default)
    var task: URLSessionDataTask?

    
    func topSongXML( _ completion: @escaping ClosureWithString, failure: @escaping ClosureWithError ) {
        
        var urlRequest = URLRequest(url: URL(string: EndPoints.topSong)! )
        
        urlRequest.httpMethod = "GET"
        self.task = self.session.dataTask(with: urlRequest) { [weak self] data, response, error in
            
          defer {
            self?.task = nil
          }
          
          if let error = error {
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
    
}
