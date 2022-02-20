//
//  TaskManagementAppsApp.swift
//  TaskManagementApps
//
//  Created by Kevin Maulana on 20/02/2022.
//

import SwiftUI

@main
struct TaskManagementAppsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
