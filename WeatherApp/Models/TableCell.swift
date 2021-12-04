//
//  TableCell.swift
//  WeatherApp
//
//  Created by Михаил Милюша on 03.12.2021.
//

import Foundation

protocol TableCellIdentifier {
    var height: Float { get }
    var cellIdentifier: String { get }
}

protocol TableSectionRowsRepresentable {
    var rows: [TableCellIdentifier] { get set }
}

class TableCell: TableCellIdentifier {
    var height: Float = 50
    var cellIdentifier = "tableCell"
    
    let title: String
    let value: Int
    let valueSign: String
    let image: String
    
    init(currentWeather: CurrentWeather) {
        title = currentWeather.title
        value = currentWeather.value
        valueSign = currentWeather.valueSign
        image = currentWeather.image
    }
}

class TableSection: TableSectionRowsRepresentable {
    var rows: [TableCellIdentifier] = []
}
