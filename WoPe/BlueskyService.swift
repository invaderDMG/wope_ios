import Foundation

class BlueskyService {
    private let username = Bundle.main.object(forInfoDictionaryKey: "username") as? String ?? ""
    private let password = Bundle.main.object(forInfoDictionaryKey: "password") as? String ?? ""
    
    private var jwtToken: String?

    func post(text: String, completion: @escaping (Result<String, Error>) -> Void) {
        login { result in
            switch result {
            case .success(let token):
                self.jwtToken = token
                self.createPost(text: text, token: token, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func login(completion: @escaping (Result<String, Error>) -> Void) {
        let url = URL(string: "https://bsky.social/xrpc/com.atproto.server.createSession")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let body = [
            "identifier": username,
            "password": password
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let token = json["accessJwt"] as? String else {
                completion(.failure(NSError(domain: "AuthError", code: 0)))
                return
            }

            completion(.success(token))
        }.resume()
    }

    private func createPost(text: String, token: String, completion: @escaping (Result<String, Error>) -> Void) {
        let url = URL(string: "https://bsky.social/xrpc/com.atproto.repo.createRecord")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let now = ISO8601DateFormatter().string(from: Date())
        
        let record: [String: Any] = [
            "repo": username,
            "collection": "app.bsky.feed.post",
            "record": [
                "text": text,
                "createdAt": now,
                "$type": "app.bsky.feed.post"
            ]
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: record)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                completion(.success("¡Publicado correctamente!"))
            } else {
                completion(.failure(NSError(domain: "PostError", code: 0)))
            }
        }.resume()
    }
}
