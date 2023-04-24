//
//  WeatherInformation.swift
//  Homebody
//
//  Created by 김상금 on 2023/03/30.
//

import Foundation
import HandyJSON

class WeatherInformation: HandyJSON {
    let weather: [Weather] = []
    let main: Temp = Temp()
    let name: String = ""
    
    required init() {}
    
    enum CodinKeys: String, CodingKey {
        case weather
        case temp = "main"
    }
}

class Weather: HandyJSON {
    let id: Int = 0
    let main: String = ""
    let description: String = ""
    let icon: String = ""
    
    required init() {}
}

class Temp: HandyJSON {
    let temp: Double = 0.0
    let feelsLike: Double = 0.0
    let minTemp: Double = 0.0
    let maxTemp: Double = 0.0
    let pressure: Int = 0
    let humidity: Int = 0
    
    required init() {}
    
    enum Codingkeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
        case pressure
        case humidity
    }
}
