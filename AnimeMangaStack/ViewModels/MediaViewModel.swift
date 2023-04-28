//
//  MediaViewModel.swift
//  AnimeMangaStack
//
//  Created by Kaneis Zontanos on 4/27/23.
//

import Foundation
import SwiftUI

struct MediaViewModel {
    static func mediaCard(text: String, imageURL: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(text)
                .font(.lovelo())
                .bold()
                .foregroundColor(Color.purple)
                .padding()
            
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.gray.opacity(0.2))
                .frame(height: 150)
                .overlay(
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 150)
                                .overlay {
                                    getImage(imageURL: imageURL)
                                        .frame(width: 150, height: 150)
                                        .aspectRatio(contentMode: .fill)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                    
                                }
                            Spacer()
                        }
                    }
                )
        }
    }
    
    static func getImage(imageURL: String) -> some View {
        AsyncImage(url: URL(string: imageURL)) { asyncImagePhase in
            if let image = asyncImagePhase.image {
                image
                    .resizable()
            } else if asyncImagePhase.error != nil {
                Image(systemName: "questionmark.square.dashed")
                    .resizable()
            } else {
                ProgressView()
                    .scaleEffect(4)
            }
            
        }
    }
}
