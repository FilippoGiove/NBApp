//
//  PlayerCell.swift
//  NBApp
//
//  Created by Filippo Giove on 10/02/2021.
//

import UIKit

class PlayerCell: UICollectionViewCell {

    public static let ReuseIndetifier = "PlayerCell"
    @IBOutlet weak var nameLabel: UILabel!
    var model:TeamModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func initWithData(model:PlayerModel?){
        if let model = model{
            self.nameLabel.text = model.getFullname().uppercased()
        }
    }
}
