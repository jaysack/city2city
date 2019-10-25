//
//  ViewModel.swift
//  City2City
//
//  Created by Jonathan Sack on 10/24/19.
//  Copyright © 2019 Jonathan Sack. All rights reserved.
//

import Foundation

protocol ViewModelDelegate {
    func updateData()
    func updateWeather()
}

class ViewModel {
    
    // MARK: - Variable(s)
    var delegate: ViewModelDelegate?
    var cities = [City]()
    
    var weather: Weather! {
        didSet {
            // Return on Main Thread
            DispatchQueue.main.async { [weak self] in
                self?.delegate?.updateWeather()
            }
        }
    }
    
    var filteredCities = [City]() {
        didSet {
            
            // Return on Main Thread
            DispatchQueue.main.async { [weak self] in
                self?.delegate?.updateData()
            }
        }
    }
    
    
    // MARK: - Fetch Cities
    func loadCities() {
        // Extract cities from json file
        FileService.shared.getCities { [weak self] (cities) in
            
            for city in cities {
                self?.cities.append(city)
            }
        }
    }
    
    
    // MARK: - Fetch Weather
    func getWeather(for city: City) {
        
        NetworkService.shared.getWeather(for: city) { [weak self] (json) in
            if let response = json {
                self?.weather = response
            }
        }
    }
    
    
    // MARK: - Filter Cities
    func filterCities(with text: String) {
       
        // Heavy task on background thread
        DispatchQueue.global().async { [weak self] in
            self?.filteredCities = (self?.cities.filter({
                $0.name.lowercased().contains(text.lowercased()) || $0.state.lowercased().contains(text.lowercased())
            }))!
        }
    }
    
}
