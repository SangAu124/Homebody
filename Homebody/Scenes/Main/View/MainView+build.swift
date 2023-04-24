//
//  MainView+build.swift
//  Homebody
//
//  Created by 김상금 on 2023/03/17.
//

import SwiftUI

extension MainView {
    static func build() -> some View {
        let model = WeatherModel()
        let intent = MainIntent(model: model)
        let container = MVIContainer(
            intent: intent as any MainIntentProtocol,
            model: model as any WeatherModelStateProtocol,
            modelChangePublisher: model.objectWillChange
        )
        return MainView(container: container)
    }
}
