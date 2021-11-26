//
//  ViewController.swift
//  WeatherApp
//
//  Created by Михаил Милюша on 21.11.2021.
//

import UIKit

protocol WeatherViewInputProtocol: AnyObject {
}

protocol WeatherViewOutputProtocol: AnyObject {
    init(view: WeatherViewInputProtocol)
    func getPredictionWeather()
}

class WeatherViewController: UIViewController {
    var presenter: WeatherViewOutputProtocol!
    private let configurator: ConfiguratorProtocol = Configurator()
    
    @IBOutlet weak var todayLabel: UILabel!
    
// Outlets in collectionView
    @IBOutlet weak var dayTimeLable: UILabel!
    @IBOutlet weak var predictionWeatherLabel: UILabel!
    @IBOutlet weak var feltWeahterLabel: UILabel!
    @IBOutlet weak var nowLabel: UILabel!
    @IBOutlet weak var imageCollectionView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
// Outlets in tableView
    @IBOutlet weak var titleTableLable: UILabel!
    @IBOutlet weak var valueTableLable: UILabel!
    @IBOutlet weak var imageTableView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configurate(with: self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension WeatherViewController: WeatherViewInputProtocol {

}

extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    }
    
}

