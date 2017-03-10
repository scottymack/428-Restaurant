//
//  RestaurantViewController.swift
//  Restaurant Solution
//
//  Created by Danny Harding on 3/7/17.
//  Copyright © 2017 Danny Harding. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController {

	var restaurant: Restaurant?

	@IBOutlet weak var menuView: UIView!
	@IBOutlet weak var messageServerView: UIView!
	@IBOutlet weak var payBillView: UIView!
	@IBOutlet weak var aboutView: UIView!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
