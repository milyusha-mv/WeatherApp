//
//  WeatherCollectionModel.swift
//  WeatherApp
//
//  Created by Михаил Милюша on 27.11.2021.
//

import Foundation

protocol CollectionCellIdentifier {
    var height: Float { get }
    var width: Float { get }
    var cellIdentifier: String { get }
}

protocol SectionRowsRepresentable {
    var rows: [CollectionCellIdentifier] { get set }
}

class CollectionCell: CollectionCellIdentifier {
    var height: Float = 50
    var width: Float = 50
    var cellIdentifier = "collectionCell"
    
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
