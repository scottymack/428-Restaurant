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

	static var token: String {
		if let token = sharedInstance.apiToken {
			print("returning \(token)")
			return token
		} else {
			// probably go to login screen?
			print("no auth")
			return "no auth token"
		}
	}

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

	var visit: Visit?

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

	func storeUserInfo(username: String?, email: String?, token: String?, id: Int?, password: String?) {
		if let username = username {
			self.username = username
		}

		if let email = email {
			self.email = email
			store(email: email)
		}

		if let token = token {
			self.apiToken = token
			store(token: token)
		}

		if let id = id {
			self.serverID = id
		}

		if let password = password {
			store(password: password)
		}
	}

	private func store(token: String) {
		keychain.set(token, forKey: User.tokenKeychainKey)
	}

	private func store(password: String) {
		keychain.set(password, forKey: User.passwordKeychainKey)
	}

	private func store(email: String) {
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
			let _ = keychain.get(User.passwordKeychainKey) {
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
