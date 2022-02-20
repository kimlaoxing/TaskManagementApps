//
//  TaskModel.swift
//  TaskManagementApps
//
//  Created by Kevin Maulana on 20/02/2022.
//

import Foundation
import SwiftUI

struct Task: Identifiable {
    var id = UUID().uuidString
    var taskTitle: String
    var taskDescription: String
    var taskDate: Date
}
