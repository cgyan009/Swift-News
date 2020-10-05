//
//  NewsApi.swift
//  Swift News
//
//  Created by Chenguo Yan on 2020-10-04.
//

import Foundation

fileprivate typealias dictionary = [String : Any]

class API {
    
    static let shared = API()
    private init() {}
    
    enum ApiError: Error {
        case serviceError
        case decodeError
        case jsonSerializationError
        case urlError
        case dataError
    }
    
    private enum Constants {
        static let urlString = "https://www.reddit.com/r/swift/.json"
        static let httpGetMethod = "GET"
    }
    
    private func parse(
        request: URLRequest,
        completion: @escaping (Result<dictionary, Error>) -> Void
    ) {
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(ApiError.serviceError))
                return
            }
            guard let data = data, error == nil else {
                completion(.failure(ApiError.dataError))
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? dictionary else {
                    completion(.failure(ApiError.jsonSerializationError))
                    return
                }
                completion(.success(json))
            } catch let error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchData<T: Decodable>(completionHandler: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: Constants.urlString) else {
            print(ApiError.urlError)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = Constants.httpGetMethod
        parse(request: request) { (result) in
            switch result {
            case .success(let dict):
                do {
                    let data = try JSONSerialization.data(withJSONObject: dict, options: [.prettyPrinted])
                    let model = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(.success(model))
                } catch {
                    completionHandler(.failure(ApiError.decodeError))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}

