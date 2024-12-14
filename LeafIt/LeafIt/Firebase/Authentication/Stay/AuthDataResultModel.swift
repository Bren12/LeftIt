//
//  AuthDataResultModel.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 13/12/24.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    let isAnonymous: Bool
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
        self.isAnonymous = user.isAnonymous
    } // -> init
    
} // -> AuthDataResultModel
