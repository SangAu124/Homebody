//
//  WeatherModelProtocol.swift
//  Homebody
//
//  Created by 김상금 on 2023/03/17.
//

import Foundation

protocol WeatherModelStateProtocol {
    var weather: [WeatherEntity] { get }
    var isLoading: Bool { get }
}

protocol WeatherModelActionProtocol: AnyObject {
    func updateWeather(weather: [WeatherEntity])
    func updateTodayWeather(weather: WeatherEntity)
    func setTodayState(state: WeatherState)
}
