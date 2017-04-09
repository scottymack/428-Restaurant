//
//  RestaurantTableViewCell.swift
//  Restaurant Solution
//
//  Created by Danny Harding on 4/6/17.
//  Copyright © 2017 Danny Harding. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

	@IBOutlet weak var restaurantImage: UIImageView!
	@IBOutlet weak var name: UILabel!
	@IBOutlet weak var address: UILabel!

	var restaurant: Restaurant? = nil
}
