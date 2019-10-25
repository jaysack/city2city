//
//  HomeVC.swift
//  City2City
//
//  Created by Jonathan Sack on 10/24/19.
//  Copyright © 2019 Jonathan Sack. All rights reserved.
//

import UIKit
import MapKit

class HomeVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var searchBarTableView: UITableView!
    @IBOutlet weak var searchBarTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var weatherMainImageView: UIImageView!
    @IBOutlet weak var weatherTemperatureView: UIView!
    @IBOutlet weak var weatherHumidityView: UIView!
    @IBOutlet weak var weatherWindSpeedView: UIView!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windspeedLabel: UILabel!
    
    
    // MARK: - Variables
    var vm = ViewModel()
    
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadViewModel()
        registerCustomCell()
    }
    
    
    // MARK: - Function(s)
    fileprivate func loadViewModel() {
        vm.delegate = self
        vm.loadCities()
    }
    
    fileprivate func registerCustomCell() {
        let cityCell = UINib(nibName: CityCell.identifier, bundle: nil)
        searchBarTableView.register(cityCell, forCellReuseIdentifier: CityCell.identifier)
    }
    
    fileprivate func setupUI() {
        // Search bar
        FUNCTION.ADD_SHADOW(for: searchBar)
        FUNCTION.ROUND_CORNERS(for: searchBar)
        
        // Table View
        FUNCTION.ROUND_CORNERS(for: searchBarTableView)
        searchBarTableViewHeight.constant = 45
        
    }
    
    fileprivate func zoomMap(to city: City) {
        
        // Zoom to city coordinates
        let center = CLLocationCoordinate2D(latitude: city.coordinates.latitude, longitude: city.coordinates.longitude)
        let radius: CLLocationDistance = 12000
        let location = MKCoordinateRegion(center: center, latitudinalMeters: radius, longitudinalMeters: radius)
        
        // Add annotation
        let annotation = MKPointAnnotation()
        annotation.title = city.name
        annotation.coordinate = center
        
        // Display Map
        mapView.setRegion(location, animated: true)
        mapView.addAnnotation(annotation)
    }
    
    fileprivate func resetSearchBar() {
        searchBar.text = ""
        vm.filteredCities = [City]()
        searchBarTableView.reloadData()
    }
    
    
    // MARK: - IBActions
    @IBAction func searchTextWasEdited(_ sender: UITextField) {
        
        // Cancel if text is empty
        guard let text = sender.text else { return }
        
        // Append vm's fileteredCities array with correct cities
        vm.filterCities(with: text)
    }
    
}


// MARK: - View Model Delegate
extension HomeVC: ViewModelDelegate {
    
    func updateData() {
        searchBarTableView.reloadData()
        searchBarTableViewHeight.constant = 45 + (90 * CGFloat(integerLiteral: vm.filteredCities.count))
        
        // Animate changes
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func updateWeather() {
        #warning("TO-DO: Update weather here !")
        
        // Description
        switch vm.weather.main {
        case "Rain":
            weatherMainImageView.image = IMAGE.RAIN
        default:
            weatherMainImageView.image = IMAGE.SUNNY
        }
        
        
    }
    
}


// MARK: - Table View Delegate
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.filteredCities.count > 8 ? 8 : vm.filteredCities.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            return UITableViewCell()
        }
        
        // Config. cell
        let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.identifier, for: indexPath) as! CityCell
        cell.city = vm.filteredCities[indexPath.row - 1]
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 45 : 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Get city
        let city = vm.filteredCities[indexPath.row - 1]
        
        // Zoom to city
        zoomMap(to: city)
        
        // Get weather
        vm.getWeather(for: city)
        
        // Display weather info
        
        // Reset Search Bar
        resetSearchBar()
    }
    
}
