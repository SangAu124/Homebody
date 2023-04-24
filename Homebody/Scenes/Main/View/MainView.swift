//
//  MainView.swift
//  Homebody
//
//  Created by 김상금 on 2023/03/14.
//

import SwiftUI
import CoreLocation

struct MainView: View {
    @StateObject var container: MVIContainer<MainIntentProtocol, WeatherModelStateProtocol>
    private var intent: any MainIntentProtocol { container.intent }
    private var state: any WeatherModelStateProtocol { container.model }
    
    @State var currentDate: Date = Date()
    @State private var showingAlert: Bool = false
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                //커스텀 DatePicker
                CustomDatePicker(currentDate: $currentDate)
            }
            .padding(.vertical)
        }
        // SafeAreaView
        .safeAreaInset(edge: .bottom) {
            HStack {
                Button {
                    intent.getWeather()
                } label: {
                    Text("새로고침")
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color("Primary_Orange"), in: Capsule())
                }
                Button {
                    showingAlert = true
                } label: {
                    Text("눌러보세요")
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color("Primary_Orange"), in: Capsule())
                }
                .alert("\"홈바디\" 어떠신가요?\n마음에 드신다면\n주변에 공유해 주세요!🥰", isPresented: $showingAlert) {
                    Button("확인", role: .cancel) {}
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
            .foregroundColor(.white)
            .background(.ultraThinMaterial)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView.build()
    }
}
