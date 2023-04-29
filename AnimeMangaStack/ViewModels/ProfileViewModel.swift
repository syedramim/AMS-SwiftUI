//
//  ProfileViewModel.swift
//  AnimeMangaStack
//  Created by Kaneis Zontanos on 4/24/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage
import UIKit

enum ProfileError: Error {
    case profileWasNil
}

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var profile = Profile()
    @Published var email = Auth.auth().currentUser?.email?.replacingOccurrences(of: "@.*", with: "", options: .regularExpression)
    @Published var links: [String] = []
    
    private var db = Firestore.firestore()
    
    init() {
        Task {
            await fetchProfile()
        }
    }
    
    func fetchProfile() async {
        guard let userEmail = self.email else {
            print("Error: No user is logged in.")
            return
        }
        do {
            let querySnapshot = try await db.collection("profiles").whereField("email", isEqualTo: userEmail).getDocuments()
            if let document = querySnapshot.documents.first {
                self.profile = try document.data(as: Profile.self)
                self.profile.animesWatched.forEach { anime in
                    self.links.append(anime.anime.images.jpg.large_image_url ?? "launchscreen")
                }
                self.profile.mangasRead.forEach { manga in
                    self.links.append(manga.manga.images.jpg.large_image_url ?? "launchscreen")
                }
            }
        } catch {
            print("Error fetching profile: \(error)")
        }
    }
    
    func saveProfile() async -> String? {
        let db = Firestore.firestore()
        profile.email = self.email
        if let id = profile.id {
            do {
                print("Profile dictionary: \(profile.dictionary)")
                try await db.collection("profiles").document(id).setData(profile.dictionary)
                print("😎 Data updated successfully!")
                return profile.id
            } catch {
                print("😡 ERROR: Could not update data in 'profiles' \(error.localizedDescription)")
                return nil
            }
        } else {
            do {
                print("Profile dictionary: \(profile.dictionary)")
                let docRef = try await db.collection("profiles").addDocument(data: profile.dictionary)
                print("🐣 Data added successfully!")
                return docRef.documentID
            } catch {
                print("😡 ERROR: Could not create a new profile in 'profiles' \(error.localizedDescription)")
                return nil
            }
        }
    }
    
    
    func addAnimeToProfile(newAnime: userAnime) async -> String? {
        if profile.id == nil {
            _ = await saveProfile()
        }
        if profile.animesWatched == nil {
            profile.animesWatched = [newAnime]
        } else {
            profile.animesWatched.append(newAnime)
        }
        return await saveProfile()
    }
    
    func addMangaToProfile(newManga: userManga) async -> String? {
        if profile.id == nil {
            _ = await saveProfile()
        }
        if profile.mangasRead == nil {
            profile.mangasRead = [newManga]
        } else {
            profile.mangasRead.append(newManga)
        }
        return await saveProfile()
    }
    
    
    func addAnimeToProfile(anime: Anime, status: RateOptions, score: Int, watchedEpisodes: Int) async throws {
        let newAnime = userAnime(anime: anime, status: status, score: score, watchedEpisodes: watchedEpisodes)
        _ = try await addAnimeToProfile(newAnime: newAnime)
    }
    
    func addMangaToProfile(manga: Manga, status: RateOptions, score: Int, readChapters: Int, readVolumes: Int) async throws {
        let newManga = userManga(manga: manga, status: status, score: score, readChapters: readChapters, readVolumes: readVolumes)
        _ = try await addMangaToProfile(newManga: newManga)
    }
}




