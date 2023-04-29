//
//  AnimeViewModel.swift
//  AnimeMangaStack
//  Created by Kaneis Zontanos on 4/22/23.
//

import Foundation

@MainActor
class APIViewModel: ObservableObject {
    var isAnime: Bool
    init(isAnime: Bool) {
        self.isAnime = isAnime
    }

    private struct AnimeReturned: Codable {
        var pagination: Pagination
        var data: [Anime] = []
    }
    
    private struct MangaReturned: Codable {
        var pagination: Pagination
        var data: [Manga] = []
    }
    
    struct Pagination: Codable {
        var has_next_page: Bool
    }
    
    @Published var animeArray: [Anime] = []
    @Published var mangaArray: [Manga] = []
    @Published var isLoading = false
    
    private var currentPage = 1
    private var currentSearchText = ""
    
    func searchData(searchText: String) async {
        let encodedSearchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        currentSearchText = encodedSearchText
        if isAnime {
            animeArray = []
        } else {
            mangaArray = []
        }
        currentPage = 1
        await fetchPage(searchText: encodedSearchText)
    }
    
    func fetchNextPage() async {
        guard !isLoading else { return }
        currentPage += 1
        await fetchPage(searchText: currentSearchText)
    }
    
    private func fetchPage(searchText: String) async {
        let searchType = isAnime ? "anime" : "manga"
        let urlString = "https://api.jikan.moe/v4/\(searchType)?q=\(searchText)&page=\(currentPage)"
        print("🕸 We are accessing the url \(urlString)")
        isLoading = true
        
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not create a URL from \(urlString)")
            isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if isAnime {
                guard let returned = try? JSONDecoder().decode(AnimeReturned.self, from: data) else {
                    print("😡 JSON ERROR: Could not decode returned JSON data")
                    isLoading = false
                    return
                }
                self.animeArray += returned.data
                if returned.pagination.has_next_page && searchText == currentSearchText {
                    await fetchNextPage()
                }

            } else {
                guard let returned = try? JSONDecoder().decode(MangaReturned.self, from: data) else {
                    print("😡 JSON ERROR: Could not decode returned JSON data")
                    isLoading = false
                    return
                }
                self.mangaArray += returned.data
                if returned.pagination.has_next_page && searchText == currentSearchText {
                    await fetchNextPage()
                }
            }
        } catch {
            print("😡 ERROR: Could not use URL at \(urlString) to get data and response")
            isLoading = false
        }
    }
}




