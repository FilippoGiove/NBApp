//
//  TeamListViewModel.swift
//  NBATest
//
//  Created by Filippo Giove on 25/09/2020.
//  Copyright © 2020 Filippo Giove. All rights reserved.
//

import UIKit


class TeamListViewModel {
    var teams = Box([TeamModel]())
    var index = 0

    public var loaded = false
    // MARK: - Initialization
    init() {
        if(Reachability.isConnectedToNetwork()){
            fetchAllTeams()
        }

    }

    public func fetchAllTeams() {
        fetchTeams(completion: {
            teams,error in
            self.loaded = true
            if let _ = error{
                self.teams.value = []
            }
            else{
                self.teams.value.append(contentsOf: teams)
            }
        })
    }

}

extension TeamListViewModel {
    public func fetchTeams(completion: @escaping ([TeamModel], Error?) -> Void) {
        let url = URL(string: TEAM_LIST_API)!
        let session = URLSession.shared
        var teams:[TeamModel] = []

        var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("71bd3ddeb2mshecc592c3768ac35p1f816djsnd243a453f890", forHTTPHeaderField: "x-rapidapi-key")
            request.setValue("free-nba.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        let task = session.dataTask(with: request, completionHandler: {
                        data, response, error in

                if(error != nil){
                    completion([],error)
                }
                else{
                    do {
                        if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {

                            if let results = jsonResult["data"] {
                                let resultsArray = results as! NSArray
                                for i in 0 ..< (resultsArray.count) {
                                    let teamsDictionary = resultsArray[i] as! NSDictionary
                                    let id = teamsDictionary["id"] as? Int ?? -1
                                    let abbreviation = (teamsDictionary["abbreviation"] as? String) ?? ""
                                    let conference = teamsDictionary["conference"] as? String ?? ""
                                    let division = teamsDictionary["division"] as? String ?? ""
                                    let full_name = teamsDictionary["full_name"] as? String ?? ""
                                    let name = teamsDictionary["name"] as? String ?? ""
                                    let city = teamsDictionary["city"] as? String ?? ""
                                    let team = TeamModel(id: id, abbreviation: abbreviation, city: city, conference: conference, division: division, full_name: full_name, name: name)
                                    teams.append(team)
                                }
                                completion(teams,nil)
                            }

                        }
                    } catch {
                        print ("Something Went Wrong")
                    }
            }

                    })
                    task.resume()



    }
}
