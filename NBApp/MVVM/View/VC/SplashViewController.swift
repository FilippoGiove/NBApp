//
//  SplashViewController.swift
//  NBApp
//
//  Created by Filippo Giove on 10/02/2021.
//

import UIKit

class SplashViewController: UIViewController {

    var viewModel = SplashViewModel()


    override func viewDidLoad() {
        viewModel.synch()
        configureViewModel()
    }

    func configureViewModel(){
        viewModel.itemFetchedClosure = {[weak self] in
            guard let weakSelf = self else {return}

            if let itemFetched = self?.viewModel.itemFetched, itemFetched{
                DispatchQueue.main.async {
                    guard let _ = self else {return}
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "NavTeamListViewController")
                    Utils.redirectTo(vc: controller)
                }

            }
            else{
                weakSelf.showRetryAlert()
            }


        }
    }

    func showRetryAlert(){
        let alert = UIAlertController(title: "Attenzione", message: "C'è stato un errore!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Riprova", style: .default, handler: { action in
            self.viewModel.synch()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
