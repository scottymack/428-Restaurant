//
//  Order.swift
//  Restaurant Solution
//
//  Created by Danny Harding on 3/9/17.
//  Copyright © 2017 Danny Harding. All rights reserved.
//

import Foundation

class Order {

	static var instance = Order()

	var items = [MenuItem]()

	var price: Double {
		var sum = 0.0
		items.forEach { menuItem in
			if let itemPrice = Double(menuItem.price) {
				sum += itemPrice
			}
		}
		return sum
	}

	private init() {}

	func add(menuItem: MenuItem) {
		items.append(menuItem)
	}

	func remove(menuItem: MenuItem) {
		for (index, currItem) in items.enumerated() {
			if currItem == menuItem {
				items.remove(at: index)
				return
			}
		}
	}

}
