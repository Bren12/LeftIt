//
//  RecentBooksModel.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 17/12/24.
//

import Foundation

class RecentBooksModel: ObservableObject {
    
    @Published var books = [Book]()
    @Published var isLoading = false
    
    init() {
        
        let currDate = Date()
        let calendar = Calendar.current
        let currYear = calendar.component(.year, from: currDate)
        
        var url = URL(string: bookURL)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "q", value: "*"),
            URLQueryItem(name: "categories", value: "Fiction"),
            URLQueryItem(name: "orderBy", value: "relevance"),
            URLQueryItem(name: "maxResults", value: "18"),
//            URLQueryItem(name: "key", value: apiKey)
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
                let searchResponse = try decoder.decode(BookSearchResponse.self, from: data)
                
                DispatchQueue.main.async {
                    self.books = searchResponse.items ?? []
                    self.isLoading = false
                } // -> DispatchQueue
                
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                } // -> DispatchQueue
                print("request failed \(error)")
            } // -> do-catch
            
        } // -> URLSession
        .resume()
    }
    
} // -> BookSearchModel
