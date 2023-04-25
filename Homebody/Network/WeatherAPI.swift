//
//  WeatherAPI.swift
//  Homebody
//
//  Created by 김상금 on 2023/03/28.
//

import Foundation
import UIKit
import CoreLocation

class WeatherAPI {
    static let shared = WeatherAPI()
    
    let locationService = LocationService()
    private var weatherEntity: WeatherEntity = WeatherEntity()
    
    private init() {}
    
    func fetchWeatherDataWithCurrentLocation() {
        locationService.requestLocation { coordinate in
            // 여기서 아래 코드가 실행되지 않고 MainIntent 31로 이동 Why?
            self.fetchWeatherData(coordinate: coordinate)
        }
        
    }
    
    func getWeatherModel() -> WeatherEntity? {
        self.weatherEntity
    }
    
    private func fetchWeatherData(coordinate: CLLocationCoordinate2D) {
        let completion: ((WeatherInformation?) -> Void) = { data in
            guard let safeData = data else { return }
            self.weatherEntity.temp = safeData.main.temp
            self.weatherEntity.feelsLike = safeData.main.feelsLike
            self.weatherEntity.pres = safeData.main.pressure
            self.weatherEntity.humi = safeData.main.humidity
            self.weatherEntity.weather = safeData.weather[0].main
        }
        
        let url = URL.urlWith(coordinate: coordinate)
        guard let safeUrl = url else {
            return
        }
        
        APIManager.request(safeUrl, completion: completion)
    }
}
