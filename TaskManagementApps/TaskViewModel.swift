//  Created by Kevin Maulana on 20/02/2022.

import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var storedTask: [Task] = [
        Task(taskTitle: "Meeting", taskDescription: "Discuess team task for the day", taskDate: .init(timeIntervalSince1970: 1641645497)),
        Task(taskTitle: "Icon set", taskDescription: "Edit icons for team task for next week", taskDate: .init(timeIntervalSince1970: 1641649097)),
        Task(taskTitle: "Prototype", taskDescription: "Make and send prototype", taskDate: .init(timeIntervalSince1970: 1641652697)),
        Task(taskTitle: "Check asset", taskDescription: "Start checking the assets", taskDate: .init(timeIntervalSince1970: 1641656297)),
        Task(taskTitle: "Team party", taskDescription: "Make fun with team mates", taskDate: .init(timeIntervalSince1970: 1641661897)),
        Task(taskTitle: "Client Meeting", taskDescription: "Explain proejct to clinet", taskDate: .init(timeIntervalSince1970: 1641641897)),
        Task(taskTitle: "Next Project", taskDescription: "Dicuss next proejct with team", taskDate: .init(timeIntervalSince1970: 1641677897)),
        Task(taskTitle: "App Proposoal", taskDescription: "Meet client for next App Proposal", taskDate: .init(timeIntervalSince1970: 1641681497)),
    ]
    
    @Published var currentWeek: [Date] = []
    @Published var currentDay: Date = Date()
    @Published var filteredTasks:  [Task]?
    
    init() {
        fetchCurrentWeek()
        filterTodayTasks()
    }
    
    func filterTodayTasks() {
        DispatchQueue.global(qos: .userInteractive).async {
            let calendar = Calendar.current
            let filtered = self.storedTask.filter{
                return calendar.isDate($0.taskDate, inSameDayAs: self.currentDay)
            }
            DispatchQueue.main.async {
                withAnimation {
                    self.filteredTasks = filtered
                }
            }
        }
    }
    
    func fetchCurrentWeek() {
        let today = Date()
        let calendar = Calendar.current
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        guard let firstWeekday = week?.start else { return }
        
        (0...7).forEach { day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekday) {
                currentWeek.append(weekday)
            }
        }
    }
    
    func extractDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    func isToday(date: Date)->Bool {
        let calendar = Calendar.current
        return calendar.isDate(currentDay, inSameDayAs: date)
    }
}
 
