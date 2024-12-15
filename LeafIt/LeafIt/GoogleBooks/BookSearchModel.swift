//
//  BookSearchModel.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 14/12/24.
//

import Foundation

class BookSearchModel: ObservableObject {
    
    @Published var searchQuery: String = ""
    @Published var errorMessage: String = ""
    @Published var books = [Book]()
    @Published var showBookDisplayView = false
    @Published var isLoading = false
    private var startIndex = 0
    
    func searchBook() {
        
        guard !searchQuery.isEmpty else { return }
        
        print("searching")
        
        var url = URL(string: bookURL)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "q", value: searchQuery),
            URLQueryItem(name: "startIndex", value: "\(startIndex)"),
            URLQueryItem(name: "maxResults", value: "18"),
//            URLQueryItem(name: "key", value: apiKey)
        ]
        url.append(queryItems: queryItems)
        
        isLoading = true
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            print("searching 2")
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.isLoading = false
                } // -> DispatchQueue
                print("search failed")
                return
            } // -> guard
            
            do {
                
                let decoder = JSONDecoder()
                let searchResponse = try decoder.decode(BookSearchResponse.self, from: data)
                
                DispatchQueue.main.async {
                    if self.startIndex == 0 {
                        self.books = searchResponse.items ?? []
                    } else {
                        self.books.append(contentsOf: searchResponse.items ?? [])
                    } // -> if-else
                    self.showBookDisplayView.toggle()
                    self.isLoading = false
                    print("search succesful")
                } // -> DispatchQueue
                
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
        startIndex += 18
        searchBook()
    } // -> loadMoreBooks
    
} // -> BookSearchModel
