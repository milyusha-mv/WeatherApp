//
//  WeatherCollectionModel.swift
//  WeatherApp
//
//  Created by Михаил Милюша on 27.11.2021.
//

import Foundation

protocol CollectionCellIdentifier {
    var cellIdentifier: String { get }
}

protocol SectionRowsRepresentable {
    var rows: [CollectionCellIdentifier] { get set }
}

class CollectionCell: CollectionCellIdentifier {
    var cellIdentifier = "collectionCell"
    var cornerRadius = 15
    
    let partName: String
    let tempMin: Int
    let tempMax: Int
    let feelsLike: Int
    let imageCollection: String
    
    
    init(featureWeather: FeatureWeather) {
        partName = featureWeather.partName
        tempMin = featureWeather.tempMin
        tempMax = featureWeather.tempMax
        feelsLike = featureWeather.feelsLike
        imageCollection = featureWeather.imageCollection
    }
}

class CollectionSection: SectionRowsRepresentable {
    var rows: [CollectionCellIdentifier] = []
}
