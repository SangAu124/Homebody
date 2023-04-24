//
//  WeatherEntity.swift
//  Homebody
//
//  Created by 김상금 on 2023/04/20.
//

import Foundation

struct WeatherEntity: Equatable {
    var temp: Double = 0.0
    var feelsLike: Double = 0.0
    var humi: Int = 0
    var weather: String = ""
    var pres: Int = 0
    var state: WeatherState = .bad
}

enum WeatherState: String {
    case bad = "안나가시는게 어떤가요?😓"
    case soso = "굳이 나갈 필요는 없어요😌"
    case good = "나쁘지 않은 오늘 걸어봐요!😊"
    case perfect = "오늘은 산책하는 날!🥳"
}
