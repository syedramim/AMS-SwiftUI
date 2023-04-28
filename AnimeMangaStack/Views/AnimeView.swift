//
//  AnimeView.swift
//  AnimeMangaStack
//
//  Created by Kaneis Zontanos on 4/28/23.
//

import SwiftUI

struct AnimeView: View {
    @State var anime: Anime
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color("launchScreenColor"), Color.black]), startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                    
                    ScrollView {
                        Text(anime.title ?? "Unknown Title")
                            .font(.title)
                            .bold()
                            .foregroundColor(.accentColor)
                            .padding(.top, 20)
                        
                        VStack(alignment: .leading) {
                            MediaViewModel.getImage(imageURL: anime.images.jpg.large_image_url ?? "")
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(15)
                                .padding()
                            
                            MediaRow(title: "Score", value: String(format: "%.1f", anime.score ?? 0.0))
                            
                            Divider()
                            
                            Group {
                                MediaRow(title: "Episodes", value: "\(anime.episodes ?? 0)")
                                MediaRow(title: "Status", value: "\(anime.status ?? "Unknown")")
                                MediaRow(title: "Duration", value: "\(anime.duration ?? "Unknown")")
                                MediaRow(title: "Rating", value: "\(anime.rating ?? "Unknown")")
                                MediaRow(title: "Genres", value: "\(anime.genres.compactMap({$0.name}).joined(separator: ", "))")
                                MediaRow(title: "Demographics", value: "\(anime.demographics.compactMap({$0.name}).joined(separator: ", "))")
                                MediaRow(title: "Producers", value: "\(anime.producers.compactMap({$0.name}).joined(separator: ", "))")
                                MediaRow(title: "Licensors", value: "\(anime.licensors.compactMap({$0.name}).joined(separator: ", "))")
                                MediaRow(title: "Studios", value: "\(anime.studios.compactMap({$0.name}).joined(separator: ", "))")
                            }
                            
                            Divider()
                            
                            Group {
                                Text("Synopsis: ")
                                    .font(.lovelo(30))
                                    .bold()
                                    .foregroundColor(.accentColor)
                                    .padding(.top, 20)
                                
                                Text(anime.synopsis ?? "No Synopsis Available")
                                    .font(.lovelo())
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                            }
                        
                        }
                        .padding()
                        
                        if !(anime.trailer.youtube_id?.isEmpty == true) {
                            Text("Trailer: ")
                                .font(.lovelo(30))
                                .bold()
                                .foregroundColor(.accentColor)
                                .padding(.top, 20)
                            
                            HStack(alignment: .center) {
                                VStack(alignment: .center) {
                                    if !(anime.trailer.youtube_id == nil) {
                                        YoutubeVideoView(videoID: anime.trailer.youtube_id!)
                                            .frame(width: 300, height: 150, alignment: .leading)
                                            .cornerRadius(15)
                                    } else {
                                        Image(systemName: "exclamationmark.triangle.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 300, height: 150, alignment: .center)
                                            .cornerRadius(15)
                                            .foregroundColor(Color.accentColor)
                                        
                                    }
                                }
                            }
                            .frame(width: 320, height: 170)
                            .overlay {
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(.black, lineWidth: 4)
                            }
                        }
                        
                        Button {
                            
                        } label: {
                            RateButton(isAnime: true)
                        }

                    }
                }
                .navigationBarBackButtonHidden()
            }
        }
    }
}


struct AnimeView_Previews: PreviewProvider {
    static var previews: some View {
        let anime = Anime(title: "One Piece",
                          episodes: 12,
                          status: "Finished Airing",
                          duration: "24 min. per ep.",
                          rating: "PG-13 - Teens 13 or older",
                          synopsis: "A story about a group of friends who discover a magical world.",
                          images: Images(jpg: ImageLink(image_url: "https://cdn.myanimelist.net/images/manga/2/253146l.jpg", small_image_url: nil, large_image_url: "https://cdn.myanimelist.net/images/manga/2/253146l.jpg"),
                                         webp: ImageLink(image_url: "https://example.com/image.webp", small_image_url: nil, large_image_url: nil)),
                          trailer: Trailer(youtube_id: "abcdef12345"),
                          score: 8.0,
                          genres: [Names(name: "Action"), Names(name: "Comedy")],
                          demographics: [Names(name: "Shounen")],
                          producers: [Names(name: "Studio X")],
                          licensors: [Names(name: "Funimation")],
                          studios: [Names(name: "Studio Y")])
        
        
        AnimeView(anime: anime)
    }
}
