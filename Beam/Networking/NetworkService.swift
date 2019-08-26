//
//  NetworkingService.swift
//  Beam
//
//  Created by Daniel Espinosa on 7/20/19.
//  Copyright © 2019 Daniel Espinosa. All rights reserved.
//

import UIKit

class NetworkService: NSObject {
    static func fetch<t: Decodable>(url: URL, completion: @escaping(t?)->()){
        URLSession.shared.dataTask(with: url) { (data, resp, error) in
            guard let data = data, error == nil else {
                completion(nil)
                return }
            do {
                let decodedData = try JSONDecoder().decode(t.self, from: data)
                DispatchQueue.main.async {
                    completion(decodedData)
                }
            } catch {
                //print("ERROR: Not able to decode data")
                completion(nil)
            }
            }.resume()
    }
}
    
