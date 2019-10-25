//
//  QueryParams.swift
//  JSONPractice
//
//  Created by A M Jehad on 10/24/19.
//  Copyright © 2019 itsjehad. All rights reserved.
//

import Foundation

struct QueryParams: Encodable, Decodable{
    let country: String
    let category: String
    let apiKey: String
    init(_ country: String, _ category: String, _ apiKey: String = "02c948103b6a48229e7bd938e2bfab00") {
        self.country = country
        self.category = category
        self.apiKey = apiKey
    }
}
