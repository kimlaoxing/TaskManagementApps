//  Created by Kevin Maulana on 08/03/22.

import SwiftUI
import CoreData

struct DynamicFilteredView<Content: View, T>: View where T: NSManagedObject {
    @FetchRequest var request: FetchedResults<T>
    let content: (T)->Content
    init(dateToFilter: Date, @ViewBuilder content: @escaping (T)->Content) {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: dateToFilter)
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
        let filterKey = "taskDate"
        let predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@", argumentArray: [today, tomorrow])
        
        _request = FetchRequest(entity: T.entity(), sortDescriptors: [.init(keyPath: \Task.taskDate, ascending: false)], predicate: predicate)
        self.content = content
    }
    
    var body: some View {
        Group {
            if request.isEmpty {
                Text("No tasks found")
                    .font(.system(size: 14))
                    .fontWeight(.light)
                    .offset(y: 100)
            } else {
                ForEach(request,id: \.objectID){ object in
                    self.content(object)
                }
            }
        }
    }
}

//struct DynamicFilteredView_Previews: PreviewProvider {
//    static var previews: some View {
//        DynamicFilteredView()
//    }
//}
