//
//  Models.swift
//  TiendaNube
//
//  Created by Erick Silva on 10/16/19.
//  Copyright © 2019 ericksilva. All rights reserved.
//

import Foundation

struct Response : Codable{
    
    var coord: Coord?
    var weather: [Weather]?
    var main: Main?
    var wind: Wind?
    var cloud: Cloud?
    var sys: Sys?
    
    var base: String?
    var visibility: Int?
    var dt : Double?
    var timezone: Int?
    var id : Int?
    var name: String?
    var cod : Int?
    
    init(json : Data){
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            self = try decoder.decode(Response.self, from: json)
        }catch{
            print("TN parse error")
        }
    }
}

struct Coord: Codable {
    var lat, lon: Float?
}

struct Weather: Codable {
    var id: Int?
    var main, description, icon : String?
}

struct Main: Codable {
    var temp, pressure, humidity, temp_min, temp_max : Float?
}

struct Wind: Codable {
    var speed, deg: Float?
}

struct Cloud: Codable {
    var all: String?
}

struct Sys: Codable {
    var type, id, sunrise, sunset: Float?
    var country: String?
}
