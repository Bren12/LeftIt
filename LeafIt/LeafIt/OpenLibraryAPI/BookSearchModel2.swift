//
//  BookSearchModel.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 14/12/24.
//

import Foundation

class BookSearchModel2: ObservableObject {
    
    @Published var searchQuery: String = ""
    @Published var books = [Book2]()
    @Published var isLoading = false
    private var startIndex = 0
    private var lastIndex = 0
    
    func resetSearch() {
        self.books = []
    } // -> resetSearch
    
    func searchBook() {
        
        guard !searchQuery.isEmpty else { return }
        
        var url = URL(string: baseBookURL)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "q", value: searchQuery),
            URLQueryItem(name: "limit", value: "\(limitBookPerPage)"),
            URLQueryItem(name: "page", value: "\(startIndex)"),
        ]
        url.append(queryItems: queryItems)
        
        isLoading = true
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.isLoading = false
                } // -> DispatchQueue
                print("search failed")
                return
            } // -> guard
            
            do {
                
                let decoder = JSONDecoder()
                let searchResponse = try decoder.decode(BookSearchResponse2.self, from: data)
                
                if self.startIndex < self.lastIndex {
                    DispatchQueue.main.async {
                        if self.startIndex == 0 {
                            self.books = searchResponse.docs ?? []
                            self.lastIndex = searchResponse.num_found
                        } else {
                            self.books.append(contentsOf: searchResponse.docs ?? [])
                        } // -> if-else
                        self.isLoading = false
                    } // -> DispatchQueue
                } else {
                    self.isLoading = false
                } // -> if-else
                
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                } // -> DispatchQueue
                print("request failed \(error)")
            } // -> do-catch
            
        } // -> URLSession
        .resume()
        
    } // -> searchBook
    
    func loadMoreBooks() {
        print("Loading more book")
        startIndex += limitBookPerPage
        searchBook()
    } // -> loadMoreBooks
    
} // -> BookSearchModel
