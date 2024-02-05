//
//  ViewController.swift
//  Weather
//
//  Created by white4ocolate on 01.02.2024.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var networkWeatherManager = NetworkWeatherManager()
    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyKilometer
        lm.requestWhenInUseAuthorization()
        return lm
    }()
    
    @IBAction func getWeatherByLocation(_ sender: UIButton) {
        locationManager.startUpdatingLocation()
        guard let location = locationManager.location?.coordinate else {return}
        self.networkWeatherManager.fetchCurrentWeather(forRequestType: .coordinate(latitude: location.latitude, longitude: location.longitude))
        locationManager.stopUpdatingLocation()
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        self.presentSearchAlertController(withTitle: "Enter City", message: nil, style: .alert) { [unowned self] city in
            self.networkWeatherManager.fetchCurrentWeather(forRequestType: .cityName(city: city))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        networkWeatherManager.onCompletion = { [weak self] currrentWeather in
            guard let self = self else {return}
            self.updateUI(with: currrentWeather)
        }
        self.locationManager.requestLocation()
        
    }
    
    func updateUI(with weather: CurrentWeather) {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = true
        }
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.temperatureString
            self.feelsLikeTemperatureLabel.text = weather.feelsLikeTemperatureString + "°C"
            self.backgroundImageView.image = UIImage(named: "\(weather.iconName)Background")
            self.weatherIconImageView.image = UIImage(named: weather.iconName)
        }
    }
    
}

//MARK: CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("update location")
        guard let location = locations.last else { return }
        var latitude = location.coordinate.latitude
        var longitude = location.coordinate.longitude
        
        networkWeatherManager.fetchCurrentWeather(forRequestType: .coordinate(latitude: latitude, longitude: longitude))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        if manager.authorizationStatus == .authorizedWhenInUse {
//            manager.startUpdatingLocation()
//            manager.stopUpdatingLocation()
//        }

        // Handle each case of location permissions
        switch manager.authorizationStatus {
            case .authorizedAlways: print("authorizedAlways")
            case .authorizedWhenInUse: 
            manager.startUpdatingLocation()
            manager.stopUpdatingLocation()
            case .denied: print("denied")
            case .notDetermined: print("notDetermined")
            case .restricted: print("restricted")
        @unknown default:
            print("Uknown Location Status")
        }
    }
}
