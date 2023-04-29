//
//  RateButton.swift
//  AnimeMangaStack
//  Created by Kaneis Zontanos on 4/28/23.
//

import SwiftUI

struct RateButton: View {
    var isAnime: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 15, height: 15)
                .foregroundColor(.accentColor)
            Text(isAnime ? "Rate Anime" : "Rate Manga")
                .font(.lovelo())
                .fontWeight(.medium)
                .foregroundColor(.accentColor)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(Color("launchScreenColor"))
        .cornerRadius(20)
    }
    
}

