//
//  CityCell.swift
//  City2City
//
//  Created by Jonathan Sack on 10/24/19.
//  Copyright © 2019 Jonathan Sack. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var tintView: UIView!
    
    
    // MARK: - Variables
    static let identifier = "CityCell"
    
    var city: City! {
        didSet {
            cityNameLabel.text = "\(city.name), \(city.state)"
            populationLabel.text = "Population: \(city.population.addCommas ?? "N/A")"
        }
    }

    
    // MARK: - Awake From Nib
    override func awakeFromNib() {
        super.awakeFromNib()
        
        FUNCTION.ROUND_CORNERS(for: tintView)
    }
    
}
