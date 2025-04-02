//
//  DBList.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 02/04/25.
//

import Foundation
import SwiftData

@Model
class DBList: Identifiable {
    var listId: UUID = UUID()
    var name: String
    var dateCreated: Date

    init(
        name: String,
        dateCreated: Date
    ) {
        self.name = name
        self.dateCreated = dateCreated
    } // -> inist
} // -> DBList
