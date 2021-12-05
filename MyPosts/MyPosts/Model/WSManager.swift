//
//  WSManager.swift
//  MyPosts
//

import Foundation


internal struct API {

    struct URL {
        static let BASEURL = "https://jsonplaceholder.typicode.com/"
    }

    struct Response {
        static let status = "status"
        static let code = "code"
    }

    struct RequestHeader {
        static let deviceUniqueId = "deviceUniqueId"
    }

    struct Request {
        static let data = "data"
    }
}


enum EndPoint: String, Path {
    case posts
}

/// 📣`Network Mange Web Service Request`
class WSManager {
    
    static let shared = WSManager()
  
    func getPosts(completion: @escaping (Result<[PostModel], Error>) -> ()){

        guard let url = URL(string: API.URL.BASEURL+EndPoint.posts.rawValue) else {return}

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if let err = err{
                completion(.failure(err))
            } else {
                if let data = data {
                    do{
                        let response = try JSONDecoder().decode([PostModel].self, from: data)
                        completion(.success(response))
                    } catch let jsonError{
                        completion(.failure(jsonError))
                    }
                }
            }
        }.resume()
    }
}
