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
    // UI Elements
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var searchBarTableView: UITableView!
    @IBOutlet weak var searchBarTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var infoItemsButton: UIButton!
    @IBOutlet weak var infoItemsViewBg: JSView!
    
    // Constraint
    @IBOutlet weak var weatherConditionTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var temperatureTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var humidityTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var windSpeedTrailingConstraint: NSLayoutConstraint!
    
    // Labels
    @IBOutlet weak var weatherConditionImage: UIImageView!
    @IBOutlet weak var weatherConditionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    // MARK: - Variables
    var vm = ViewModel()
    var areWeatherTabOpen: Bool! {
        didSet {
        
            toggleMenuItems()
            setMenuButton()
        }
    }
    
    
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
        
        // Weather tabs
        areWeatherTabOpen = false
        infoItemsViewBg.isHidden = true
        
    }
    
    fileprivate func zoomMap(to city: City) {
        
        // Zoom to city coordinates
        let center = CLLocationCoordinate2D(latitude: city.coordinates.latitude, longitude: city.coordinates.longitude)
        let radius: CLLocationDistance = 7000
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
        searchBar.resignFirstResponder()
    }
    
    fileprivate func setMenuButton() {
        // Display button
        infoItemsViewBg.isHidden = false
        
        // Pick right image
        let image = areWeatherTabOpen ? IMAGE.CANCEL : IMAGE.ITEMS
        infoItemsButton.setImage(image, for: .normal)
        
        // Animate UI changes
        UIView.animate(withDuration: 0.6) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
    fileprivate func toggleMenuItems() {
        
        setConstraint(constraint: weatherConditionTrailingConstraint, FadeInDuration: 0.35, fadeOutDuration: 0.2)
        setConstraint(constraint: temperatureTrailingConstraint, FadeInDuration: 0.3, fadeOutDuration: 0.25)
        setConstraint(constraint: humidityTrailingConstraint, FadeInDuration: 0.25, fadeOutDuration: 0.3)
        setConstraint(constraint: windSpeedTrailingConstraint, FadeInDuration: 0.2, fadeOutDuration: 0.35)
    }
    
    fileprivate func setConstraint(constraint: NSLayoutConstraint, FadeInDuration: Double, fadeOutDuration: Double) {
        
        // Set damping ratio
        let dampingRatio: CGFloat = 0.8
        
        // Change constraint
        constraint.constant = areWeatherTabOpen ? 20 : -200
        
        // Animate UI changes
        UIView.animate(withDuration: areWeatherTabOpen ? FadeInDuration : fadeOutDuration, delay: 0, usingSpringWithDamping: dampingRatio, initialSpringVelocity: 0, options: .curveEaseInOut, animations: { [weak self] in
            self?.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    
    // MARK: - IBActions
    @IBAction func searchTextWasEdited(_ sender: UITextField) {
        
        // Unwrap text optional
        guard let text = sender.text else { return }
        
        // Append vm's fileteredCities array with correct cities
        vm.filterCities(with: text)
    }
    
    @IBAction func weatherInfoButtonClicked(_ sender: UIButton) {
        areWeatherTabOpen = !areWeatherTabOpen
    }
    
    @IBAction func searchBarInFocus(_ sender: UITextField) {
        
        // Open iOS keyboard
        searchBar.becomeFirstResponder()
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
        
        // Description Image
        switch vm.weather.main {
        case "Rain":
            weatherConditionImage.image = IMAGE.RAIN
        case "Clouds":
            weatherConditionImage.image = IMAGE.CLOUD
        case "Haze", "Smoke":
            weatherConditionImage.image = IMAGE.WIND
        default:
            weatherConditionImage.image = IMAGE.SUNNY
        }
        
        // Other Labels
        weatherConditionLabel.text = vm.weather.main
        temperatureLabel.text = "\(String(format: "%.1f", vm.weather.temp))°F"
        humidityLabel.text = "\(vm.weather.humidity)%"
        windSpeedLabel.text = "\(String(format: "%.1f", vm.weather.windSpeed!)) mph"
    }
    
}


// MARK: - Table View Delegate
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Only display 8 suggestions or less
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
        areWeatherTabOpen = true
        
        // Reset Search Bar
        resetSearchBar()
    }
    
}
