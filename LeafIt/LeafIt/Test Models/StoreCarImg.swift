//
//  StoreCarImg.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 09/12/24.
//

import Foundation

class StoreCarImg: ObservableObject {
    @Published var img: [Img]
    
    let book = ["book1", "book2", "book3", "book1", "book2", "book3", "book1", "book2", "book3", "book1", "book2", "book3", "book1", "book2", "book3", "book1", "book2", "book3", "book1", "book2", "book3", "book1", "book2", "book3"]
    
    let progress = [85, 59, 21, 34, 63, 7, 48, 11, 75, 100, 92, 0, 85, 59, 21, 34, 63, 7, 48, 11, 75, 100, 92, 0]
    
    // dummy data
    init() {
        img = []
        for i in 0...23 {
            let new = Img(id: i, image: book[i], progress: progress[i])
            img.append(new)
        }
    }
}
