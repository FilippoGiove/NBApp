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
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        self.title = "TEAM"
        self.collectionView.register(UINib(nibName: "TeamCell", bundle: nil), forCellWithReuseIdentifier: TeamCell.ReuseIndetifier)
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
        return viewModel.teams.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item

        let model = self.viewModel.teams[index]
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
        let model = self.viewModel.teams[index]
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TeamPlayersListViewController") as! TeamPlayersListViewController
        vc.viewModel = TeamPlayersListViewModel()
        vc.viewModel.setTeam(model)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
