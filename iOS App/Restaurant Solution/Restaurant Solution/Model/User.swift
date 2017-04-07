//
//  User.swift
//  Restaurant Solution
//
//  Created by Scott McKenzie on 2/10/17.
//  Copyright © 2017 Danny Harding. All rights reserved.

/*
    This class is a singleton that will allow us to have a single place to store and access all the Main User's info
*/

import Foundation
import UIKit
import KeychainSwift

class User
{
	static let tokenKeychainKey = "inHouseTokenKey"
	static let passwordKeychainKey = "userPasswordKey"
	static let emailUserDefaultsKey = "userEmailKey"
    
	static let sharedInstance = User()

//    var profilePicture:UIImage = UIImage(named: "")!
	var firstName: String?
    var lastName: String?
    var email: String?
    var username: String?
    var birthday: String?
    var phoneNumber: String?
    var gender: String?
	var apiToken: String?
	var serverID: Int?

	let keychain = KeychainSwift()

	private init() {
		firstName = "First"
		lastName = "Last"
		email = "example@example.com"
		username = ""
		birthday = "01/01/1992"
		phoneNumber = "(801) 123 4567"
		gender = "Something"
	}

	func storeUserInfo(user: [String: Any]) {
		apiToken = user["api_token"] as? String
		email = user["email"] as? String
		serverID = user["id"] as? Int
		username = user["name"] as? String
	}

	func store(token: String) {
		keychain.set(token, forKey: User.tokenKeychainKey)
	}

	func store(password: String) {
		keychain.set(password, forKey: User.passwordKeychainKey)
	}

	func store(email: String) {
		UserDefaults.standard.set(email, forKey: User.emailUserDefaultsKey)

	}

	func logout() {
		keychain.delete(User.tokenKeychainKey)
		keychain.delete(User.passwordKeychainKey)
		UserDefaults.standard.removeObject(forKey: User.emailUserDefaultsKey)
	}

	func isLoggedIn() -> Bool {
		if let keychainToken = keychain.get(User.tokenKeychainKey),
			let defaultsEmail = UserDefaults.standard.value(forKey: User.emailUserDefaultsKey) as? String,
			let password = keychain.get(User.passwordKeychainKey) {
			apiToken = keychainToken
			email = defaultsEmail
			// TODO: use password to get all User info, maybe asynchronously
			return true
		} else {
			print("user not logged in")
			return false
		}
	}
}
