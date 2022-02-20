//  Created by Kevin Maulana on 20/02/2022.

import SwiftUI

struct Home: View {
    @StateObject var taskModel: TaskViewModel = TaskViewModel()
    @Namespace var animation
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
                Section {
                    // MARK: CURRENT WEEK VIEW
                    ScrollView(.horizontal, showsIndicators:  false) {
                        HStack(spacing: 10) {
                            ForEach(taskModel.currentWeek, id: \.self) { day in
                                VStack(spacing: 10) {
                                    Text(taskModel.extractDate(date: day, format: "EEE"))
                                        .font(.system(size: 15))
                                        .fontWeight(.semibold)
                                    
                                    Text(taskModel.extractDate(date: day, format: "dd"))
                                        .font(.system(size: 15))
                                        .fontWeight(.semibold)
                                      
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 8, height: 8)
                                        .opacity(taskModel.isToday(date: day) ? 1 : 0)
                                }
                                .foregroundStyle(taskModel.isToday(date: day) ? .primary : .secondary)
                                .foregroundColor(taskModel.isToday(date: day) ? .white : .black)
                                .frame(width: 45, height: 90)
                                .background(
                                    ZStack{
                                        if taskModel.isToday(date: day){
                                            Capsule()
                                                .fill(.black)
                                                .matchedGeometryEffect(id: "CURRENTDATE", in: animation)
                                        }
                                    }
                                )
                                .contentShape(Capsule())
                                .onTapGesture {
                                    withAnimation {
                                        taskModel.currentDay = day
                                    }
                                }
                            }
                        }
                    }
                    
                    taskView()
                } header: {
                    headerView()
                }
            }
        }
    }
    
    func taskView()-> some View {
        LazyVStack(spacing: 18) {
            if let tasks = taskModel.filteredTasks{
                if tasks.isEmpty {
                    Text("No tasks found")
                        .font(.system(size: 14))
                        .fontWeight(.light)
                        .offset(y: 100)
                } else {
                    ForEach(tasks) { tasks in
                        TasksCardView(task: tasks)                    }
                }
            } else {
                ProgressView()
                    .offset(y: 100)
            }
        }
        .padding()
        .padding(.top)
        .onChange(of: taskModel.currentDay) { newValue in
            taskModel.filterTodayTasks()
        }
    }
    
    func TasksCardView(task: Task) -> some View {
        HStack{
            VStack(spacing: 10) {
                Circle()
                    .fill(.black)
                    .frame(width: 15, height: 15)
                    .background(
                    Circle()
                        .stroke(.black,lineWidth: 1)
                        .padding(-3)
                    )
            }
        }
        .hLeading()
    }
    
    func headerView()-> some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 10) {
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .foregroundColor(.gray)
                
                Text("Today")
                    .font(.largeTitle.bold())
            }
            .hLeading()
            Button {
                
            } label: {
                Image("SUCCESS")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
            }
        }
        .padding()
        .background(Color.white)
    }
}

extension View {
    func hLeading() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func hTrailing() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    func hCenter() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
