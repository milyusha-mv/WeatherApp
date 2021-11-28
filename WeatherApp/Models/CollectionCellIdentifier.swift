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

class WeatherCell: CollectionCellIdentifier {
    var height: Float = 200
    var width: Float = 200
    var cellIdentifier = "collectionCell"
    
    let part_name: String
    let temp_min: Int
    let temp_max: Int
    let feels_like: Int
    let imageCollection: String
    
    
    init(prediction: Prediction) {
        part_name = prediction.part_name
        temp_min = prediction.temp_min
        temp_max = prediction.temp_max
        feels_like = prediction.feels_like
        imageCollection = prediction.imageCollection
    }
}

class CollectionSection: SectionRowsRepresentable {
    var rows: [CollectionCellIdentifier] = []
}
