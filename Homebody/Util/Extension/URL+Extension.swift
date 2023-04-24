//
//  URL+Extension.swift
//  Homebody
//
//  Created by 김상금 on 2023/03/28.
//

import Foundation
import CoreLocation


extension URL {
    static func urlWith(coordinate: CLLocationCoordinate2D) -> String? {
        
        let lat = round(coordinate.latitude*100)/100
        let lon = round(coordinate.longitude*100)/100
        
        return "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(Constants.API_KEY)"
    }
}
