//
//  NewsAPI.swift
//  JSONPractice
//
//  Created by Jehad Sarkar on 2019-10-24.
//  Copyright © 2019 itsjehad. All rights reserved.
//

import Foundation

struct NewsAPI {
    static func getJsonQueryParams(_ queryParams: QueryParams) throws -> Data?{
        let jsonEncoder = JSONEncoder()
        let jsonData = try jsonEncoder.encode(queryParams)
        return jsonData
        
    }
    static func newsListAPI(_ queryParams: QueryParams) -> URLRequest{
        let url = URL(string: "https://newsapi.org/v2/top-headlines")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? getJsonQueryParams(queryParams)
        return request
    }
}