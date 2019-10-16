//
//  DashboardPresenter.swift
//  TiendaNube
//
//  Created by Erick Silva on 10/16/19.
//  Copyright © 2019 ericksilva. All rights reserved.
//

import Foundation

class DashboardPresenter {
    
    var dashboardView : DashboardView?
    
    func attach(view: DashboardView ){
        dashboardView = view
    }
    
    func detach(){
        dashboardView = nil
    }
    
    func updateWeather(){
    
        //Todo refactor
        RestApi.shared.getMonteCarloWeather(onError: { (error) in
            if let result = self.getFromCache(city: City.MonteCarlo){
                self.dashboardView?.updateView(response: result, city: City.MonteCarlo)
            }else{
                self.dashboardView?.showError(error: error)
            }
        }) { (status, data) in
            let response =  Response.init(json: data)
            self.saveOnCache(response: response, city: .MonteCarlo)
        }
        
        RestApi.shared.getSaoPabloWeather(onError: { (error) in
            if let result = self.getFromCache(city: City.SauPablo){
                self.dashboardView?.updateView(response: result, city: City.SauPablo)
            }else{
                self.dashboardView?.showError(error: error)
            }
        }) { (status, data) in
            let response =  Response.init(json: data)
            self.saveOnCache(response: response, city: .SauPablo)
        }

        RestApi.shared.getMelbourneWeather(onError: { (error) in
            if let result = self.getFromCache(city: City.Melbourne){
                self.dashboardView?.updateView(response: result, city: City.Melbourne)
            }else{
                self.dashboardView?.showError(error: error)
            }
        }) { (status, data) in
            let response =  Response.init(json: data)
            self.saveOnCache(response: response, city: .Melbourne)
        }
        
        RestApi.shared.getSilverstoneWeather(onError: { (error) in
            if let result = self.getFromCache(city: City.Silverstone){
                self.dashboardView?.updateView(response: result, city: City.Silverstone)
            }else{
                self.dashboardView?.showError(error: error)
            }
        }) { (status, data) in
            let response =  Response.init(json: data)
            self.saveOnCache(response: response, city: .Silverstone)
        }
    }

    func getFromCache(city:City) -> Response? {
        let cityName = getCityName(city: city)
        let defaults = UserDefaults.standard
        return defaults.object(forKey:cityName) as? Response
    }
    
    func saveOnCache(response: Response, city:City){
        let cityName = getCityName(city: city)
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(response) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: cityName)
        }
    }
    
    func getCityName(city: City) -> String {
        var cityName = ""
        switch city {
        case .SauPablo:
            cityName = "SaoPablo"
            break
        case .Melbourne:
            cityName = "Melbourne"
            break
        case .Silverstone:
            cityName = "Silverstone"
            break
        case .MonteCarlo:
            cityName = "MonteCarlo"
            break
        }
        return cityName
    }
}

protocol DashboardView {
    func showError(error:String)
    func updateView(response: Response, city: City)
}

enum City {
    case SauPablo, Melbourne, Silverstone, MonteCarlo
}
