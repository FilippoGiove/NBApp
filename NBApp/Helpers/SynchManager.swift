//
//  SynchManager.swift
//  NBApp
//
//  Created by Filippo Giove on 10/02/2021.
//

import Foundation



class SynchManager: NSObject {


    private static var singleton: SynchManager!
    static func sharedInstance() -> SynchManager {
        if singleton == nil{
            singleton = SynchManager.init()
        }
        return singleton
    }


    var teams:[TeamModel]!
    var playersToTeam:[Int:[PlayerModel]]!


    


    


}
