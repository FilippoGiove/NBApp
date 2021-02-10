//
//  PlayerModel.swift
//  NBApp
//
//  Created by Filippo Giove on 10/02/2021.
//

import Foundation
public class PlayerModel {

    public var id: Int
    public var first_name: String?
    public var last_name:String?

    public var height_feet:Int?
    public var height_inches:Int?
    public var position:String?
    public var weight_pounds:Int?


    public init(id:Int,
                first_name:String,
                last_name:String,
                height_feet:Int,
                height_inches:Int,
                position:String,
                weight_pounds:Int) {
        self.id = id
        self.first_name = first_name
        self.last_name = last_name
        self.height_feet = height_feet
        self.height_inches = height_inches
        self.position = position
        self.weight_pounds = weight_pounds
  }




    func getFullname()->String{
        var fullname = ""
        if let name = self.first_name{
            fullname = name
        }
        if(fullname.isEmpty){
            return self.last_name ?? "-"
        }
        else{
            return "\(fullname) \(self.last_name ?? "")"
        }
    }


}
