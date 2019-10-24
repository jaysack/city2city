//
//  Weather.swift
//  City2City
//
//  Created by Jonathan Sack on 10/24/19.
//  Copyright © 2019 Jonathan Sack. All rights reserved.
//

import Foundation

class Weather {
    
    let main: String
    let description: String
    let temp: Double
    let humidity: Int
    let windSpeed: Double?
    
    
    init?(dict: [String:Any]) {
        
        guard let weatherArray = dict["weather"] as? [[String:Any]],
            let mainDict = dict["main"] as? [String:Any],
            let windDict = dict["wind"] as? [String:Double],
            let weatherDict = weatherArray.first else { return nil }
        
        self.main = weatherDict["main"] as! String
        self.description = weatherDict["description"] as! String
        self.temp = mainDict["temp"] as! Double
        self.humidity = mainDict["humidity"] as! Int
        self.windSpeed = windDict["speed"]
    }
    
}
