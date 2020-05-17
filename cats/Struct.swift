//
//  Struct.swift
//  cats
//
//  Created by Olena on 12.05.2020.
//  Copyright © 2020 Elena Draguzya. All rights reserved.
//

import Foundation

struct Breeds: Codable {
    var name: String?
    var id: String?
    var description: String?
    var origin: String?
    var life_span: String?
    
    enum CodingKeys: CodingKey {
        case name
        case id
        case description
        case origin
        case life_span
    }
}

struct Image: Codable {
    let url: String?
}
