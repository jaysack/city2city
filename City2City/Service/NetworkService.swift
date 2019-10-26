//
//  NetworkService.swift
//  City2City
//
//  Created by Jonathan Sack on 10/24/19.
//  Copyright © 2019 Jonathan Sack. All rights reserved.
//

import Foundation

final class NetworkService {
    
    // MARK: - Singleton Stack
    static let shared = NetworkService()
    private init() {}
    
    
    // MARK: - Fetch Weather
    func getWeather(for city: City, completion: @escaping (Weather?) -> Void) {
        
        // Set URL
        guard let url = URL(string: "\(ENDPOINT.WEATHER.DEFAULT)&lat=\(city.coordinates.latitude)&lon=\(city.coordinates.longitude)") else {
            print("JSError: Endpoint not valid")
            return
        }
        
        // URLSession
        URLSession.shared.dataTask(with: url) { (dat, _, err) in
            
            // Error handling
            if let error = err {
                print("JSError: Unable to fetch weather ~> \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            // Decode JSON
            if let data = dat {
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                    let weather = Weather(dict: jsonResponse)
                    completion(weather)
                    
                } catch {
                    print("JSError: Unable to serialize json object ~> \(error.localizedDescription)")
                    completion(nil)
                    return
                }
            }
            
        }.resume()
    }
    
}
