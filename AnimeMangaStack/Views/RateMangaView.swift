//
//  RateMangaView.swift
//  AnimeMangaStack
//
//  Created by Kaneis Zontanos on 4/28/23.
//

import SwiftUI

struct RateMangaView: View {
    @EnvironmentObject var profileVM: ProfileViewModel
    @Environment(\.dismiss) private var dismiss
    @State var manga: Manga
    @State private var status: RateOptions = .finished
    @State private var score: Int = 0
    @State private var readChapters: Int = 0
    @State private var readVolumes: Int = 0
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Rate \(manga.title ?? "N/A: ERROR")")
                .font(.title)
                .bold()
                .padding(.top, 20)
                .foregroundColor(.accentColor)
            
            Spacer()
            
            HStack {
                Text("Score:")
                    .font(.lovelo())
                    .foregroundColor(.accentColor)
                Slider(value: Binding(
                    get: { Double(self.score) },
                    set: { newValue in self.score = Int(newValue) }),
                       in: 0...10)
                .accentColor(.accentColor)
                Text("\(score)")
                    .font(.lovelo())
                    .foregroundColor(.accentColor)
            }
            .padding()
            
            HStack {
                Text("Status:")
                    .font(.lovelo())
                    .foregroundColor(.accentColor)
                Picker(selection: $status, label: Text("")) {
                    ForEach(RateOptions.allCases, id: \.self) { option in
                        Text(option.contentStatus)
                            .font(.lovelo())
                            .foregroundColor(.accentColor)
                            .tag(option)
                    }
                }
                .pickerStyle(.wheel)
            }
            .padding()
            
            ValuePicker(selection: $readVolumes, range: 0...(manga.volumes ?? 0), title: "Volumes Read:")
                .padding()

            ValuePicker(selection: $readChapters, range: 0...(manga.chapters ?? 0), title: "Chapters Read:")
                .padding()

            
            Spacer()
            
            Button(action: {
                Task {
                    do {
                        try await profileVM.addMangaToProfile(manga: manga, status: status, score: score, readChapters: readChapters, readVolumes: readVolumes)
                        dismiss()
                    } catch {
                        print("Error appending anime to profile: \(error)")
                    }

                }
                dismiss()
            }, label: {
                Text("Save Rating")
                    .font(.lovelo())
                    .foregroundColor(.accentColor)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(Color("launchScreenColor"))
                    .cornerRadius(15)
                    .shadow(radius: 5)
            })
            .padding(.bottom, 20)
            
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color("launchScreenColor"), Color.black]), startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea())
    }
}


struct RateMangaView_Previews: PreviewProvider {
    static var previews: some View {
        let manga = Manga(
            title: "One Piece",
            chapters: 1024,
            volumes: 100,
            status: "Ongoing",
            rating: "T",
            synopsis: "Monkey D. Luffy sets out to become the King of the Pirates.",
            images: Images(
                jpg: ImageLink(
                    image_url: "https://example.com/onepiece.jpg",
                    small_image_url: "https://example.com/onepiece_small.jpg",
                    large_image_url: "https://example.com/onepiece_large.jpg"
                ),
                webp: ImageLink(
                    image_url: "https://example.com/onepiece.webp",
                    small_image_url: "https://example.com/onepiece_small.webp",
                    large_image_url: "https://example.com/onepiece_large.webp"
                )
            ),
            score: 8.7,
            genres: [Names(name: "Action"), Names(name: "Adventure"), Names(name: "Comedy"), Names(name: "Drama"), Names(name: "Fantasy")],
            demographics: [Names(name: "Shonen")],
            serializations: [Names(name: "Weekly Shonen Jump")]
        )

        RateMangaView(manga: manga)
            .environmentObject(ProfileViewModel())
    }
}

