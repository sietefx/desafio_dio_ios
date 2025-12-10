import Foundation

protocol GenericStoreProtocol {
    var error: Error { get set }
    typealias completion<T> = (_ result: T, _ failure: Error?) -> Void
}

class GenericStoreRequest: GenericStoreProtocol {
    var error: Error = NSError(
        domain: "GenericStoreRequest",
        code: 901,
        userInfo: [NSLocalizedDescriptionKey: "Erro ao obter informações"]
    )

    func request<T: Codable>(urlRequest: URLRequest, completion: @escaping completion<T?>) {
        print("[REQUEST STARTED]")
        print("URL:", urlRequest.url?.absoluteString ?? "URL inválida")

        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                print("[NETWORK ERROR]:", error.localizedDescription)
                completion(nil, error)
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("[HTTP STATUS]:", httpResponse.statusCode)
            } else {
                print("[NO HTTP RESPONSE]")
            }

            guard let data else {
                print("[NO DATA RECEIVED]")
                completion(nil, self.error)
                return
            }

            if let jsonString = String(data: data, encoding: .utf8) {
                print("[RAW JSON PARTIAL]:")
                print(jsonString.prefix(500))
                print("--- END JSON PREVIEW ---")
            }

            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                print("[DECODE SUCCESS]:", T.self)
                completion(object, nil)
            } catch {
                print("[DECODE ERROR]:", error)
                completion(nil, error)
            }
        }

        task.resume()
    }
}
