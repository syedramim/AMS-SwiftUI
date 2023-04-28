//
//  ProfileViewModel.swift
//  AnimeMangaStack
//
//  Created by Kaneis Zontanos on 4/24/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage
import UIKit

class ProfileViewModel: ObservableObject {
    @Published var profile = Profile()
    @Published var email = Auth.auth().currentUser?.email?.replacingOccurrences(of: "@.*", with: "", options: .regularExpression)
    
    func saveProfile(profile: Profile) async -> String? {
        let db = Firestore.firestore()
        if let id = profile.id {
            do {
                try await db.collection("profiles").document(id).setData(profile.dictionary)
                print("😎 Data updated successfully!")
                return profile.id
            } catch {
                print("😡 ERROR: Could not update data in 'profiles' \(error.localizedDescription)")
                return nil
            }
        } else {
            do {
                let docRef = try await db.collection("profiles").addDocument(data: profile.dictionary)
                print("🐣 Data added successfully!")
                return docRef.documentID
            } catch {
                print("😡 ERROR: Could not create a new profile in 'profiles' \(error.localizedDescription)")
                return nil
            }
        }
    }
    
    func deleteData(profile: Profile) async {
        let db = Firestore.firestore()
        guard let id = profile.id else {
            print("😡 ERROR: id was nil. This should not have happened.")
            return
        }
        
        do {
            try await db.collection("profiles").document(id).delete()
            print("🗑️ Document successfully removed")
            return
        } catch {
            print("😡 ERROR: removing document \(error.localizedDescription).")
            return
        }
    }
}


