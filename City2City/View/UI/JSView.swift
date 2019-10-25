//
//  JSView.swift
//  City2City
//
//  Created by Jonathan Sack on 10/25/19.
//  Copyright © 2019 Jonathan Sack. All rights reserved.
//

import UIKit

class JSView: UIView {
 
    override func awakeFromNib() {
        super.awakeFromNib()
        
        FUNCTION.ADD_SHADOW(for: self)
        FUNCTION.ROUND_CORNERS(for: self)
        alpha = 0.95
    }
}
