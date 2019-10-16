//
//  RestApi.swift
//  TestAlbum
//
//  Created by Erick Silva on 9/30/19.
//  Copyright © 2019 ericksilva. All rights reserved.
//

import Foundation
import Alamofire

class RestApi: NSObject {
    
    let baseUrl = "https://api.openweathermap.org/data/2.5/"
    let endpoing = "weather?q="
    let apikey = "&appid=2cebe458561b8e39965d632395a2852e"
    
    public static let shared = RestApi()
    private override init(){}

    public typealias Response = (_ status:Int, _ response:Data)->Void
    public typealias ErrorResponse = (_ error:String)->Void
    
    
    public func getSilverstoneWeather(onError:@escaping ErrorResponse, onResponse: @escaping Response){
        getWeather(city: "Silverstone,uk", onError: onError, onResponse: onResponse)
    }
    public func getSaoPabloWeather(onError:@escaping ErrorResponse, onResponse: @escaping Response){
        getWeather(city: "S%C3%A3o%20Paulo,BR", onError: onError, onResponse: onResponse)
    }
    public func getMelbourneWeather(onError:@escaping ErrorResponse, onResponse: @escaping Response){
        getWeather(city: "Melbourne,Australia", onError: onError, onResponse: onResponse)
    }
    public func getMonteCarloWeather(onError:@escaping ErrorResponse, onResponse: @escaping Response){
        getWeather(city: "Monte%20Carlo,Monaco", onError: onError, onResponse: onResponse)
    }
    
    func getWeather(city:String,onError:@escaping ErrorResponse, onResponse: @escaping Response){
        let url = baseUrl + endpoing + city + apikey
        makeRequestGet(url,onError,onResponse)
    }
    
    public func makeRequestPost(
        _ url:String,
        _ params:Parameters?,
        _ headers: HTTPHeaders?,
        _ onError: @escaping ErrorResponse,
        _ onResponse:@escaping Response){
        makeRequest(
            url: url,
            params: params,
            headers: headers,
            method: HTTPMethod.post,
            onError: onError,
            onResponse: onResponse
        )
    }
    
    public func makeRequestGet(
        _ url:String,
        _ onError: @escaping ErrorResponse,
        _ onResponse:@escaping Response){
        makeRequest(
            url: url,
            params: nil,
            headers: nil,
            method: HTTPMethod.get,
            onError: onError,
            onResponse: onResponse
        )
    }
    public func makeRequestGet(
        _ url:String,
        _ headers: HTTPHeaders,
        _ onError: @escaping ErrorResponse,
        _ onResponse:@escaping Response){
        makeRequest(
            url: url,
            params: nil,
            headers: headers,
            method: HTTPMethod.get,
            onError: onError,
            onResponse: onResponse
        )
    }
    
    public func makeRequest(
        url:String,
        params:Parameters?,
        headers:HTTPHeaders?,
        method:HTTPMethod,
        onError: @escaping ErrorResponse,
        onResponse:@escaping Response){
        
        print("TA /////////////////////////")
        print("TA URl: \(url)")
        if let p = params {
            print("TA Params: \(p)")
        }
        if let h = headers{
            print("TA Headers: \(h)")
        }
        print("TA Method: \(method.rawValue)")
        
        Alamofire.request(
            url,
            method: method,
            parameters: params,
            encoding: JSONEncoding.default,
            headers: headers).responseJSON{ response in
                
                print("TA Receive: \(response)")
                
                switch response.result {
                case .success:
                    if let data = response.data {
                        if let httpresponse = response.response{
                            print("TA Status Code: \(httpresponse.statusCode)")
                            if httpresponse.statusCode >= 400 {
                                onError("Error inesperado")
                                return
                            }
                        }
                        onResponse(response.response?.statusCode ?? 200, data)
                    }else{
                        onError("Error desconocido")
                    }
                    break
                case .failure(_):
                    print("TA error")
                    onError("")
                    break
                }
        }
    }
}
