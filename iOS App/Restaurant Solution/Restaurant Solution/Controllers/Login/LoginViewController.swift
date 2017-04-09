//
//  LoginViewController.swift
//  Restaurant Solution
//
//  Created by Danny Harding on 3/25/17.
//  Copyright © 2017 Danny Harding. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

	@IBOutlet weak var emailInput: UITextField!
	@IBOutlet weak var passwordInput: UITextField!
	@IBOutlet weak var loginButton: UIButton!

	var usernameInput: UITextField?


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	@IBAction func login() {
		let email = emailInput.text!
		let password = passwordInput.text!

		ServerCommunicator.POST(options: ["route": "/login", "data": ["email": email, "password": password], "expect": "json"]) { data in
			if let data = data as? [String: Any] {
				if data["result"] as! String == "success" {

					User.sharedInstance.storeUserInfo(username: nil, email: email, token: data["token"] as? String, id: nil, password: password)

					self.openRestaurantsPage()
				} else {
					print("failed login")
				}
			}
		}
	}

	@IBAction func signUp() {
		if let usernameInput = usernameInput {
			if !validateInputs() {
				print("invalid inputs")
				return
			}
			ServerCommunicator.POST(options: ["route": "/users", "data": ["name": usernameInput.text, "email": emailInput.text, "password": passwordInput.text], "expect": "json"]) { data in
				if let data = data as? [String: Any],
				let user = data["user"] as? [String: Any],
				let apiToken = user["api_token"] as? String {
					User.sharedInstance.storeUserInfo(username: user["name"] as? String, email: user["email"] as? String, token: apiToken, id: user["id"] as? Int, password: self.passwordInput.text)

					self.openRestaurantsPage()
				} else {
					print("failed sign up")
					print(data)
				}
			}
		} else {
			// switch to signup view
			loginButton.removeFromSuperview()
			usernameInput = UITextField(frame: emailInput.frame)
			usernameInput?.placeholder = "Username"
			usernameInput?.borderStyle = emailInput.borderStyle
			let spaceDiff = passwordInput.frame.origin.y - emailInput.frame.origin.y
			usernameInput?.frame.origin.y = passwordInput.frame.origin.y + spaceDiff

			view.addSubview(usernameInput!)
		}

	}

	func validateInputs() -> Bool {
		return true
	}

	func openRestaurantsPage() {
		DispatchQueue.main.async {
			let storyboard = UIStoryboard(name: "Main", bundle: nil)
			let navigationController = storyboard.instantiateViewController(withIdentifier: "restaurantListNavigationController") as! UINavigationController
			UIApplication.shared.keyWindow?.rootViewController = navigationController
		}
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
