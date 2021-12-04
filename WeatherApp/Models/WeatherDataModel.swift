//
//  Models.swift
//  WeatherApp
//
//  Created by Михаил Милюша on 27.11.2021.
//

import Foundation

struct WeatherData: Decodable {
    let now: Double?
    let info: Info?
    let fact: Fact?
    let forecast: Forecast?
}

struct Info: Decodable {
    let lat: Double?
    let lon: Double?
}

struct Fact: Decodable {
    let temp: Int? // температура
    let feelsLike: Int? // темп. ощущается
    let windSpeed: Int? // скорость ветра
    let pressureMm: Int? // давление (в мм рт. ст.)
    let humidity: Int? // влажность
    let obsTime: Double? // время замера
}

struct Forecast: Decodable {
    let parts: [Part]? // Время суток
}

struct Part: Decodable {
    let partName: String? // Название времени суток
    let tempMin: Int? // Минимальная температура для времени суток (°C)
    let tempMax: Int? // Максимальная температура для времени суток (°C)
    let feelsLike: Int? // Ощущаемая температура (°C)
}
