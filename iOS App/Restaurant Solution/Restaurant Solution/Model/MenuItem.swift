//
//  MenuItem.swift
//  Restaurant Solution
//
//  Created by Danny Harding on 2/9/17.
//  Copyright © 2017 Danny Harding. All rights reserved.
//

import Foundation

class MenuItem {
	let name: String
	let price: String
	let description: String

	init(json: [String : Any]) {
		name = json["name"] as! String
		price = json["price"] as! String
		description = json["description"] as! String
	}

	func toString() -> String {
		return name + " " + String(price) + " " + description
	}

	static func == (left: MenuItem, right: MenuItem) -> Bool {
		return (left.name == right.name) && (left.price == right.price) && (left.description == right.description)
	}
	static func != (left: MenuItem, right: MenuItem) -> Bool {
		return !(left == right)
	}
}
