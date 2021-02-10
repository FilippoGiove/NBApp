//
//  TeamModel.swift
//  NBATest
//
//  Created by Filippo Giove on 10/02/2020.
//  Copyright © 2020 Filippo Giove. All rights reserved.
//

import UIKit

// MARK: - Model
public class TeamModel {

    public var id: Int?
    public var abbreviation: String?

    public var city:String?
    public var conference:String?
    public var division:String?
    public var full_name:String?
    public var name:String?


    public init(id:Int,abbreviation:String,city:String,conference:String,division:String,full_name:String,name:String) {
        self.id = id
        self.abbreviation = abbreviation
        self.city = city
        self.conference = conference
        self.division = division
        self.full_name = full_name
        self.name = name
  }

    func getFullname()->String{
        if (self.full_name ?? "").isEmpty{
            return self.name ?? ""
        }
        return self.full_name!
    }


}
