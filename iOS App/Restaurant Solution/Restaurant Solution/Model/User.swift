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

class User
{
    
    static let sharedInstance: User = {
        let instance = User()
        return instance }()
    
    // TODO: Fill this with data from the sign up process
//    var profilePicture:UIImage = UIImage(named: "")!
    var firstName = "Scott"
    var lastName = "McKenzie"
    var email = "example@example.com"
    var username = ""
    var birthday = "11/28/1992"
    var phoneNumber = "(208) 957 4100"
    var gender = "Male"
}
