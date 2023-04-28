//
//  YoutubeVideoView.swift
//  AnimeMangaStack
//
//  Created by Kaneis Zontanos on 4/28/23.
//

import SwiftUI
import WebKit

struct YoutubeVideoView: UIViewRepresentable {
    
    var videoID: String
    
    func makeUIView(context: Context) -> WKWebView  {
        
        WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
        let path = "https://www.youtube.com/embed/\(videoID)"
        guard let url = URL(string: path) else { return }
        
        uiView.scrollView.isScrollEnabled = false
        uiView.load(.init(url: url))
    }
}


