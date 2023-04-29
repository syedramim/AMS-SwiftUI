//
//  MediaViewModel.swift
//  AnimeMangaStack
//
//  Created by Kaneis Zontanos on 4/27/23.
//

import Foundation
import SwiftUI

struct MediaViewModel {
    static func mediaCard(text: String, imageURL: String, synopsis: String, genres: String, demographics: String) -> some View {
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
                    VStack(alignment: .leading, spacing: 0) {
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
                            
                            VStack {
                                Spacer()
                                Text("Synopsis: \(synopsis)")
                                Spacer()
                                Text("Genres: \(genres)")
                                Spacer()
                                Text("Demographics: \(demographics)")
                                Spacer()
                            }
                            .font(.lovelo(15))
                            .foregroundColor(.accentColor)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                        }
                        .padding()
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
