//
//  Task.swift
//  Homebody
//
//  Created by 김상금 on 2023/03/15.
//

import SwiftUI

struct Task: Identifiable {
    var id = UUID().uuidString
    var title: String
    var time: Date = Date()
}

struct TaskMetaData: Identifiable {
    var id = UUID().uuidString
    var task: [Task]
    var taskDate: Date
    var weatherState: WeatherState
}

func getSampleDate(offset: Int) -> Date {
    let calender = Calendar.current
    let date = calender.date(byAdding: .day, value: offset, to: Date())
    return date ?? Date()
}

var tasks: [TaskMetaData] = [
    TaskMetaData(task: [
        Task(title: "기온 : 21°C"),
        Task(title: "습도 : 25%"),
        Task(title: "강수 확률 : 0%")
    ], taskDate: getSampleDate(offset: 0), weatherState: .soso),
    
    TaskMetaData(task: [
        Task(title: "일4"),
        Task(title: "일5"),
        Task(title: "일6")
    ], taskDate: getSampleDate(offset: 1), weatherState: .bad),
    
    TaskMetaData(task: [
        Task(title: "일7"),
        Task(title: "일8"),
        Task(title: "일9")
    ], taskDate: getSampleDate(offset: 2), weatherState: .soso),
    
    TaskMetaData(task: [
        Task(title: "일10"),
        Task(title: "일11"),
        Task(title: "일12")
    ], taskDate: getSampleDate(offset: 3), weatherState: .perfect),
    
    TaskMetaData(task: [
        Task(title: "일13"),
        Task(title: "일14"),
        Task(title: "일15")
    ], taskDate: getSampleDate(offset: 4), weatherState: .good),
    
    TaskMetaData(task: [
        Task(title: "일16"),
        Task(title: "일17"),
        Task(title: "일18")
    ], taskDate: getSampleDate(offset: 5), weatherState: .good)
]
