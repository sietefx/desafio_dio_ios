import Foundation

protocol GlobalStoreProtocol: GenericStoreProtocol {
    func fetchGlobal(completion: @escaping completion<GlobalModel?>)
}

class GlobalStore: GlobalStoreRequest, GlobalStoreProtocol {
    func fetchGlobal(completion: @escaping completion<GlobalModel?>) {
        do {
            let request = try GlobalRouter.global.asURLRequest()
            self.request(urlRequest: request, completion: completion)
        } catch {
            completion(nil, error)
        }
    }
}
