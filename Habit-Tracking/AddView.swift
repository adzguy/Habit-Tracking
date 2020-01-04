//
//  AddView.swift
//  Habit-Tracking
//
//  Created by Davron on 1/2/20.
//  Copyright © 2020 Davron. All rights reserved.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentaionMode
    
    @ObservedObject var activities = Activities()
    @State private var title = ""
    @State private var description = ""
    @State private var count = "0"
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            VStack{
                Form {
                    TextField("Title", text: $title)
                        .font(.headline)
            
                    TextField("Description", text: $description)
                        .font(.body)

                }
            }
            .navigationBarTitle("Add New Activity")
            .navigationBarItems( leading: Button(action: {
                self.presentaionMode.wrappedValue.dismiss()
            }){
                Image(systemName: "xmark")
            }, trailing: Button("Save"){
                self.addHabit()
                
                if self.showAlert{
                    self.addHabit()
                }
                else {
                    self.presentaionMode.wrappedValue.dismiss()
                }
                
            })
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Empty Habit"), message: Text("Add new habit to the text field!"), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func addHabit() {
        if title == "" {
            showAlert = true
        }
        else {
            let habit = Habit(title: self.title, description: self.description, count: self.count)
            activities.activities.append(habit)
            showAlert = false
        }

    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
