//
//  Menu.swift
//  Restaurant Solution
//
//  Created by Danny Harding on 3/4/17.
//  Copyright © 2017 Danny Harding. All rights reserved.
//

import Foundation

class Menu {
	var categories = [MenuCategory]()

	init(json: [[String : Any]]) {

		json.forEach { category in
			categories.append(MenuCategory(json: category))
		}
	}
}
