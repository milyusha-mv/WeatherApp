//
//  LaunchViewController.swift
//  WeatherApp
//
//  Created by Михаил Милюша on 12.12.2021.
//

import Foundation
import UIKit
import CoreLocation

protocol LaunchViewOutputProtocol: AnyObject {
    func launchScreenStart()
    func saveLocation(latitude: Double, longitude: Double)
}

protocol LaunchViewInputProtocol: AnyObject {
    func getLocation()
    func showErrorAlert(title: String, message: String)
}

class LaunchViewController: UIViewController, LaunchViewInputProtocol {
    let locationManager = CLLocationManager()
    var presenter: LaunchViewOutputProtocol!
    private let configurator: LaunchConfiguratorProtocol = LaunchConfigurator()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configurate(with: self)
        getLocation()
        activityIndicator.startAnimating()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let weatherVC = segue.destination as! WeatherViewController
        let configurator: ConfiguratorProtocol = Configurator()
        configurator.configurate(with: weatherVC)
    }
    
    func showErrorAlert(title: String, message: String) {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = true
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Repeat", style: .default, handler: { _ in
                self.activityIndicator.isHidden = false
                self.viewDidLoad()
            }))
            self.present(alert, animated: true)
        }
    }
}

extension LaunchViewController: CLLocationManagerDelegate {
    func getLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else {
            showErrorAlert(title: "Fail", message: "Can't get geolocation")
            return
        }
        let latitude = Double(locValue.latitude)
        let longitude = Double(locValue.longitude)
        presenter.saveLocation(latitude: latitude, longitude: longitude)
        presenter.launchScreenStart()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
