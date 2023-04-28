//
//  ValuePicker.swift
//  AnimeMangaStack
//
//  Created by Kaneis Zontanos on 4/28/23.
//

import SwiftUI

struct ValuePicker: View {
    @Binding var selection: Int
    let range: ClosedRange<Int>
    let title: String
    
    var body: some View {
        VStack {
            
            Text(title)
                .font(.headline)
                .foregroundColor(.accentColor)
            
            Picker(selection: $selection, label: Text("")) {
                ForEach(range, id: \.self) { number in
                    Text("\(number)")
                        .tag(number)
                }
            }
            .labelsHidden()
            .padding()
            .background(Color("launchScreenColor"))
            .cornerRadius(10)
            .clipped()
            .pickerStyle(.wheel)
        }
    }
}

