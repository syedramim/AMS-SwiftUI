//
//  MediaRow.swift
//  AnimeMangaStack
//
//  Created by Kaneis Zontanos on 4/27/23.
//

import SwiftUI

struct MediaRow: View {
    var title: String
    var value: String

    var body: some View {
        HStack {
            Text("\(title):")
                .font(.lovelo())
                .bold()
                .foregroundColor(.accentColor)
            Spacer()
            Text(value.isEmpty ? "N/A" : value)
                .font(.lovelo())
                .foregroundColor(.accentColor)
        }
        .minimumScaleFactor(0.5)
        .lineLimit(3    )
        .padding(.vertical, 2)
        
    }
}

