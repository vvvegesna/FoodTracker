//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by Vegesna, Vijay V EX1 on 5/9/20.
//  Copyright © 2020 Vegesna, Vijay V EX1. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingsControl!
    @IBOutlet weak var mealName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
