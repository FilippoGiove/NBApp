//
//  TeamPlayersListViewController.swift
//  NBATest
//
//  Created by Filippo Giove on 10/02/2021.
//  Copyright © 2020 Filippo Giove. All rights reserved.
//

import UIKit

class TeamPlayersListViewController: UIViewController {


    lazy var viewModel: TeamPlayersListViewModel = {
        return TeamPlayersListViewModel()
    }()
   
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {

        self.title = "\(self.viewModel.team?.full_name?.uppercased() ?? "") PLAYERS"

        self.collectionView.register(UINib(nibName: "PlayerCell", bundle: nil), forCellWithReuseIdentifier: PlayerCell.ReuseIndetifier)

    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }


}

extension TeamPlayersListViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.players.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item

        let model = self.viewModel.players[index]
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: PlayerCell.ReuseIndetifier, for: indexPath) as! PlayerCell
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
        /*let index = indexPath.item
        let model = self.viewModel.teams.value[index]
        let vcDetails = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TeamDetailsViewController") as! TeamDetailsViewController
        vcDetails.viewModel = TeamDetailViewModel(of: model)
        self.present(vcDetails, animated: true, completion: nil)*/
    }
}


