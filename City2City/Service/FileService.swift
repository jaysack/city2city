//
//  FileService.swift
//  City2City
//
//  Created by Jonathan Sack on 10/24/19.
//  Copyright © 2019 Jonathan Sack. All rights reserved.
//

import Foundation

final class FileService {
    
    // MARK: - Singleton Stack
    static let shared = FileService()
    private init() {}
    
    
    // MARK: - Function
    func getCities(completion: @escaping ([City]) -> Void) {

        DispatchQueue.global(qos: .userInitiated).async {
            
            // Guard path
            guard let path = Bundle.main.path(forResource: "cities", ofType: "json") else {
                completion([])
                return
            }
            
            // Setup URL
            let url = URL(fileURLWithPath: path)
            
            // Serialize json
            do {
                let data = try Data(contentsOf: url)
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as! [[String:Any]]
                
                var cities = [City]()
                
                for dict in jsonResponse {
                    if let city = City(dict: dict) {
                        cities.append(city)
                    }
                }
                
                completion(cities)
                
            } catch {
                print("JSError: Unable to serialize JSON: ~> \(error.localizedDescription)")
                completion([])
                return
            }
            
        }
    }
}
