//
//  NetworkServiceImpl.swift
//  SwiftMVVMStartupProject
//
//  Created by Mahmoud Ibaraheim on 6/14/20.
//  Copyright © 2020 MahmoudOrganization. All rights reserved.
//

import Foundation
import Promises
import SwiftyJSON
import Reachability

protocol EndpointExecuter {
    func execute(_ endpoint: Endpoint) -> Promise<NetworkServiceResponse>
    func uploadMultipart(_ endpoint: Endpoint) -> Promise<NetworkServiceResponse>
}

protocol ReachabilityProtocol {
    func connection() -> Reachability.Connection?
}

class NetworkServiceImpl: NetworkService {
    
    var endpointExecuter: EndpointExecuter = AlamofireService()
    var reachability: ReachabilityProtocol = ReachabilityImpl()
    
    func callModel<Model: Codable>(_ model: Model.Type, endpoint: Endpoint) -> Promise<Model> {
        return Promise<Model>(on: .main) { fulfill, reject in
            self.call(endpoint: endpoint)
                .then({ (data) in
                    do {
                    //  print("Response Data 🤪🤪🤪🤪  \(JSON(data))")
                        let obj = try JSONDecoder().decode(Model.self, from: data)
                        fulfill(obj)
                    } catch let jsonError {
                        print(jsonError)
                        print("JsonSerlization Error 😱😱😱😱😱 \(jsonError.localizedDescription)")
                        reject(FailToMapResponseError(data: data))
                    }
                })
                .catch({ (error) in
                    reject(error) })
        }
    }
    
    func uploadModel<Model: Codable>(_ model: Model.Type, endpoint: Endpoint) -> Promise<Model> {
        return Promise<Model>(on: .main) { fulfill, reject in
            self.upload(endpoint: endpoint)
                .then({ (data) in
                    guard let response = try? JSONDecoder().decode(Model.self, from: data) else {
                        reject(FailToMapResponseError(data: data))
                        return
                    }
                    print("🎉🎉 After Codable : \(response)")
                    fulfill(response)})
                .catch({ (error) in
                    reject(error) })
        }
    }
    
    func call(endpoint: Endpoint) -> Promise<Data> {
        return Promise<Data>(on: .main) { fulfill, reject in
            self.endpointExecuter.execute(endpoint)
                .then({ (response) in
                    self.networkSuccess(data: response.data, statusCode: response.statusCode).then({ (data) in
                        let header = response.headers as? [String: Any]
                        let jsonData = try JSONSerialization.data(withJSONObject: header, options: [])
                        let decoder = JSONDecoder()
                        let headerResponse = try decoder.decode(HeaderResponse.self, from: jsonData)
                       
                        fulfill(data)
                    }).catch({ (error) in
                        reject(error)
                    })
                }).catch({ (_) in
                    reject(self.networkFail())
                })
        }
    }
    
    private func upload(endpoint: Endpoint) -> Promise<Data> {
        return Promise<Data>(on: .main) { fulfill, reject in
            self.endpointExecuter.uploadMultipart(endpoint)
                .then({ (response) in
                    self.networkSuccess(data: response.data, statusCode: response.statusCode).then({ (data) in
                        fulfill(data)
                    }).catch({ (error) in
                        reject(error)
                    })
                }).catch({ _ in
                    reject(self.networkFail())
                })
        }
    }
    //
    private func networkSuccess(data: Data, statusCode: Int?) -> Promise<Data> {
        return Promise<Data>(on: .main) { fulfill, reject in
            print("⬆️⬆️ Status Code : \(String(describing: statusCode ?? 0))")
            print("⬆️⬆️ Endpoint Respose : \(JSON(data))")
            
            if (200...299).contains(statusCode ?? 0) {
                fulfill(data)
            } else {
                guard let error = try? JSONDecoder().decode(ServerError.self, from: data) else {
                    reject(ServerError())
                    return
                }
                reject(error)
            }
        }
    }
    
    private func saveHeaders( _ header: HeaderResponse) {
        }
    private func networkFail() -> Error {
        return isConnectedToInternet ? FailToCallNetworkError() : NoInternetConnectionError()
    }
    
    private var isConnectedToInternet: Bool {
        return reachability.connection() != Reachability.Connection.none
    }
    
    private func mapJsonToModel<Model: Codable>(_ model: Model.Type, from data: Data) -> Promise<Model>{
        return Promise<Model>(on: .main) { fulfill, reject in
            guard let response = try? JSONDecoder().decode(Model.self, from: data) else {
                return  reject(FailToMapResponseError(data: data))
            }
            return fulfill(response)
        }
    }
    
}

struct NetworkServiceResponse {
    var data: Data
    var statusCode: Int?
    var headers: [AnyHashable: Any]?
}

class ReachabilityImpl: ReachabilityProtocol {
    
    func connection() -> Reachability.Connection? {
        return Reachability()?.connection
    }
}

struct HeaderResponse: Codable {
    var token: String?
    var client: String?
    var uid: String?
    
    enum CodingKeys: String, CodingKey {
        case token = "access-token"
        case client, uid
    }
}
