//
//  CustomDatePicker.swift
//  Homebody
//
//  Created by 김상금 on 2023/03/15.
//

import SwiftUI

struct CustomDatePicker: View {
    // date = 날짜
    // day = 요일
    
    @Binding var currentDate: Date
    
    // Month update on arrow button clicks
    @State var currentMonth: Int = 0
    
    var body: some View {
        VStack(spacing: 35) {
            // Days...
            let days: [String] = ["일", "월", "화", "수", "목", "금", "토"]
            
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(extraData()[0])
                        .font(.caption)
                        .fontWeight(.semibold)
                    
                    Text(extraData()[1])
                        .font(.title.bold())
                }
                
                Spacer(minLength: 0)
                
                Button {
                    currentMonth -= 1
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(Color("Primary_Brown"))
                }
                
                Button {
                    currentMonth += 1
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                        .foregroundColor(Color("Primary_Brown"))
                }
                
            }
            .padding(.horizontal)
            
            // Day View...
            HStack(spacing: 0) {
                ForEach(days, id: \.self) { day in
                    Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            
            // Dates...
            // Lazy Grid
            
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            LazyVGrid(columns: columns, spacing: 13) {
                ForEach(extractDate()) { value in
                    CardView(value: value)
                        .background(
                            Capsule()
                                .fill(Color("Primary_Orange"))
                                .padding(.horizontal, 8)
                                .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                        )
                        .onTapGesture {
                            currentDate = value.date
                        }
                }
            }
            
            VStack(spacing: 15) {
                Text("날씨 정보")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 20)
                
//                if let weather = weathers.first(where: { weather in
//                    return isSameDay(date1: weather.date, date2: currentDate)
//                }) {
//                    
//                }
//                
                if let task = tasks.first(where: { task in
                    return isSameDay(date1: task.taskDate, date2: currentDate)
                }) {

                    ForEach(task.task) { task in
                        VStack(alignment: .leading, spacing: 10) {
                            // For Custom Timing
                            Text(task.time.addingTimeInterval(CGFloat.random(in: 0...5000)), style: .time)
                            Text(task.title)
                                .font(.title2.bold())
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            Color("Primary_Orange")
                                .opacity(0.5)
                                .cornerRadius(10)
                        )
                    }

                } else {
                    Text("날씨 정보를 들고오지 못했어요😭")
                }
            }
            .padding()
        }
        .onChange(of: currentMonth) { newValue in
            // updating month
            currentDate = getCurrentMonth()
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue) -> some View {
        VStack {
            if value.day != -1 {
                if let task = tasks.first(where: { task in
                    return isSameDay(date1: task.taskDate, date2: value.date)
                }) {
                    
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: task.taskDate, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                    
                    // MARK: - 날씨에 따라 동그라미 색깔 변경
                    if (task.weatherState == .bad) {
                        Circle()
                            .fill(isSameDay(date1: task.taskDate, date2: currentDate) ? .white : Color("Red"))
                            .frame(width: 8, height: 8)
                    } else if (task.weatherState == .soso) {
                        Circle()
                            .fill(isSameDay(date1: task.taskDate, date2: currentDate) ? .white : Color("Primary_Orange"))
                            .frame(width: 8, height: 8)
                    } else if (task.weatherState == .good) {
                        Circle()
                            .fill(isSameDay(date1: task.taskDate, date2: currentDate) ? .white : Color("Green"))
                            .frame(width: 8, height: 8)
                    } else {
                        Circle()
                            .fill(isSameDay(date1: task.taskDate, date2: currentDate) ? .white : Color("Blue"))
                            .frame(width: 8, height: 8)
                        
                    }
                } else {
                    
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                    
                }
            }
        }
        .padding(.vertical, 9)
        .frame(height: 60, alignment: .top)
    }
}

struct CustomDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        MainView.build()
    }
}

extension CustomDatePicker {
    // MARK: - Functions
    
    // checking dates...
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    // Extrating Year And Month For Display
    func extraData() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY M월"
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
    }
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        
        return currentMonth
    }
    
    //
    func extractDate() -> [DateValue] {
        // Getting Current Month Date
        let calendar = Calendar.current
        
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            // getting day...
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
        }
        
        // adding offset days to get exact week day
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
}
