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
    var height: Float = 100
    var width: Float = 300
    var cellIdentifier = "collectionCell"
    
    let partName: String
    let tempMin: Int
    let tempMax: Int
    let feelsLike: Int
    let imageCollection: String
    
    
    init(prediction: Prediction) {
        partName = prediction.partName
        tempMin = prediction.tempMin
        tempMax = prediction.tempMax
        feelsLike = prediction.feelsLike
        imageCollection = prediction.imageCollection
    }
}

class CollectionSection: SectionRowsRepresentable {
    var rows: [CollectionCellIdentifier] = []
}
