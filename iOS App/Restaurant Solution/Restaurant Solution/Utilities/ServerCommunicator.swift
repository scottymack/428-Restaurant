//
//  ServerCommunicator.swift
//  Restaurant Solution
//
//  Created by Danny Harding on 2/21/17.
//  Copyright © 2017 Danny Harding. All rights reserved.
//

import Foundation

class ServerCommunicator {
	static let serverapiURL = "http://yodipity.com/api"

	//static let authToken = "OniBZtLbVRbkbT65j7RKMBQOxyt2ndU0MixCTYes58t5JAbNfe495gOxgfM6"

	enum ServerCommunicatorError: Error {
		case invalidURLFromEndpoint
		case noDataFromServer
		case jsonSerialization
	}

	static func GET(route: String, closure: @escaping ([String : Any]) -> Void) {

		guard let url = URL(string: serverapiURL + route) else {
			print("can't make url from given route")
			return
		}

		var request = URLRequest(url: url)

		request.addValue("Bearer \(User.token)", forHTTPHeaderField: "Authorization")

		let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
			DispatchQueue.main.async(execute: {
				guard error == nil else {
					print(error!)
					return
				}
				guard let data = data else {
					print("no data retrieved")
					return
				}

				do {
					let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : Any]
					closure(json)
				} catch {
					print("error in JSONSerialization")
					return
				}

			})
		}

		task.resume()
	}

	/**
	 * options should contain two mandatory keys, and one optional key:
	 * route, indicating the endpoint, (not including the service url)
	 * data, whos value is a dictionary [String : Any] representing the
	 * data to send to the server
	 * expect(optional), whos value tells the data type to expect from server.
	 * currently only 'json' is accepted.
	 * if expect == 'json', a dictionary of [String : Any] will be passed to the closure
	 * if expect has any other value, a Data object will be passed to the closure
	 * if expect is omitted, the closure will not be called.
	 */
	static func POST(options: [String : Any], closure: @escaping (Any) -> Void) {

		guard let url = URL(string: serverapiURL + (options["route"] as! String)) else {
			print("cannot create URL from given route")
			return
		}
		guard let data = options["data"] as? [String : Any] else {
			print("no json data to send")
			return
		}

		var request = URLRequest(url: url)

		request.httpMethod = "POST"
		request.addValue("Bearer \(User.token)", forHTTPHeaderField: "Authorization")
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		request.addValue("application/json", forHTTPHeaderField: "Accept")

		do {
			let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)

			request.httpBody = jsonData
		} catch {
			print("error in JSONSerialization")
			return
		}

		let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

			guard error == nil else {
				print(error!)
				return
			}

			if let expected = options["expect"] as? String, let data = data {
				if expected == "json" {
					do {
						let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : Any]
						closure(json)
					} catch {
						print("error in JSONSerialization from server")
						return
					}
				} else {
					closure(data)
				}
			}
		}

		task.resume()
	}

	/**
	* options should contain two mandatory keys, and one optional key:
	* route, indicating the endpoint, (not including the service url)
	* data, whos value is a dictionary [String : Any] representing the
	* data to send to the server
	* expect(optional), whos value tells the data type to expect from server.
	* currently only 'json' is accepted.
	* if expect == 'json', a dictionary of [String : Any] will be passed to the closure
	* if expect has any other value, a Data object will be passed to the closure
	* if expect is omitted, the closure will not be called.
	*/
	static func PUT(options: [String : Any], closure: @escaping (Any) -> Void) {

		guard let url = URL(string: serverapiURL + (options["route"] as! String)) else {
			print("cannot create URL from given route")
			return
		}
		guard let data = options["data"] as? [String : Any] else {
			print("no json data to send")
			return
		}

		var request = URLRequest(url: url)

		request.httpMethod = "PUT"
		request.addValue("Bearer \(User.token)", forHTTPHeaderField: "Authorization")
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		request.addValue("application/json", forHTTPHeaderField: "Accept")

		do {
			let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)

			request.httpBody = jsonData
		} catch {
			print("error in JSONSerialization")
			return
		}

		let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

			guard error == nil else {
				print(error!)
				return
			}

			if let expected = options["expect"] as? String, let data = data {
				if expected == "json" {
					do {
						let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : Any]
						closure(json)
					} catch {
						print("error in JSONSerialization from server")
						return
					}
				} else {
					closure(data)
				}
			}
		}

		task.resume()
	}
}
