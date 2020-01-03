//
//  DetailView.swift
//  Habit-Tracking
//
//  Created by Davron on 1/3/20.
//  Copyright © 2020 Davron. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    var activity: Habit
    @State private var count = 0
    
    var body: some View {
        VStack{
            Text("\(activity.description)")
                .fontWeight(.medium)
            Text("Count: \(activity.count)")
            
            Button(action: {
                self.addCount()
            }, label: {
                Text("+1")
            })
        }
    }
    
    func addCount() {
        let counter = count + 1
        //activity count is immutable. How do we solce this???
        activity.count = counter
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(activity: Activities().activities[0])
    }
}
