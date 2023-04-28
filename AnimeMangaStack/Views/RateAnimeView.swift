//
//  RateAnimeView.swift
//  AnimeMangaStack
//
//  Created by Kaneis Zontanos on 4/28/23.
//

import SwiftUI

struct RateAnimeView: View {
    @Environment(\.dismiss) private var dismiss
    @State var anime: Anime
    @State private var status: RateOptions = .finished
    @State private var score: Int = 0
    @State private var watchedEpisodes: Int? = 0
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            
            Text("\(anime.title ?? "N/A: ERROR")")
                .font(.lovelo(30))
                .bold()
                .padding(.top, 20)
                .foregroundColor(.accentColor)
                .lineLimit(2)
                .minimumScaleFactor(0.25)
            
            
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

            
            ValuePicker(selection: $watchedEpisodes, range: 0...(anime.episodes ?? 0), title: "Episodes Watched:")
                .padding()
            
            Spacer()
            
            Button(action: {
                // Save the rating and dismiss the view
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


struct RateAnimeView_Previews: PreviewProvider {
    static var previews: some View {
        let anime = Anime(
            title: "Attack on Titan",
            episodes: 75,
            status: "Finished Airing",
            duration: "24 min per ep",
            rating: "R - 17+ (violence & profanity)",
            synopsis: "Centuries ago, mankind was slaughtered to near extinction by monstrous humanoid creatures called titans, forcing humans to hide in fear behind enormous concentric walls.",
            images: Images(
                jpg: ImageLink(
                    image_url: "https://example.com/attackontitan.jpg",
                    small_image_url: "https://example.com/attackontitan_small.jpg",
                    large_image_url: "https://example.com/attackontitan_large.jpg"
                ),
                webp: ImageLink(
                    image_url: "https://example.com/attackontitan.webp",
                    small_image_url: "https://example.com/attackontitan_small.webp",
                    large_image_url: "https://example.com/attackontitan_large.webp"
                )
            ),
            trailer: Trailer(youtube_id: "1sJWZPVAoPE"),
            score: 8.49,
            genres: [Names(name: "Action"), Names(name: "Drama"), Names(name: "Fantasy"), Names(name: "Military"), Names(name: "Mystery"), Names(name: "Shounen"), Names(name: "Super Power")],
            demographics: [Names(name: "Shounen")],
            producers: [Names(name: "Production I.G"), Names(name: "Dentsu"), Names(name: "Mainichi Broadcasting System"), Names(name: "Pony Canyon"), Names(name: "Kodansha"), Names(name: "Mad Box"), Names(name: "VRV")],
            licensors: [Names(name: "Funimation"), Names(name: "Crunchyroll")],
            studios: [Names(name: "Wit Studio")]
        )

        RateAnimeView(anime: anime)
    }
}
