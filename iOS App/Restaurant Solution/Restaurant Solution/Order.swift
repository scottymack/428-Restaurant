//
//  Order.swift
//  Restaurant Solution
//
//  Created by Danny Harding on 3/9/17.
//  Copyright © 2017 Danny Harding. All rights reserved.
//

import Foundation

class Order {

	static var items = [MenuItem]()
	static var price = { () -> Double in 
		var sum = 0.0
		Order.items.forEach { menuItem in
			if let itemPrice = Double(menuItem.price) {
				sum += itemPrice
			}
		}
		return sum
	}

	static func add(menuItem: MenuItem) {
		items.append(menuItem)
	}

	static func remove(menuItem: MenuItem) {
		for (index, currItem) in items.enumerated() {
			if currItem == menuItem {
				items.remove(at: index)
				return
			}
		}
	}

}
