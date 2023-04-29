//
//  ProfileView.swift
//  AnimeMangaStack
//
//  Created by Kaneis Zontanos on 4/22/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift


struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var profileVM: ProfileViewModel
    @FirestoreQuery(collectionPath: "profiles") var profiles: [Profile]
    
    @State private var selectedManga: Manga?
    @State private var selectedAnime: Anime?
    @State private var showAnimeView = false
    @State private var showMangaView = false
    @State private var showLoginView = false
    @State private var showAnimePage = false
    @State private var showMangaPage = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("launchScreenColor"), Color.black]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                
                VStack {
                    VStack {
                        MediaViewModel.getImage(imageURL: profileVM.links.randomElement() ?? "https://upload.wikimedia.org/wikipedia/commons/d/d1/Image_not_available.png")
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.accentColor, lineWidth: 5))
                            .padding(.top, 10)
                        
                        Text("@\(profileVM.email ?? "N/A: USER")")
                            .font(.lovelo())
                            .bold()
                            .foregroundColor(Color.accentColor)
                            .padding(.bottom, 20)
                    }
                    .minimumScaleFactor(0.5)
                    
                    Spacer()
                    
                    ScrollView {
                        VStack {
                            Spacer()
                            
                            Text("Watched Animes")
                                .font(.lovelo())
                                .bold()
                                .foregroundColor(.accentColor)
                                .padding(.bottom, 20)
                            
                            ForEach(profileVM.profile.animesWatched, id: \.id) { watched in
                                let anime = watched.anime
                                MediaViewModel.mediaCard(text: anime.title ?? "Not Found",
                                                         imageURL: anime.images.jpg.large_image_url ?? "",
                                                         synopsis: anime.synopsis ?? "more...",
                                                         genres: anime.genres.map { $0.name ?? "more..." }.joined(separator: ", "),
                                                         demographics: anime.demographics.map { $0.name ?? "more..." }.joined(separator: ", "))
                                .onTapGesture {
                                    showAnimePage.toggle()
                                    selectedAnime = anime
                                }
                                Spacer()
                            }
                            
                            Spacer()
                            
                            Text("Read Mangas")
                                .font(.lovelo())
                                .bold()
                                .foregroundColor(.accentColor)
                                .padding(.bottom, 20)
                            
                            Spacer()
                            
                            ForEach(profileVM.profile.mangasRead, id: \.id) { read in
                                let manga = read.manga
                                MediaViewModel.mediaCard(text: manga.title ?? "Not Found",
                                                         imageURL: manga.images.jpg.large_image_url ?? "",
                                                         synopsis: manga.synopsis ?? "more...",
                                                         genres: manga.genres.map { $0.name ?? "more..." }.joined(separator: ", "),
                                                         demographics: manga.demographics.map { $0.name ?? "more..." }.joined(separator: ", "))
                                .onTapGesture {
                                    showMangaPage.toggle()
                                    selectedManga = manga
                                }
                                
                            }
                        }
                        
                    }
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Sign Out") {
                        do {
                            try Auth.auth().signOut()
                            showLoginView.toggle()
                        } catch {
                            print("ERROR: Signing Out")
                        }
                    }
                    .foregroundColor(.accentColor)
                    .font(.lovelo())
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        showAnimeView.toggle()
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                    .font(.lovelo())
                    .padding(.horizontal)
                    .minimumScaleFactor(0.5)
                    .tint(.accentColor)
                    .buttonStyle(.borderedProminent)
                }
            }
            
        }
        .fullScreenCover(isPresented: $showAnimeView) {
            AnimeSearchView(isMangaView: $showMangaView)
        }
        .fullScreenCover(isPresented: $showMangaView) {
            MangaSearchView(isAnimeView: $showAnimeView)
        }
        .fullScreenCover(isPresented: $showLoginView) {
            LoginView()
        }
        .sheet(item: $selectedAnime) { anime in
            AnimeView(anime: anime)
        }
        .sheet(item: $selectedManga) { manga in
            MangaView(manga: manga)
        }
    }
    
}




struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(ProfileViewModel())
    }
}







