//
//  Show.swift
//  ingresseTest
//
//  Created by Matheus Queiroz on 5/10/18.
//  Copyright © 2018 mattcbr. All rights reserved.
//

import Foundation

struct Show {
    
    let name: String
    let genre: [String]
    let description: String
    let premiereDay: String
    let thumbnailPath: String
    
    init(name: String, genre: [String], desc: String, premiereDay: String, thumbPath: String) {
        self.name = name
        self.genre = genre
        self.description = desc
        self.premiereDay = premiereDay
        self.thumbnailPath = thumbPath
    }
}
