//
//  Models.swift
//  WeatherApp
//
//  Created by Михаил Милюша on 27.11.2021.
//

import Foundation

struct WeatherData: Decodable {
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
    let feels_like: Int? // темп. ощущается
    let wind_speed: Int? // скорость ветра
    let pressure_mm: Int? // давление (в мм рт. ст.)
    let humidity: Int? // влажность
    let obs_time: Int? // время замера
}

struct Forecast: Decodable {
    let parts: [Part]? // Время суток
}

struct Part: Decodable {
    let part_name: String? // Название времени суток
    let temp_min: Int? // Минимальная температура для времени суток (°C)
    let temp_max: Int? // Максимальная температура для времени суток (°C)
    let feels_like: Int? // Ощущаемая температура (°C)
}
