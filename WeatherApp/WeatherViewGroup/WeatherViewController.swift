//
//  ViewController.swift
//  WeatherApp
//
//  Created by Михаил Милюша on 21.11.2021.
//

import UIKit

protocol WeatherViewInputProtocol: AnyObject {
    func showTodayDay(todayDay: String)
    func setDataForLabel(text: String)
    func reloadCollectionViewData(for section: CollectionSection)
}

protocol WeatherViewOutputProtocol: AnyObject {
    init(view: WeatherViewInputProtocol)
    func getPredictionWeather()
    func getTodayWeather()
    func getTodayDay()
    func getDataForLabel()
}

class WeatherViewController: UIViewController {
    
    private var section: SectionRowsRepresentable = CollectionSection()
    
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
        presenter.getDataForLabel()
        
        view.backgroundColor = .systemGreen
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension WeatherViewController: WeatherViewInputProtocol {
    
    func reloadCollectionViewData(for section: CollectionSection) {
        self.section = section
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func showTodayDay(todayDay: String) {
        todayLabel.text = todayDay
    }
    func setDataForLabel(text: String) {
        nowLabel.text = text
    }
}



extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.section.rows.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = section.rows[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCell.cellIdentifier, for: indexPath) as! CollectionViewCell
        cell.collectionCell = collectionCell
        return cell
    }
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: CGFloat(section.rows[indexPath.row].width), height: CGFloat(section.rows[indexPath.row].height))
    }
}

