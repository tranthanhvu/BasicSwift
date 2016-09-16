import Foundation

// MARK: - Creating Model Objects from values extracted from JSON
struct People {
    let name: String
    let age: Int
}

// MARK: - Writing an Optional JSON Initializer
extension People {
    init?(json: [String: Any]) {
        guard let name = json["name"] as? String else { return nil }
        guard let age = json["age"] as? Int else { return nil }
        
        self.name = name
        self.age = age
    }
}

// MARK: - Writing a JSON Initializer with Error Handling
//enum SerializationError: Error {
//    case missing(String)
//    case invalid(String, Any)
//}
//
//extension People {
//    init(json: [String: Any]) throws {
//        guard let name = json["name"] as? String else {
//            throw SerializationError.missing("name")
//        }
//        
//        guard let age = json["age"] as? Int else {
//            throw SerializationError.missing("age")
//        }
//        
//        self.name = name
//        self.age = age
//    }
//}

// MARK: - Writing a Type Method for Fetching Results
extension People {
    static var urlComponents: URLComponents = URLComponents() // base URL components of the web service
    static var session: URLSession = URLSession() // shared session for interacting with the web service
    
    static func people(matching query: String, completion: @escaping ([People]) -> Void) {
        var searchURLComponents: URLComponents = urlComponents
        
        searchURLComponents.path = "/Search"
        searchURLComponents.queryItems = [URLQueryItem(name: "q", value: query)]
        let searchURL = searchURLComponents.url!
        
        session.dataTask(with: searchURL) { (data, _, _) in
            var people = [People]()
            
            if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: [[String : Any]]] {
                
                if let result = json?["result"] {
                    for case let element in result {
                        
                        if let p = People(json: element) {
                            people.append(p)
                        }
                    }
                }
                
            }
            
            completion(people)
        }.resume()
        
    }
}
