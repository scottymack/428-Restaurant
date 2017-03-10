//
//  Restaurant.swift
//  Restaurant Solution
//
//  Created by Danny Harding on 1/29/17.
//  Copyright © 2017 Danny Harding. All rights reserved.
//

import Foundation
import UIKit

class Restaurant {

	var name: String
	var address: String
	var image: UIImage?

	var menu: Menu?

//	init(name: String, menu: String) {
//		// implement initializer
//	}

	init(json: [String: Any]) {
		print(json)
		name = json["name"] as! String
		address = json["city"] as! String + ", " + (json["state"] as! String)

		if let jsonMenu = json["menu"] as? [[String : Any]] {
			menu = Menu(json: jsonMenu)
		} else {
			print("not adding menu")
		}
	}

}
