//
//  ProfileView.swift
//  AnimeMangaStack
//
//  Created by Kaneis Zontanos on 4/22/23.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var profileVM = ProfileViewModel()
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
                            .overlay(Circle().stroke(Color.white, lineWidth: 5))
                            .padding(.top, 10)
                        
                        Text("@\(profileVM.email ?? "N/A: USER")")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color.white)
                            .padding(.bottom, 20)
                    }
                    
                    HStack(alignment: .top, spacing: 40) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Anime")
                                .font(.title2)
                                .bold()
                                .foregroundColor(Color.purple)
                                .padding(.bottom, 8)
                            MediaViewModel.infoBox(title: "Stats", color: Color.purple)
                            MediaViewModel.infoBox(title: "Recent", color: Color.purple)
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Manga")
                                .font(.title2)
                                .bold()
                                .foregroundColor(Color.purple)
                                .padding(.bottom, 8)
                            MediaViewModel.infoBox(title: "Stats", color: Color.purple)
                            MediaViewModel.infoBox(title: "Recent", color: Color.purple)
                        }
                    }
                    .padding([.horizontal, .bottom])
                    Spacer()
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
                }
                
                
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Button {
                            print("Anime")
                        } label: {
                            Text("Anime Random")
                                .foregroundColor(.white)
                                .padding(.all, 10)
                                .background(Color.purple.opacity(0.75))
                                .cornerRadius(10)
                        }
                        
                        Spacer()
                        
                        Button {
                            showAnimeView.toggle()
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        Button {
                            print("Manga")
                        } label: {
                            Text("Manga Random")
                                .foregroundColor(.white)
                                .padding(.all, 10)
                                .background(Color.purple.opacity(0.75))
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
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
    }
}







