//
//  TeamPlayersListViewModel.swift
//  NBApp
//
//  Created by Filippo Giove on 10/02/2021.
//

import Foundation
class TeamPlayersListViewModel {
    var team:TeamModel!
    var players:[PlayerModel]!

    init(){

    }

    func setTeam(_ team:TeamModel){
        self.team = team
        if let teamID = self.team.id, let players = SynchManager.sharedInstance().playersToTeam[teamID],players.count > 0{
            self.players = players
        }
        else{
            self.players = []
        }
    }

}

