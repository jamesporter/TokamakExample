import UIKit

fileprivate let apiUrl = URL(string: "https://s3-eu-west-1.amazonaws.com/complex-view-app-updates/api.json")!

struct Update : Codable, Equatable {
    let title: String
    let short: String
    let uri: String
    let date: String
    let link: String?
    let linkName: String?
    let categories: [String]
    let platforms: [String]
    let time: Int64
}

enum APIData {
    case notAsked
    case loading
    case loaded(data: [Update])
    case error(message: String)
}

enum API {
    static func refreshData(_ callback: @escaping (APIData) -> Void) {
        callback(.loading)
        let task = URLSession.shared.dataTask(with: apiUrl) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let updates = try decoder.decode([Update].self, from: data)
                    DispatchQueue.main.async {
                        callback(.loaded(data: updates))
                    }
                }  catch let error as NSError {
                    DispatchQueue.main.async { callback(.error(message: error.localizedDescription)) }
                }
            } else if let error = error {
                DispatchQueue.main.async { callback(.error(message: error.localizedDescription)) }
            }
        }
        task.resume()
    }
}
