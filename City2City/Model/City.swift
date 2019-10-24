//
//  City.swift
//  City2City
//
//  Created by Jonathan Sack on 10/24/19.
//  Copyright © 2019 Jonathan Sack. All rights reserved.
//

import Foundation
import CoreLocation

class City {
    
    let name: String
    let state: String
    let population: String
    let coordinates: CLLocationCoordinate2D
    
    init?(dict: [String:Any]) {
        guard let name = dict["city"] as? String,
            let state = dict["state"] as? String,
            let long = dict["longitude"] as? Double,
            let lat = dict["latitude"] as? Double,
            let pop = dict["population"] as? String else { return nil }
        
        self.name = name
        self.state = state
        self.population = pop
        self.coordinates = CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    
}
