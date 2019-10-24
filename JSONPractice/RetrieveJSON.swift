//
//  RetrieveJSON.swift
//  JSONPractice
//
//  Created by Jehad Sarkar on 2019-10-24.
//  Copyright © 2019 itsjehad. All rights reserved.
//

import Foundation

struct RetrieveJSON {
    static func getResponse(_ request: URLRequest, _ callBack: (Articles) -> ())
    {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error:", error)
                return
            }
            guard let data = data else { return }
            let articles = try? JSONDecoder().decode(Articles.self, from: data)
            callBack(articles!)
        }
        task.resume()
    }
}
