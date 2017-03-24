//
//  RestaurantViewController.swift
//  Restaurant Solution
//
//  Created by Danny Harding on 3/21/17.
//  Copyright © 2017 Danny Harding. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController {

	var restaurant: Restaurant?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "toMenu", let nextScene = segue.destination as? CategoriesCollectionViewController {
			nextScene.restaurant = self.restaurant
		} else if segue.identifier == "aboutRestaurant", let nextScene = segue.destination as? RestaurantViewController {
			nextScene.restaurant = self.restaurant
		}
    }

}
