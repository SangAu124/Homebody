//
//  WeatherModel.swift
//  Homebody
//
//  Created by 김상금 on 2023/03/17.
//

import SwiftUI
import Foundation

final class WeatherModel: ObservableObject, WeatherModelStateProtocol {
    @Published var weather: [WeatherEntity] = []
    @Published var isLoading: Bool = false
}

extension WeatherModel: WeatherModelActionProtocol {
    func updateWeather(weather: [WeatherEntity]) {
        self.weather = weather
    }
    
    func updateTodayWeather(weather: WeatherEntity) {
        self.weather.insert(weather, at: 0)
        print(weather.state.rawValue)
    }
    
    func setTodayState(state: WeatherState) {
//        self.weather[]. state = state
    }
}
