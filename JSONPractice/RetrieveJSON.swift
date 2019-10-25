//
//  RetrieveJSON.swift
//  JSONPractice
//
//  Created by Jehad Sarkar on 2019-10-24.
//  Copyright © 2019 itsjehad. All rights reserved.
//

import Foundation

struct RetrieveJSON {
    
    static func getResponse(_ url: URL, _ callBack: @escaping  (ArticleList) -> ())
    {
        let session = URLSession.shared
        let httpClient = HTTPClient(session: session)
        /*
        httpClient.get(url: url) { (data, response) in
            guard let data = data else { return }
            let articles = try? JSONDecoder().decode(Articles.self, from: data)
            callBack(articles!)
        }
 */
    }
    
}
