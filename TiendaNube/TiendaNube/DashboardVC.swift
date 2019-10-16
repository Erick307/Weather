//
//  DashboardVC.swift
//  TiendaNube
//
//  Created by Erick Silva on 10/16/19.
//  Copyright © 2019 ericksilva. All rights reserved.
//

import Foundation
import UIKit

class DashboardVC: UIViewController {
    
    static func getViewController() -> UIViewController{
        return DashboardVC()
    }
    
    let presenter = DashboardPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.attach(view: self)
        presenter.updateWeather()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        presenter.detach()
    }
    
    func setupView(){
        
    }
    
}

extension DashboardVC: DashboardView{
    func showError(error: String) {
        
    }
    
    func updateView(response: Response, city: City) {
        
    }
}


class CityWeatherView: UIView {
    
    var lblCityName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var lblWindSpeed: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var lblTemp: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    func setWeather(weather:Response){
        
        
    }
    
    func setup(){
        self.addSubview(lblCityName)
        lblCityName.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        lblCityName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        lblCityName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20).isActive = true
        lblCityName.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        self.addSubview(lblTemp)
        lblCityName.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        lblCityName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        lblCityName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20).isActive = true
        lblCityName.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.addSubview(lblWindSpeed)
        lblCityName.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        lblCityName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        lblCityName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20).isActive = true
        lblCityName.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
}
