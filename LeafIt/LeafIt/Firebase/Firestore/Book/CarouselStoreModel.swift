//
//  StoreCarImg.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 09/12/24.
//

import Foundation

class CarouselStoreModel: ObservableObject {
    
    @Published var books: [CarouselStore]
    
    init() {
        self.books = []
    } // -> init
    
    init(bookList: [DBBook]) {
        var auxList: [CarouselStore] = []
        for i in 0...(bookList.count-1) {
            let new = CarouselStore(id: i, book: bookList[i])
            auxList.append(new)
        } // -> for
        self.books = auxList
    } // -> setBooks
    
} // -> CarouselStoreModel
