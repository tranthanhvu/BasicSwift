//: Playground - noun: a place where people can play

import Foundation


// https://developer.apple.com/swift/blog/?id=37

// MARK: - Prepare
let jsonString = "{\"name\" = \"Vu\", \"age\": 26}"

// MARK: - Extracting value from JSON
let data: Data = jsonString.data(using: String.Encoding.utf8)! // received from a network request
do {
    let json = try JSONSerialization.jsonObject(with: data, options: [])
    
    if let dict = json as? [String: Any] {
        let name = dict["name"] as? String
        let age = dict["age"] as? Int
    }
} catch let error {
    print(error.localizedDescription)
}


