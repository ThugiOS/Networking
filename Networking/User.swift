//
//  User.swift
//  Networking
//
//  Created by Никитин Артем on 4.07.23.
//

import Foundation

struct UserResaults: Decodable {
    
    let results: [User]
    
    struct User: Decodable {
        var gender: String
        var name: Name
        var email: String
        var picture: Picture
        
        struct Name: Decodable {
            var title: String
            var first: String
            var last: String
        }
        
        struct Picture: Decodable {
            var large: String
        }
    }
}
