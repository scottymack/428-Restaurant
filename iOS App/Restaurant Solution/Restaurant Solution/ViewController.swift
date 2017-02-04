//
//  ViewController.swift
//  Restaurant Solution
//
//  Created by Danny Harding on 1/24/17.
//  Copyright © 2017 Danny Harding. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	@IBOutlet weak var genericLabel: UILabel!
	@IBOutlet weak var genericText: UITextView!

	override func viewDidLoad() {
		super.viewDidLoad()
		getData()

	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func clickFirstButton(_ sender: UIButton) {
		if genericLabel.text == "My Very First Label" {
			genericLabel.text = "I changed the label!"
		} else {
			genericLabel.text = "My Very First Label"
		}
	}

	@IBAction func clickSecondButton(_ sender: UIButton) {
		if genericLabel.text == "My Very First Label" {
			genericLabel.text = "I changed the label!"
		} else {
			genericLabel.text = "My Very First Label"
		}
	}

	func getData() {
		print("getting data")
		let url = URL(string: "http://yodipity.com/api/restaurants/1")

		let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
			DispatchQueue.main.async(execute: {
				guard error == nil else {
					print(error!)
					return
				}
				guard let data = data else {
					print("Data is empty")
					return
				}

				let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)

				let restaurants = json as! [String : Any]

				// possibly a better way to handle the try?
				//			do {
				//				if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] {
				//					//Implement your logic
				//					print(json)
				//				}
				//			} catch {
				//				print("error in JSONSerialization")
				//			}

				print(json)


				var serverResponse = "The following restaurant(s) was(were) received from the server:\n\n{\n"
				restaurants.keys.forEach { restaurantName in
					let restaurant = restaurants[restaurantName] as! [String: Any]
					restaurant.keys.forEach { key in
						print("here")
						var stringValue: String;
						if let string = restaurant[key] as? String {
							stringValue = string
						} else if let intValue = restaurant[key] as? Int {
							stringValue = String(intValue)
						} else {
							stringValue = "neither type"
						}
						serverResponse += "\t" + key + ": " + stringValue + "\n"
						print(key)
						print(restaurant[key])
					}
				}
				serverResponse += "}"
				self.genericText.text = serverResponse
			})
		}
		
		print("END")
		task.resume()
		
	}
	
}

