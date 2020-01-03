//
//  ContentView.swift
//  Habit-Tracking
//
//  Created by Davron on 1/2/20.
//  Copyright © 2020 Davron. All rights reserved.
//

import SwiftUI

struct Habit: Identifiable, Codable {
    
    var id = UUID()
    //var activity : String
    var title: String
    var description: String
    var count: Int
}

class Activities: ObservableObject {
    @Published var activities = [Habit]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "Activities")
            }
        }
    }
    init() {
        if let activities = UserDefaults.standard.data(forKey: "Activities") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Habit].self, from: activities) {
                self.activities = decoded
                return
            }
        }
        self.activities = []
    }
    
}

struct ContentView: View {
    @ObservedObject var activities = Activities()
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView {
            List{
                ForEach(activities.activities) { activity in
                    NavigationLink(destination: DetailView(activity: activity)) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("\(activity.title)")
                                .font(.headline)
                            Text("\(activity.description)")
                        }
                    }
                }
                .onDelete(perform: removeHabit)
            }
            .navigationBarTitle("Habit Tracker")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                
                if self.showingSheet {
                    self.showingSheet = false
                }
                self.showingSheet = true
            })
            {
                Image(systemName: "plus")
            }
            )
        }
        .sheet(isPresented: $showingSheet ) {
            AddView(activities: self.activities)
        }
    }
    
    func removeHabit(at offsets: IndexSet) {
        activities.activities.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
