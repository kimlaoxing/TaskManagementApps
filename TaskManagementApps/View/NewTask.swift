//
//  NewTask.swift
//  TaskManagementApps
//
//  Created by kimlaoxing on 08/03/22.
//

import SwiftUI

struct NewTask: View {
    
    @Environment(\.dismiss) var dismiss
    @State var taskTitle: String = ""
    @State var taskDescription: String = ""
    @State var taskDate: Date = Date()
    
    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var taskModel: TaskViewModel
    var body: some View {
        NavigationView {
            List{
                Section {
                    TextField("Go To work", text: $taskTitle)
                } header: {
                    Text("Task Title")
                }
                
                Section {
                    TextField("Nothing", text: $taskDescription)
                } header: {
                    Text("Task Description")
                }
                
                if taskModel.editTask == nil {
                    Section {
                        DatePicker("", selection: $taskDate)
                            .datePickerStyle(.graphical)
                            .labelsHidden()
                    } header: {
                        Text("Task Date")
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Add New Task")
            .navigationBarTitleDisplayMode(.inline)
            .interactiveDismissDisabled()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save"){
                        if let task = taskModel.editTask {
                            task.taskTitle = taskTitle
                            task.taskDescription = taskDescription
                        } else {
                            let task = Task(context: context)
                            task.taskTitle = taskTitle
                            task.taskDescription = taskDescription
                            task.taskDate = taskDate
                        }
                        try? context.save()
                        dismiss()
                    }
                    .disabled(taskTitle == "" || taskDescription == "")
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel"){
                        dismiss()
                    }
                }
            }
            .onAppear {
                if let task = taskModel.editTask{
                    taskTitle = task.taskTitle ?? ""
                    taskDescription = task.taskDescription ?? ""
                }
            }
        }
    }
}

