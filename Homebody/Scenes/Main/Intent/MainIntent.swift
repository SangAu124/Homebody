//
//  MainIntent.swift
//  Homebody
//
//  Created by 김상금 on 2023/03/17.
//

import Combine

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
        if temp >= 17 && temp <= 21 {
            
            model?.setTodayState(state: .perfect)
            
        } else if temp >= 15.6 && temp <= 25.0 {
            
            model?.setTodayState(state: .good)
            
        } else if temp >= 10.0 && temp <= 27.6 {
            
            model?.setTodayState(state: .soso)
            
        } else {
            
            model?.setTodayState(state: .bad)
            
        }
        
        model?.updateTodayWeather(weather: weather)
        print(weather.state.rawValue)
        
    }
    
}
