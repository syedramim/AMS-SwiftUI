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
    
    @State private var showAnimeView = false
    @State private var showMangaView = false
    @State private var showLoginView = false
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("launchScreenColor"), Color.black]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                
                VStack {
                    VStack {
                        Image("launchscreen")
                            .resizable()
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
                    
                    ForEach(profileVM.profile.mangasRead ?? [], id: \.manga.id) { userManga in
                        Text(userManga.manga.title ?? "Not Found")
                            .font(.lovelo())
                            .foregroundColor(.accentColor)
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
                    HStack {
                        Button {
                            print("Anime")
                        } label: {
                            Text("Anime Random")
                                .padding(.all, 10)
                                .background(Color.purple.opacity(0.75))
                                .cornerRadius(10)
                        }
                        
                        Spacer()
                        
                        Button {
                            showAnimeView.toggle()
                        } label: {
                            Image(systemName: "magnifyingglass")
                        }
                        
                        Spacer()
                        
                        Button {
                            print("Manga")
                        } label: {
                            Text("Manga Random")
                                .padding(.all, 10)
                                .background(Color.purple.opacity(0.75))
                                .cornerRadius(10)
                        }
                    }
                    .font(.lovelo())
                    .padding(.horizontal)
                    .minimumScaleFactor(0.5)
                    .tint(.accentColor)
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
        
    }
    
}

    

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(ProfileViewModel())
    }
}







