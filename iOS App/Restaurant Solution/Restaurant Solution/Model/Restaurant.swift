//
//  Restaurant.swift
//  Restaurant Solution
//
//  Created by Danny Harding on 1/29/17.
//  Copyright © 2017 Danny Harding. All rights reserved.
//

import Foundation

class Restaurant {

	let id: Int
	let name: String
	let address1: String
	let address2: String?
	let city: String
	let state: String
	let zip: String
	var menu: Menu?

	init(json: [String: Any]) {
		id = json["id"] as! Int
		name = json["name"] as! String
		address1 = json["address_line1"] as! String
		address2 = json["address_line2"] as? String
		city = json["city"] as! String
		state = json["state"] as! String
		zip = json["zip_code"] as! String

		if let categories = json["menu_categories"] as? [[String: Any]] {
			menu = Menu(json: categories)
		}
	}
}
