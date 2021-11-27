//
//  ViewController.swift
//  WeatherApp
//
//  Created by Михаил Милюша on 21.11.2021.
//

import UIKit

protocol WeatherViewInputProtocol: AnyObject {
    func showTodayDay(todayDay: String)
}

protocol WeatherViewOutputProtocol: AnyObject {
    init(view: WeatherViewInputProtocol)
    func getPredictionWeather()
    func getTodayWeather()
    func getTodayDay()
}

class WeatherViewController: UIViewController {
    var presenter: WeatherViewOutputProtocol!
    private let configurator: ConfiguratorProtocol = Configurator()
    
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nowLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configurate(with: self)
        presenter.getPredictionWeather()
        presenter.getTodayWeather()
        presenter.getTodayDay()
//        collectionView.delegate = self
//        collectionView.dataSource = self
    }
}

extension WeatherViewController: WeatherViewInputProtocol {
    func showTodayDay(todayDay: String) {
        todayLabel.text = todayDay
    }
}

//extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//    }
//
//}

