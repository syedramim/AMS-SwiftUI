//
//  MangaView.swift
//  AnimeMangaStack
//
//  Created by Kaneis Zontanos on 4/26/23.
//

import SwiftUI

struct MangaSearchView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var mangaVM = APIViewModel(isAnime: false)
    @State private var searchText = ""
    @State private var isAnime = false
    @State private var selectedManga: Manga?
    @Binding var isAnimeView: Bool
    
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
                    
                    TextField("Search Manga", text: $searchText, onCommit: {
                        Task {
                            await mangaVM.searchData(searchText: searchText)
                        }
                    })
                    .font(.lovelo(20))
                    .padding(.all, 10)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)

                    
                    ScrollView {
                        LazyVStack {
                            ForEach(mangaVM.mangaArray) { manga in
                                if (manga.rating?.contains("Hentai") == true) || (manga.images.jpg.large_image_url?.contains("apple-touch-icon") == true) {}
                                else {
                                    MediaViewModel.mediaCard(text: manga.title ?? "Not Found",
                                                             imageURL: manga.images.jpg.large_image_url ?? "",
                                                             synopsis: manga.synopsis ?? "more...",
                                                             genres: manga.genres.map { $0.name ?? "more..." }.joined(separator: ", "),
                                                             demographics: manga.demographics.map { $0.name ?? "more..." }.joined(separator: ", "))
                                        .padding(.bottom, 8)
                                        .onTapGesture {
                                            selectedManga = manga
                                        }
                                }
                            }
                        }
                        .padding([.horizontal, .bottom])
                    }

                }
            }
            .sheet(item: $selectedManga) { manga in
               MangaView(manga: manga)
            }
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.red.opacity(0.25))
                        .frame(width: 100, height: 40)
                        .overlay(alignment: .center) {
                            Toggle(isOn: $isAnime) {
                                HStack {
                                    Text("Manga")
                                    Image(systemName: "magnifyingglass")
                                        .resizable()
                                        .frame(width: 15, height: 15)
                                        .scaledToFit()
                                }
                                
                            }
                            .tint(.accentColor)
                            .toggleStyle(.automatic)
                            .onChange(of: isAnime) { i in
                                isAnimeView = i
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

struct MangaSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MangaSearchView(isAnimeView: .constant(false))
    }
}
