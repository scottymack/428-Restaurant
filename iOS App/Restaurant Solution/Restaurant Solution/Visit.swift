//
//  Visit.swift
//  Restaurant Solution
//
//  Created by Danny Harding on 4/10/17.
//  Copyright © 2017 Danny Harding. All rights reserved.
//

import Foundation

class Visit {
	let userID: Int
	let restaurantID: Int
	var visitID: Int?

	init(userID: Int, restaurantID: Int) {
		self.userID = userID
		self.restaurantID = restaurantID

		setID()
	}

	func setID() {
		ServerCommunicator.POST(options: ["route": "/visits", "data": ["user_id": userID, "restaurant_id": restaurantID], "expect": "json"]) {data in
			guard let data = data as? [String: Any], let visit = data["visit"] as? [String: Any] else {
				//didn't get the visit right, remove visit from user?
				print("failed visit")
				return
			}

			self.visitID = visit["id"] as! Int
		}
	}
}
