//
//  ContentView.swift
//  AnimeMangaStack
//
//  Created by Kaneis Zontanos on 4/22/23.
//

import SwiftUI

struct AnimeSearchView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var animeVM = APIViewModel(isAnime: true)
    @State private var searchText = ""
    @State private var isManga = false
    @State private var selectedAnime: Anime?
    @Binding var isMangaView: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("launchScreenColor"), Color.black]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                VStack {
                    Text("AMS")
                        .font(.lovelo(50))
                        .bold()
                        .foregroundColor(.accentColor)
                        .padding(.top, 20)
                    
                    TextField("Search Anime", text: $searchText, onCommit: {
                        Task {
                            await animeVM.searchData(searchText: searchText)
                        }
                    })
                    .font(.lovelo(20))
                    .padding(.all, 10)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)

                    
                    ScrollView {
                        LazyVStack {
                            ForEach(animeVM.animeArray) { anime in
                                if (anime.rating?.contains("Hentai") == true) || (anime.images.jpg.large_image_url?.contains("apple-touch-icon") == true) {}
                                else {
                                    MediaViewModel.mediaCard(text: anime.title ?? "Not Found", imageURL: anime.images.jpg.large_image_url ?? "")
                                        .padding(.bottom, 8)
                                        .onTapGesture {
                                            selectedAnime = anime
                                        }
                                }

                                
                            }
                        }
                        .padding([.horizontal, .bottom])
                    }

                }
            }
            .sheet(item: $selectedAnime) { anime in
               AnimeView(anime: anime)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.green.opacity(0.25))
                        .frame(width: 100, height: 40)
                        .overlay(alignment: .center) {
                            Toggle(isOn: $isManga) {
                                HStack {
                                    Text("Anime")
                                    Image(systemName: "magnifyingglass")
                                        .resizable()
                                        .frame(width: 15, height: 15)
                                        .scaledToFit()
                                }
                            }
                            .tint(.accentColor)
                            .toggleStyle(.automatic)
                            .onChange(of: isManga) { i in
                                isMangaView = i
                                dismiss()
                            }
                        }
                }
                
                ToolbarItem(placement: .status) {
                    LoadProfile()
                }
            }

        }

    }
}

struct AnimeSearchView_Previews: PreviewProvider {
    static var previews: some View {
        AnimeSearchView(isMangaView: .constant(false))
    }
}

