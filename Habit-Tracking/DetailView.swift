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
    @State private var color = false
    
    var body: some View {
        VStack{
            ZStack{
                RectangleView()
                    //.frame(width: 350, height: 250)
                VStack{
                    Text("Description:")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("\(activity.description)")
                    .italic()
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding()
                    Text("Count: \(count)")
                        .foregroundColor(.white)
                        .font(.footnote)
                    
                }

            }
            
            Button(action: {
                self.addCount()
                self.color = true
            })
            {
                Text("+1")
                    .frame(width: 60, height: 60)
                    .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                .clipShape(Circle())
                .shadow(color: .gray, radius: 10, x: 10, y: 10)
            }
            
            Spacer()
        }
    }
    
    func addCount() {
        count = count + 1
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(activity: Activities().activities[0])
    }
}
