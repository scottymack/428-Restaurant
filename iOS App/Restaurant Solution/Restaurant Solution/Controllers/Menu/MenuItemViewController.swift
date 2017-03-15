//
//  MenuItemViewController.swift
//  Restaurant Solution
//
//  Created by Danny Harding on 2/11/17.
//  Copyright © 2017 Danny Harding. All rights reserved.
//

import UIKit

class MenuItemViewController: UIViewController {

	var menuItem: MenuItem?

	@IBOutlet weak var name: UILabel!
	@IBOutlet weak var itemDescription: UILabel!
	@IBOutlet weak var price: UILabel!

	override func viewDidLoad() {
		super.viewDidLoad()

		name.text = menuItem?.name
		itemDescription.text = menuItem?.description
		price.text = menuItem?.price
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


	/*
	// MARK: - Navigation

	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/

}
