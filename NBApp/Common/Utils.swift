//
//  Utils.swift
//  NBATest
//
//  Created by Filippo Giove on 26/09/2020.
//  Copyright © 2020 Filippo Giove. All rights reserved.
//

import UIKit
import Foundation

class Utils{
    static func loadImageFromUrl(url: String, view: UIImageView){

        if let url = URL(string: url){
            let task = URLSession.shared.dataTask(with: url)
            { (responseData, responseUrl, error) -> Void in
                if let data = responseData{
                    DispatchQueue.main.async {
                        view.image = UIImage(data: data)
                    }
                }
            }
            task.resume()
        }




    }


    
}
