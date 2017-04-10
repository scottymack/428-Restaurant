//
//  RestaurantViewController.swift
//  Restaurant Solution
//
//  Created by Danny Harding on 4/6/17.
//  Copyright © 2017 Danny Harding. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController {

	@IBOutlet weak var imageText: UILabel!
	@IBOutlet weak var restaurantName: UILabel!
	@IBOutlet weak var restaurantNavItem: UINavigationItem!

	var restaurant: Restaurant?

    override func viewDidLoad() {
        super.viewDidLoad()

		imageText.text = imageText.text! + " for \(restaurant!.name)"
		restaurantName.text = restaurant!.name
		restaurantNavItem.title = restaurant?.name


		getCompleteRestaurant()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	func getCompleteRestaurant() {
		guard let myRestaurant = restaurant else {
			print("THIS IS ALL WRONG THERE SHOULD BE A RESTAURANT HERE")
			return
		}

		ServerCommunicator.GET(route: "/restaurants/menus/" + String(myRestaurant.id)) {data in
			if let restaurantFromServer = data["restaurant"] as? [String: Any] {
				self.restaurant = Restaurant(json: restaurantFromServer)
			}
		}
	}
    
	@IBAction func checkIn(_ sender: Any) {
		
	}


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let segID = segue.identifier {
			switch segID {
				case "toMenu":
					// make sure that restaurant has a menu
					print("toMenu")
					if let menu = restaurant?.menu {
						let nextScene = segue.destination as! CategoriesCollectionViewController
						nextScene.menu = menu
					} else {
						print("please wait for menu to load")
					}
				case "toMessageServer":
					print("toMenu2")
				case "toPayment":
					print("toMenu3")
				case "toAbout":
					print("toMenu4")
				default: break
			}
		}


        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
