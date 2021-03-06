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
    func reloadTableViewData(for section: TableSection)
}

protocol WeatherViewOutputProtocol: AnyObject {
    init(view: WeatherViewInputProtocol)
    func getFeatureWeather()
    func getTodayWeather()
    func getTodayDay()
    func getDataForLabel()
}

class WeatherViewController: UIViewController {
    
    private var section: SectionRowsRepresentable = CollectionSection()
    private var tableSection: TableSectionRowsRepresentable = TableSection()
    
    var presenter: WeatherViewOutputProtocol!

    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nowLabel: UILabel!
    
    private let mainColor = UIColor(red: 242/255,
                                green: 242/255,
                                blue: 247/255,
                                alpha: 1)
    private let distance: CGFloat = 20
    private let cornerRadius: CGFloat = 15
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getFeatureWeather()
        presenter.getTodayWeather()
        presenter.getTodayDay()
        presenter.getDataForLabel()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = mainColor
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.isUserInteractionEnabled = false
        tableView.layer.cornerRadius = cornerRadius
        
        view.backgroundColor = mainColor
    }
}

extension WeatherViewController: WeatherViewInputProtocol {
    func reloadTableViewData(for section: TableSection) {
        self.tableSection = section
        DispatchQueue.main.async {
            self.tableView.reloadData()
            guard let rowHeight = self.tableSection.rows.first?.height else { return }
            let rowCount = self.tableSection.rows.count
            let tableViewHeight = CGFloat(rowHeight) * CGFloat(rowCount)
            self.tableView.heightAnchor.constraint(equalToConstant: tableViewHeight).isActive = true
        }
    }
    
    
    func reloadCollectionViewData(for section: CollectionSection) {
        self.section = section
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func showTodayDay(todayDay: String) {
        todayLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 28.0)
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
        let weight = collectionView.frame.width - 120
        let height = collectionView.frame.height - 10
        return CGSize(width: CGFloat(weight), height: CGFloat(height))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: distance, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        distance
    }
}

extension WeatherViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableSection.rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableSection.rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCell.cellIdentifier, for: indexPath) as! TableViewCell
        cell.tableCell = tableCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(tableSection.rows[indexPath.row].height)
    }
}

