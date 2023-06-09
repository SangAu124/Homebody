//
//  MainIntent.swift
//  Homebody
//
//  Created by 김상금 on 2023/03/17.
//

import Foundation

final class MainIntent: MainIntentProtocol {
    private weak var model: WeatherModelActionProtocol?
    private let weatherAPI = WeatherAPI.shared

    init(
        model: any WeatherModelActionProtocol
    ) {
        self.model = model
    }
    
    func onAppear() {
        
    }
    
    func refreshView() {
        getWeather()
    }
    
    func getWeather() {
        weatherAPI.fetchWeatherDataWithCurrentLocation()
        
        let weather = weatherAPI.getWeatherModel()!
        let temp = weather.temp - 273.15
        
        model?.setTodayState(state: decideDaystate(temp: temp))
        model?.updateTodayWeather(weather: weather)
    }
    
}

extension MainIntent {
    private func decideDaystate(temp: Double) -> WeatherState {
        if temp >= 17 && temp <= 21 {
            return .perfect
        } else if temp >= 15.6 && temp <= 25.0 {
            return .good
        } else if temp >= 10.0 && temp <= 27.6 {
            return .soso
        } else {
            return .bad
        }
    }
}
