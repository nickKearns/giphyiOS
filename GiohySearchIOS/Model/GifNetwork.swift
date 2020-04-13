//
//  GifNetwork.swift
//  GiohySearchIOS
//
//  Created by Nicholas Kearns on 4/12/20.
//  Copyright © 2020 Nicholas Kearns. All rights reserved.
//

import Foundation


class GifNetwork {
    let apiKey = "J9SpETRN4RmRlVbUYjpI3DmbUJE7JY88"
    
    
    func fetchGifs(searchTerm: String, completion: @escaping (_ response: GifArray?) -> Void) {
        let url = urlBuilder(searchTerm: searchTerm)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error {
                print("Error fetching from Giphy: ", err.localizedDescription)
            }
            do {
                DispatchQueue.main.async {
                    let object = try! JSONDecoder().decode(GifArray.self, from: data!)
                    completion(object)
                }
            }
            
        }.resume()
    }
    
    func urlBuilder(searchTerm: String) -> URL {
        let apikey = apiKey
        var components = URLComponents()
           components.scheme = "https"
           components.host = "api.giphy.com"
           components.path = "/v1/gifs/search"
           components.queryItems = [
               URLQueryItem(name: "api_key", value: apikey),
               URLQueryItem(name: "q", value: searchTerm),
               URLQueryItem(name: "limit", value: "5") // Edit limit to display more gifs
           ]
        return components.url!
    }
    
}
