//
//  SplashViewModel.swift
//  NBApp
//
//  Created by Filippo Giove on 10/02/2021.
//

import Foundation
class SplashViewModel {


    var itemFetched:Bool?{
        didSet{
            itemFetchedClosure?()
        }
    }

    var itemFetchedClosure:(() -> ())?

    var showOrHideLoader:Bool?{
        didSet {
            self.showOrHideLoaderClosure?()
        }
    }
    var showOrHideLoaderClosure:(() -> ())?


    var actualPageIndex = 0

    public func synch() {
        SynchManager.sharedInstance().teams = []
        SynchManager.sharedInstance().playersToTeam = [:]
        nextPage(page: actualPageIndex)
    }


    func nextPage(page:Int){
        NSLog("DOWNLOAD PAGE #%d",page)
        let session = URLSession.shared
        var urlComponents = URLComponents(string: ALL_PLAYERS_LIST_API)!
        let parameters = ["page": "\(page)", "per_page" : "100"]
        var queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        urlComponents.queryItems = queryItems


        var request = URLRequest(url: (urlComponents.url)!)
        request.httpMethod = "GET"
        request.setValue("71bd3ddeb2mshecc592c3768ac35p1f816djsnd243a453f890", forHTTPHeaderField: "x-rapidapi-key")
        request.setValue("free-nba.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")

        let task = session.dataTask(with: request, completionHandler: {
                        data, response, error in

                if(error != nil){
                    self.itemFetched = false
                }
                else{
                    do {
                        if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                            if let results = jsonResult["data"] {
                                let resultsArray = results as! NSArray
                                for i in 0 ..< (resultsArray.count) {
                                    let playerDictionary = resultsArray[i] as! NSDictionary
                                    if let teamsDictionary = playerDictionary["team"] as? NSDictionary{
                                        if let idTeam = teamsDictionary["id"] as? Int{
                                            if !SynchManager.sharedInstance().teams.contains(where: { name in name.id == idTeam }) {
                                                SynchManager.sharedInstance().teams.append(self.getTeamModel(from:teamsDictionary))
                                            }

                                            let player = self.getPlayerModel(from: playerDictionary)
                                            if(SynchManager.sharedInstance().playersToTeam[idTeam] == nil){
                                                SynchManager.sharedInstance().playersToTeam[idTeam] = [player]
                                            }
                                            else{
                                                var players = SynchManager.sharedInstance().playersToTeam[idTeam]
                                                players!.append(player)
                                                SynchManager.sharedInstance().playersToTeam[idTeam] = players
                                            }
                                        }
                                    }
                                }
                            }
                            if let meta = jsonResult["meta"] as? NSDictionary,
                               let total_pages =  meta["total_pages"] as? Int,
                               let current_page = meta["current_page"] as? Int,
                               let next_page = meta["next_page"] as? Int,
                               current_page < total_pages{
                                self.nextPage(page: next_page)
                            }
                            else{
                                NSLog("itemFetched!!!!")
                                self.itemFetched = true
                            }

                        }
                    } catch {
                        print ("Something Went Wrong")
                        self.itemFetched = false
                    }
            }

            })
            task.resume()
    }


    func getTeamModel(from teamsDictionary:NSDictionary)->TeamModel{
        let id = teamsDictionary["id"] as? Int ?? -1
        let abbreviation = (teamsDictionary["abbreviation"] as? String) ?? ""
        let conference = teamsDictionary["conference"] as? String ?? ""
        let division = teamsDictionary["division"] as? String ?? ""
        let full_name = teamsDictionary["full_name"] as? String ?? ""
        let name = teamsDictionary["name"] as? String ?? ""
        let city = teamsDictionary["city"] as? String ?? ""
        return TeamModel(id: id, abbreviation: abbreviation, city: city, conference: conference, division: division, full_name: full_name, name: name)
    }


    func getPlayerModel(from playerDictionary:NSDictionary)->PlayerModel{
        let id = playerDictionary["id"] as? Int ?? -1
        let first_name = (playerDictionary["first_name"] as? String) ?? ""
        let last_name = playerDictionary["last_name"] as? String ?? ""
        let height_feet = playerDictionary["height_feet"] as? String ?? ""
        let height_inches = playerDictionary["height_inches"] as? String ?? ""
        let position = playerDictionary["position"] as? String ?? ""
        let weight_pounds = playerDictionary["weight_pounds"] as? String ?? ""
        return PlayerModel(id: id, first_name: first_name, last_name: last_name, height_feet: height_feet, height_inches: height_inches, position: position, weight_pounds: weight_pounds)
    }

}
