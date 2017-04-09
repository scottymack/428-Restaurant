//
//  RestaurantTableViewController.swift
//  Restaurant Solution
//
//  Created by Danny Harding on 1/28/17.
//  Copyright © 2017 Danny Harding. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

	var restaurantsList = [Restaurant]()

    override func viewDidLoad() {
		print("viewDidLoad")
        super.viewDidLoad()

		getRestaurants()
    }

	func getRestaurants() {
		ServerCommunicator.GET(route: "/restaurants") { data in
			if let restaurants = data["restaurants"] as? [[String: Any]] {
				for restaurant in restaurants {
					self.restaurantsList.append(Restaurant(json: restaurant))
				}

				self.tableView.reloadData()
			}
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantsList.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as! RestaurantTableViewCell

		let restaurant = restaurantsList[indexPath.row]
        cell.restaurant = restaurant
		cell.name.text = restaurant.name
		cell.address.text = restaurant.city + ", " + restaurant.state

        return cell
    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let nextScene = segue.destination as? RestaurantViewController {
			let cell = sender as! RestaurantTableViewCell
			nextScene.restaurant = cell.restaurant
		}
        // Pass the selected object to the new view controller.
    }

}
