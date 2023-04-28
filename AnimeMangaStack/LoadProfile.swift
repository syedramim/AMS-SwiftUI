//
//  LoadProfile.swift
//  AnimeMangaStack
//
//  Created by Kaneis Zontanos on 4/27/23.
//

import SwiftUI

struct LoadProfile: View {
    @State private var showProfile = false
    var body: some View {
        Image("launchscreen")
            .resizable()
            .frame(width: 60, height: 60)
            .scaledToFit()
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 2))
            .onTapGesture {
                showProfile.toggle()
            }
            .fullScreenCover(isPresented: $showProfile) {
                ProfileView()
            }
    }
}


