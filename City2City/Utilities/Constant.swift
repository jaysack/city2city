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
    
    struct WEATHER {
        static let BASE = "https://api.openweathermap.org/data/2.5/weather"
        static let DEFAULT = "\(ENDPOINT.WEATHER.BASE)?APPID=\(API.KEY.OPEN_WEATHER)&units=imperial"
    }
}

struct COLOR {
    static let PRIMARY = UIColor.black
    static let SUPPORTING = UIColor.darkGray
    static let OTHER = UIColor.lightGray
    static let SHADOW = UIColor.black.cgColor
    
    struct GRADIENT {
        static let PRIMARY = COLOR.PRIMARY.withAlphaComponent(0.7)
        static let TRANSPARENT = COLOR.PRIMARY.withAlphaComponent(0.15)
    }
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
    static let SUNNY = #imageLiteral(resourceName: "noun_sun_15579")
    static let CLOUD = #imageLiteral(resourceName: "noun_Cloud_2908402")
    static let PARTLY_SUNNY = #imageLiteral(resourceName: "noun_season_2916739")
    static let RAIN = #imageLiteral(resourceName: "noun_Rain_2908413")
    static let LIGHTNING = #imageLiteral(resourceName: "noun_thunder_2908420")
    static let SNOW = #imageLiteral(resourceName: "noun_Snow_2908412")
    static let WINDY = #imageLiteral(resourceName: "noun_Wind_2908419")
    static let WIND = #imageLiteral(resourceName: "noun_Wind_2864369")
    static let ITEMS = #imageLiteral(resourceName: "noun_menu_2521956")
    static let CANCEL = #imageLiteral(resourceName: "noun_wrong_1890791")
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
