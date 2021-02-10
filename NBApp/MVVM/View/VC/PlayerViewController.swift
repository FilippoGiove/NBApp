//
//  PlayerViewController.swift
//  NBApp
//
//  Created by Filippo Giove on 10/02/2021.
//

import UIKit

class PlayerViewController: UIViewController {


    lazy var viewModel: PlayerViewModel = {
        return PlayerViewModel()
    }()
    @IBOutlet weak var positionValueLabel: UILabel!
    @IBOutlet weak var heightFeetValueLabel: UILabel!
    @IBOutlet weak var heightInchesValueLabel: UILabel!
    @IBOutlet weak var weightPoundsValueLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        populateUI()
    }
    

    func populateUI(){
        if let model = self.viewModel.player{

            self.title = model.getFullname().uppercased()
            
            if let position = model.position, !position.isEmpty{
                positionValueLabel.text = position.uppercased()
            }
            else{
                positionValueLabel.text = "NA"
            }

            if let height_feet = model.height_feet, !height_feet.isEmpty{
                heightFeetValueLabel.text = height_feet.uppercased()
            }
            else{
                heightFeetValueLabel.text = "NA"
            }

            if let height_inches = model.height_inches, !height_inches.isEmpty{
                heightInchesValueLabel.text = height_inches.uppercased()
            }
            else{
                heightInchesValueLabel.text = "NA"
            }

            if let weight_pounds = model.weight_pounds, !weight_pounds.isEmpty{
                weightPoundsValueLabel.text = weight_pounds.uppercased()
            }
            else{
                weightPoundsValueLabel.text = "NA"
            }
        }
        else{
            positionValueLabel.text = "NA"
            heightFeetValueLabel.text = "NA"
            heightInchesValueLabel.text = "NA"
            weightPoundsValueLabel.text = "NA"
        }

    }

}
