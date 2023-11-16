//
//  AlamofireService.swift
//  SwiftMVVMStartupProject
//
//  Created by Mahmoud Ibaraheim on 6/14/20.
//  Copyright © 2020 MahmoudOrganization. All rights reserved.
//

import Foundation
import Alamofire
import Promises

class AlamofireService: EndpointExecuter {
    
    private let manager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringCacheData
        return SessionManager(configuration: configuration)
    }()
    
    func execute(_ endpoint: Endpoint) -> Promise<NetworkServiceResponse> {
        return Promise<NetworkServiceResponse>(on: .global()) { fulfill, reject in
            self.request(by: endpoint)
                .responseData(completionHandler: { (response) in
                    switch response.result {
                    case .success(let data):
                        print("🎉 Enter In Success")
                        fulfill(NetworkServiceResponse(data: data,
                                                       statusCode: response.response?.statusCode,
                                                       headers: response.response?.allHeaderFields))
                    case .failure(let error):
                        print("💀 Enter Failur ")
                        reject(error)
                    }
                })
        }
    }

    private func request(by endpoint: Endpoint) -> DataRequest {
        var params = [String: Any]()
        for (key, value) in endpoint.parameters {
            if value is String {
                params[key] = (value as?String)?.replacedArabicDigitsWithEnglish
            }
            else{
                params[key] = value
            }
        }
        print("ℹ️ Endpoint URL : \(endpoint.service.url + endpoint.urlPrefix)")
        print("ℹ️ Method : \(endpoint.method.alamofireEndpoint)")
        print("ℹ️ Parameters : \(params.filter{$0.value as?String != "" && $0.value as?Int != 0})")
        print("ℹ️ Headers : \(concatenateHeaders(for: endpoint))")

        var filtedParams: [String:Any] = params
        if filtedParams["rate"] == nil {
            filtedParams = params.filter{$0.value as?String != "" && $0.value as?Int != 0}
        }
        
        return manager.request(endpoint.service.url + endpoint.urlPrefix,
                               method: endpoint.method.alamofireEndpoint,
                               parameters: filtedParams,
                               encoding: endpoint.encoding.alamofireEncoding,
                               headers: concatenateHeaders(for: endpoint))
    }

    func uploadMultipart(_ endpoint: Endpoint) -> Promise<NetworkServiceResponse> {
        return Promise<NetworkServiceResponse>(on: .global()) { fulfill, reject in
            self.upload(by: endpoint, completionHandler: { (response) in
                switch response {
                case .success(let upload, _, _):
                    upload.uploadProgress(closure: { (progress) in
                        print("progress: ％ \(Int(progress.fractionCompleted*100))")
                        self.uploadFileNotificationCenter(progress: Int(progress.fractionCompleted*100))
                    })
                    upload.response { response in
                        fulfill(NetworkServiceResponse(data: response.data!,
                                                       statusCode: response.response?.statusCode,
                                                       headers: response.response?.allHeaderFields))
                    }
                case .failure(let error):
                    print("Enter Failur ❤️")
                    reject(error)
                }
            })
        }
    }

    private func upload(by endpoint: Endpoint, completionHandler: @escaping (SessionManager.MultipartFormDataEncodingResult) -> Void ) {
        var params = [String: Any]()
        for (key, value) in endpoint.parameters {
            if value is String {
                params[key] = (value as?String)?.replacedArabicDigitsWithEnglish
            }
            else{
                params[key] = value
            }
        }
        print("ℹ️ url : \(endpoint.service.url + endpoint.urlPrefix)")
        print("ℹ️ Method : \(endpoint.method.alamofireEndpoint)")
        print("ℹ️ Parameters : \(params.filter{$0.value as?String != "" && $0.value as?Int != 0})")
        print("ℹ️ Headers : \(concatenateHeaders(for: endpoint))")

        manager.upload(multipartFormData: { MultipartFormData in
            for (key, value) in params.filter({($0.value as? String) != "" && (($0.value as? Data)?.toString() != "")  }) {
                
                if key == "photo" || key == "image" || key == "car_license_image" || key == "driver_license_image" || key == "commercial_image"{
                    let image = value as! Data
                    let item = MultiPartModel(data: image ,
                                              fileName: "file.png",
                                              mimeType: "png",
                                              keyName: key)
                    MultipartFormData.append(item.data, withName: key, fileName: item.fileName, mimeType: item.mimeType)
                }
                else if key == "profile_img" || key == "images" || key == "id_national_back_img" {
                    for image in value as! [Data] {
                        let item = MultiPartModel(data: image ,
                                                  fileName: "file.png",
                                                  mimeType: "png",
                                                  keyName: key)
                        MultipartFormData.append(item.data, withName: "\(item.keyName)[]", fileName: item.fileName, mimeType: item.mimeType)
                    }
                    
                }else{
                    MultipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)

                }

            }
        },
                       usingThreshold: UInt64.init(),
                       to: endpoint.service.url + endpoint.urlPrefix,
                       method: endpoint.method.alamofireEndpoint,
                       headers: concatenateHeaders(for: endpoint),
                       encodingCompletion: { result in
                        completionHandler(result)
        })
    }
    
    private func concatenateHeaders(for endpoint: Endpoint) -> [String: String] {
        var headers = endpoint.headers.filter{$0.value != ""}
//        headers.updateValue(Localization.currentAppleLanguage(), forKey: "Accept-Language")
//        headers.updateValue(Localization.currentAppleLanguage(), forKey: "language")
        headers.updateValue("en", forKey: "lang")
        headers.updateValue("application/json", forKey: "Content-Type")      
        return headers
    }

    private func uploadFileNotificationCenter(progress: Int){
        let progressValue: [String: Int] = ["progress": progress]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "inProgress"), object: nil, userInfo: progressValue)
    }
}

extension EndpointEncoding {
    var alamofireEncoding: ParameterEncoding {
        switch self {
        case .json: return JSONEncoding.default
        case .query: return URLEncoding.queryString
        }
    }
}

extension EndpointMethod {
    var alamofireEndpoint: HTTPMethod {
        switch self {
        case .get: return .get
        case .post: return .post
        case .delete: return .delete
        case .put: return .put
        }
    }
}
