//
//  PokeAPI.swift
//  iOS Bootcamp Challenge
//
//  Created by Jorge Benavides on 26/09/21.
//

import Foundation

typealias JSON = [String: Any]

class PokeAPI {

    static let shared = PokeAPI()
    static let baseURL = "https://pokeapi.co/api/v2/"

    @discardableResult
    func get(url: String, onCompletion: @escaping(JSON?, Error?) -> Void) -> URLSessionDataTask? {
        let path = url.replacingOccurrences(of: PokeAPI.baseURL, with: "")
        let task = URLSession.mock.dataTask(with: PokeAPI.baseURL + path, completionHandler: { data, _, error in
            guard let data = data else {
                onCompletion(nil, error)
                return
            }
            do {
                let dic = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                onCompletion(dic, error)
            } catch {
                onCompletion(nil, error)
            }
        })
        task?.resume()
        return task
    }
}

extension JSON {
    var data: Data? {
        try? JSONSerialization.data(withJSONObject: self, options: .fragmentsAllowed)
    }
}
