//
//  TeamListViewController.swift
//  NBATest
//
//  Created by Filippo Giove on 10/02/2021.
//  Copyright © 2020 Filippo Giove. All rights reserved.
//

import UIKit

class TeamListViewController: UIViewController {

    var viewModel = TeamListViewModel()
    @IBOutlet weak var loaderIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        self.title = "TEAM"
        self.collectionView.register(UINib(nibName: "TeamCell", bundle: nil), forCellWithReuseIdentifier: TeamCell.ReuseIndetifier)
        viewModel.teams.bind { [weak self] _ in
            DispatchQueue.main.async {
                if(self?.viewModel.loaded ?? false){
                    self?.loaderIndicator.isHidden = true
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }


}

extension TeamListViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.teams.value.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item

        let model = self.viewModel.teams.value[index]
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: TeamCell.ReuseIndetifier, for: indexPath) as! TeamCell
        cell.initWithData(model: model)
        return cell

    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)

    }



    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item
        let model = self.viewModel.teams.value[index]
        let vcDetails = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TeamPlayersListViewController") as! TeamPlayersListViewController
        vcDetails.viewModel = TeamPlayersListViewModel()
        vcDetails.viewModel.setTeam(model)
        NSLog("PUSH!!!")
        self.navigationController?.pushViewController(vcDetails, animated: true)

    }
}
