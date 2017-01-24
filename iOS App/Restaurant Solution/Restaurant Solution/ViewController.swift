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

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
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

}

