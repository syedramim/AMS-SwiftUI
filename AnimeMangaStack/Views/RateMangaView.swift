//
//  RateMangaView.swift
//  AnimeMangaStack
//
//  Created by Kaneis Zontanos on 4/28/23.
//

import SwiftUI

struct RateMangaView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var score: Int = 5
    @State var status: RateOptions = .finished
    @State var volumesRead: Int = 0
    @State var chaptersRead: Int = 0
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Rate Manga")
                .font(.title)
                .bold()
                .padding(.top, 20)
                .foregroundColor(.accentColor)
            
            Spacer()
            
            HStack {
                Text("Score:")
                    .font(.headline)
                    .foregroundColor(.white)
                Slider(value: Binding(
                            get: { Double(self.score) },
                            set: { newValue in self.score = Int(newValue) }),
                        in: 0...10)
                    .accentColor(.accentColor)
                Text("\(score)")
                    .font(.headline)
                    .foregroundColor(.accentColor)
            }
            .padding()
            
            HStack {
                Text("Status:")
                    .font(.headline)
                    .foregroundColor(.white)
                Picker(selection: $status, label: Text("")) {
                    ForEach(RateOptions.allCases, id: \.self) { option in
                        Text(option.contentStatus)
                            .tag(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .accentColor(.accentColor)
            }
            .padding()
            
            ValuePicker(selection: $volumesRead, range: 0...1000, title: "Volumes Read:")
                .padding()

            ValuePicker(selection: $chaptersRead, range: 0...10000, title: "Chapters Read:")
                .padding()

            
            Spacer()
            
            Button(action: {
                // Save the rating and dismiss the view
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Save Rating")
                    .font(.headline)
                    .foregroundColor(.accentColor)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
            })
            .padding(.bottom, 20)
            
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color("launchScreenColor"), Color.black]), startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea())
        .foregroundColor(.white)
    }
}


struct RateMangaView_Previews: PreviewProvider {
    static var previews: some View {
        RateMangaView()
    }
}

