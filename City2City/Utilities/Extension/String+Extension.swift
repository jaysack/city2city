//
//  String+Extension.swift
//  City2City
//
//  Created by Jonathan Sack on 10/24/19.
//  Copyright © 2019 Jonathan Sack. All rights reserved.
//

import Foundation

extension String {
    
    var addCommas: String? {
        
        guard let number = Int(self) else { return nil }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: number as NSNumber)
    }
    
}
