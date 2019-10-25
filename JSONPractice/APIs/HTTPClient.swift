//
//  HTTPClient.swift
//  JSONPractice
//
//  Created by Jehad Sarkar on 2019-10-25.
//  Copyright © 2019 itsjehad. All rights reserved.
//

import Foundation


protocol URLSessionDataTaskProtocol {func resume()}
extension URLSessionDataTask: URLSessionDataTaskProtocol {}

protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func doDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    func doDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        //return dataTask(with: request) as URLSessionDataTaskProtocol//dataTask(with: completionHandler) as URLSessionDataTaskProtocol
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTaskProtocol
    }
}


class HTTPClient {
    typealias completeClosure = ( _ data: Data?, _ error: Error?)->Void
    private let session: URLSessionProtocol
    init(session: URLSession) {
        self.session = session
    }

    func get( url: URL, callback: @escaping completeClosure ) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.doDataTask(with: request) { (data, response, error) in
            callback(data, error)
        }
        task.resume()
    }
    
    func get( url: URL, httpBody: Data?, httpHeaders:[String: String]?, callback: @escaping completeClosure ) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.httpBody = httpBody
        request.allHTTPHeaderFields = httpHeaders
        let task = session.doDataTask(with: request) { (data, response, error) in
            callback(data, error)
        }
        task.resume()
    }
    
    func post( url: URL, callback: @escaping completeClosure ) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let task = session.doDataTask(with: request) { (data, response, error) in
            callback(data, error)
        }
        task.resume()
    }
    
    func post( url: URL, httpBody: Data?, httpHeaders:[String: String]?, callback: @escaping completeClosure ) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = httpBody
        request.allHTTPHeaderFields = httpHeaders
        let task = session.doDataTask(with: request) { (data, response, error) in
            callback(data, error)
        }
        task.resume()
    }

    func sendRequest(_ url: String, parameters: [String: String], completion: @escaping (ArticleList?, Error?) -> Void) {
        var components = URLComponents(string: url)!
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        let request = URLRequest(url: components.url!)
        
        let task = session.doDataTask(with: request) { data, response, error in //session.dataTask(with: request) { data, response, error in
            guard let data = data,                            // is there data
                let response = response as? HTTPURLResponse,  // is there HTTP response
                (200 ..< 300) ~= response.statusCode,         // is statusCode 2XX
                error == nil else {                           // was there no error, otherwise ...
                    completion(nil, error)
                    return
            }
            //let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            //print(json!)
            do {
                let decoder = JSONDecoder()
                let articles = try decoder.decode(ArticleList.self, from: data)
                completion(articles, nil)
            } catch let error {
                print(error.localizedDescription)
            }
            
        }
        task.resume()
    }
    
}
