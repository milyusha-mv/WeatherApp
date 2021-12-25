//
//  RequestData.swift
//  WeatherApp
//
//  Created by Михаил Милюша on 27.11.2021.
//

import Foundation

struct RequestData {
    let host: String
    let header: String
    let apiKey: String
    let path: String
    var lat: String
    var lon: String
    let limit: String
    let extra: String
}
