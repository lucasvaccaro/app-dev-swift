//
//  IntermediaryModels.swift
//  Restaurant
//
//  Created by Aluno on 23/05/2018.
//  Copyright © 2018 Lucas. All rights reserved.
//

import Foundation

struct Categories: Codable {
    let categories: [String]
}

struct PreparationTime: Codable {
    let prepTime: Int
    
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}
