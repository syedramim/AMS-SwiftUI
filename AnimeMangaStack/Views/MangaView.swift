//
//  MangaView.swift
//  AnimeMangaStack
//  Created by Kaneis Zontanos on 4/27/23.
//

import SwiftUI

struct MangaView: View {
    @State var manga: Manga
    @State private var rateMangaPressed = false

    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color("launchScreenColor"), Color.black]), startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()

                    ScrollView {
                        Text(manga.title ?? "Unknown Title")
                            .font(.title)
                            .bold()
                            .foregroundColor(.accentColor)
                            .padding(.top, 20)
                        
                        VStack(alignment: .leading) {
                            MediaViewModel.getImage(imageURL: manga.images.jpg.large_image_url ?? "")
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(15)
                                .padding()

                            MediaRow(title: "Score", value: String(format: "%.1f", manga.score ?? 0.0))


                            Divider()

                            Group {
                                MediaRow(title: "Chapters", value: "\(manga.chapters ?? 0)")
                                MediaRow(title: "Volumes", value: "\(manga.volumes ?? 0)")
                                MediaRow(title: "Status", value: "\(manga.status ?? "Unknown")")
                                MediaRow(title: "Rating", value: "\(manga.rating ?? "Unknown")")
                                MediaRow(title: "Genres", value: "\(manga.genres.compactMap({$0.name}).joined(separator: ", "))")
                                MediaRow(title: "Demographics", value: "\(manga.demographics.compactMap({$0.name}).joined(separator: ", "))")
                                MediaRow(title: "Serializations", value: "\(manga.serializations.compactMap({$0.name}).joined(separator: ", "))")
                            }

                            Divider()

                            Group {
                                Text("Synopsis: ")
                                    .font(.lovelo(30))
                                    .bold()
                                    .foregroundColor(.accentColor)
                                    .padding(.top, 20)

                                Text(manga.synopsis ?? "No Synopsis Available")
                                    .font(.lovelo())
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)

                            }
                        }
                        .padding()
                        Button {
                            rateMangaPressed.toggle()
                        } label: {
                            RateButton(isAnime: false)
                        }
                    }
                }
                .navigationBarBackButtonHidden()
            }
            .fullScreenCover(isPresented: $rateMangaPressed) {
                RateMangaView(manga: manga)
            }
        }
    }
}




struct MangaView_Previews: PreviewProvider {
    static var previews: some View {
        let manga = Manga(title: "One Piece", chapters: 1000, volumes: 100, status: "Ongoing", rating: "PG-13", synopsis: "The story of Monkey D. Luffy who is aiming to become the Pirate King...", images: Images(jpg: ImageLink(image_url: "", small_image_url: "", large_image_url: "https://cdn.myanimelist.net/images/manga/2/253146l.jpg"), webp: ImageLink(image_url: "", small_image_url: "", large_image_url: "")), score: 9.0, genres: [Names(name: "Action"), Names(name: "Adventure"), Names(name: "Comedy")], demographics: [Names(name: "Shounen")], serializations: [Names(name: "Shounen Jump")])
        MangaView(manga: manga)
        
    }
}

