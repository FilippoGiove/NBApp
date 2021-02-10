//
//  Utils.swift
//  NBATest
//
//  Created by Filippo Giove on 10/02/2021.
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

    static func redirectTo(vc: UIViewController){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if #available(iOS 13.0, *){
            if let scene = UIApplication.shared.connectedScenes.first{
                guard let windowScene = (scene as? UIWindowScene) else { return }
                let window: UIWindow = UIWindow(frame: windowScene.coordinateSpace.bounds)
                window.windowScene = windowScene //Make sure to do this
                window.rootViewController = vc
                window.makeKeyAndVisible()
                appDelegate.window = window
            }
        } else {
            appDelegate.window?.rootViewController = vc
            appDelegate.window?.makeKeyAndVisible()
        }
    }


    
}
