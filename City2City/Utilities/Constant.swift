//
//  Constant.swift
//  City2City
//
//  Created by Jonathan Sack on 10/24/19.
//  Copyright © 2019 Jonathan Sack. All rights reserved.
//

import UIKit

// MARK: - Variable(s)
struct ENDPOINT {
    
    static let BASE = "https://api.openweathermap.org/data/2.5/weather"
    static let WEATHER = "\(ENDPOINT.BASE)?APPID=\(API.KEY)&units=imperial"
}

struct COLOR {
    static let PRIMARY = UIColor.black
    static let SUPPORTING = UIColor.darkGray
    static let OTHER = UIColor.lightGray
    static let SHADOW = UIColor.black.cgColor
}

struct CORNER {
    static let RADIUS: CGFloat = 5
}

struct SHADOW {
    static let OFFSET = CGSize(width: 0, height: 1.0)
    static let OPACITY: Float = 0.3
    static let RADIUS: CGFloat = 4
}

struct IMAGE {
    static let SUNNY = #imageLiteral(resourceName: "noun_sun_673878")
    static let PARTLY_SUNNY = #imageLiteral(resourceName: "noun_Partly Sunny_673913")
    static let RAIN = #imageLiteral(resourceName: "noun_rain cloud_673900")
    static let LIGHTNING = #imageLiteral(resourceName: "noun_storm cloud_673880")
}


// MARK: - Function(s)
struct FUNCTION {
    
    static func ADD_SHADOW<T: UIView>(for element: T) {
        element.layer.shadowOpacity = SHADOW.OPACITY
        element.layer.shadowRadius = SHADOW.RADIUS
        element.layer.shadowOffset = SHADOW.OFFSET
        element.layer.shadowColor = COLOR.SHADOW
    }

    static func ROUND_CORNERS<T: UIView>(for element: T) {
        element.layer.cornerRadius = CORNER.RADIUS
    }
}
