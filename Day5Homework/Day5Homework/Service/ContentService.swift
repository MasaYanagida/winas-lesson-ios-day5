//
//  ContentService.swift
//  Day5Sample
//
//  Created by 柳田昌弘 on 2021/01/04.
//

import Foundation

import SwiftyJSON
import ObjectMapper

class ContentService {
    // TODO
    func getHospital(
        hospitalId : Int,
        completion: ((_ hospital: Hospital) -> Void)? = { _ in },
        failure: ((_ error: NSError?, _ StatusCode: Int?) -> Void)? = { _, _ in}
    ){
        _ = SampleNetwork.request(
            target: .getHospital(hospitalId: hospitalId),
            success: { json, _ in
                guard let safeJson = json else {return}
                DispatchQueue.main.async {
                    if let hospital = Mapper<Hospital>().map(JSONObject: safeJson.dictionaryObject) {
                        completion?(hospital)
                    }else{
                        failure?(nil, nil)
                    }
                }
            },
            error: { statusCode in
                failure?(nil, statusCode)
            },
            failure: { error in
                failure?(nil,nil)
                
            }
        )
    }
    
    func getRestaurant(
        restaurantId: Int,
        completion: ((_ restaurant: Restaurant) -> Void)? = { _ in},
        failure: ((_ error: NSError?, _ StatusCode: Int?) -> Void)? = {_, _ in}
    ){
        _ = SampleNetwork.request(target: .getRestaurant(restaurantId: restaurantId),
                  success: { json, _ in
                    guard let safeJson = json else {return}
                    DispatchQueue.main.async {
                        if let restaurant = Mapper<Restaurant>().map(JSONObject: safeJson.dictionaryObject){
                            completion?(restaurant)
                        }else{
                            failure?(nil, nil)
                        }
                    }
                  },
                  error: {statusCode in
                      failure?(nil, statusCode)
                  },
                  failure: {error in
                      failure?(nil, nil)
                  }
            )
        }
    
    func getList(
           completion: ((_ dataArray: [Feedable]) -> Void)? = { _ in },
           failure: ((_ error: NSError?, _ statusCode: Int?) -> Void)? = { _, _ in }
           )
       {
           _ = SampleNetwork.request(
               target: .getList,
               success: { json, _ in
                   guard let safeJson = json else { return }
                   // run in main => UI thread
                   DispatchQueue.main.async {
                        var dataArray = [Feedable]()
                        safeJson.arrayValue.forEach { jsonObject in
                            guard let contentTypeId = jsonObject["content_type"].int,
                                  let contentType = FeedContentType(rawValue: contentTypeId) else {
                                      return
                                  }
                            switch contentType{
                                case .hospital:
                                    if let hospital = Mapper<Hospital>().map(JSONObject: jsonObject.dictionaryObject){
                                        dataArray.append(hospital)
                                    }
                                case .restaurant:
                                    if let restaurant = Mapper<Restaurant>().map(JSONObject: jsonObject.dictionaryObject){
                                        dataArray.append(restaurant)
                                    }
                        }
                        completion?(dataArray)
                   }
                 }
               },
               error: { statusCode in
                   failure?(nil, statusCode)
               },
               failure: { error in
                   failure?(nil, nil)
               }
           )
       }
}
