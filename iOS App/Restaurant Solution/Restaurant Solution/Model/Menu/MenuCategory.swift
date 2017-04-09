//
//  MenuCategory.swift
//  Restaurant Solution
//
//  Created by Danny Harding on 3/4/17.
//  Copyright © 2017 Danny Harding. All rights reserved.
//

import Foundation

class MenuCategory {
	public let name: String
	let id: Int
	public var contents = [MenuItem]()

	init (json: [String : Any]) {
		name = json["name"] as! String
		id = json["id"] as! Int

		if let menuItems = json["menu_items"] as! [[String : Any]]? {
			menuItems.forEach { menuItem in
				contents.append(MenuItem(json: menuItem))
			}
		}
	}
}
