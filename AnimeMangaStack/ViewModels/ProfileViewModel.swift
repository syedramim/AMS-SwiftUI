//
//  ProfileViewModel.swift
//  AnimeMangaStack
//
//  Created by Kaneis Zontanos on 4/24/23.
//

import Foundation
import Firebase

class ProfileViewModel: ObservableObject {
    @Published var profile = Profile()
    @Published var email = Auth.auth().currentUser?.email?.replacingOccurrences(of: "@.*", with: "", options: .regularExpression)
    
//    @Published var profileImage: UIImage?
//
//    init(profileImage: UIImage? = nil) {
//        self.profileImage = profileImage
//    }
}
