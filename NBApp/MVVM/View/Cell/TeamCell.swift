//
//  TeamCell.swift
//  NBATest
//
//  Created by Filippo Giove on 10/02/2021.
//  Copyright © 2020 Filippo Giove. All rights reserved.
//

import UIKit
class TeamCell: UICollectionViewCell {

    public static let ReuseIndetifier = "TeamCell"
    @IBOutlet weak var nameLabel: UILabel!
    var model:TeamModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func initWithData(model:TeamModel?){
        if let model = model, let name = model.full_name{
            self.nameLabel.text = name.uppercased()
        }

    }

}
