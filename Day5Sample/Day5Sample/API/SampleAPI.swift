//
//  SampleAPI.swift
//  Day5Sample
//
//  Created by 柳田昌弘 on 2021/01/02.
//

import Foundation

import Moya
import SwiftyJSON
import Alamofire

enum StatusCode: Int {
    case badRequest = 400
    case unauthorized = 401
    case notFound = 404
    case paymentRequired = 402
    case forbidden = 403
    case conflict = 409
    case gone = 410
    case requireUpdate = 427
    case invalidToken = 463
    case badGateway = 502
    case serviceUnavailable = 503
    case gatewayTimeOut = 504
}

// MARK: SampleAPI

enum SampleAPI {
    case getList, getHospital(hospitalId: Int), getRestaurant(restaurantId: Int)
}

extension SampleAPI: TargetType {
    var headers: [String: String]? {
        return nil
    }
    var baseURL: URL {
        return URL(string: "http://cs267.xbit.jp/~w065038/app/winas/day5")!
    }
    var path: String {
        switch self {
        case .getList: return "/list.json"
        case .getHospital: return "/hospital.json"
        case .getRestaurant: return "/restaurant.json"
        }
    }
    var method: Moya.Method {
        return .get
    }
    var parameters: [String: Any]? {
        switch self {
        case .getList: return nil
        case .getHospital(let hospitalId):
            return ["id": hospitalId]
        case .getRestaurant(let restaurantId):
            return ["id": restaurantId]
        }
    }
    var sampleData: Data {
        return Data()
    }
    var task: Moya.Task {
        if let parameters = self.parameters {
            return .requestParameters(parameters: parameters, encoding: self.parameterEncoding)
        } else {
            return .requestPlain
        }
    }
    var multipartBody: [Moya.MultipartFormData]? {
        return nil
    }
    var parameterEncoding: Moya.ParameterEncoding {
        return URLEncoding.default
    }
}

// MARK: SampleNetwork

struct SampleNetwork {
    static let queue = DispatchQueue(label: "com.winas-lesson.ios.day5.Day5Sample.request", attributes: .concurrent)
    static let plugins: [PluginType] = [
        NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration())
    ]
    static var provider = MoyaProvider<SampleAPI>(plugins: plugins)
    
    static func request(
        target: SampleAPI,
        success successCallback: @escaping (_ /*text: String?*/json: JSON?, _ allHeaderFields: [AnyHashable : Any]?) -> Void,
        error errorCallback: @escaping (_ statusCode: Int) -> Void,
        failure failureCallback: @escaping (Moya.MoyaError) -> Void
        ) -> Cancellable
    {
        return provider.request(target, callbackQueue: self.queue) { result in
            switch result {
            case let .success(response):
                let headerFields = response.response?.allHeaderFields
                do {
                    let res = try response.filterSuccessfulStatusAndRedirectCodes()
                    if (res.statusCode >= 300) {
                        successCallback(nil, headerFields)
                    } else {
                        let json = try JSON(response.mapJSON())
                        //let content = try response.mapString()
                        successCallback(json, headerFields)
                    }
                }
                catch let error {
                    if response.statusCode == 200 {
                        successCallback(nil, headerFields)
                    } else {
                        switch error as! Moya.MoyaError {
                        case .statusCode(let response):
                            if let statusCode = StatusCode(rawValue: response.statusCode) {
                                errorCallback(statusCode.rawValue)
                            } else {
                                failureCallback(error as! MoyaError)
                            }
                        default: failureCallback(error as! Moya.MoyaError)
                        }
                    }
                }
            case let .failure(error): failureCallback(error)
            }
        }
    }
}
