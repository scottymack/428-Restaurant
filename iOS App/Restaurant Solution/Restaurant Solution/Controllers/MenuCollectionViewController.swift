//
//  MenuCollectionViewController.swift
//  Restaurant Solution
//
//  Created by Danny Harding on 2/9/17.
//  Copyright © 2017 Danny Harding. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MenuItemCell"

class MenuCollectionViewController: UICollectionViewController {

	let jsonMenu = "{\"menu\":{\"id\":1,\"name\":\"quisquam\",\"description\":\"Laborum debitis quis ea et non.\",\"price\":\"16.29\",\"restaurant_id\":\"1\",\"created_at\":\"2017-02-04 07:07:46\",\"updated_at\":\"2017-02-04 07:07:46\"}}"

	var menu = [MenuItem]()

	override func viewDidLoad() {
		super.viewDidLoad()

		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false

		// Register cell classes
		//        self.collectionView!.register(MenuItemCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

		setMenu()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func setMenu() {
		let json = try! JSONSerialization.jsonObject(with: jsonMenu.data(using: .utf8)!, options: []) as! [String : Any]

		print(json)

		json.keys.forEach { item in
			menu.append(MenuItem(json: json[item] as! [String : Any]))
		}
	}

	// MARK: - Navigation

	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

		if let nextScene = segue.destination as? MenuItemViewController {
			let cell = sender as! MenuItemCollectionViewCell
			let indexPath = self.collectionView?.indexPath(for: cell)
			let selectedMenuItem = menu[(indexPath?.row)!]
			nextScene.menuItem = selectedMenuItem
		}
	}

	// MARK: UICollectionViewDataSource

	override func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}


	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return menu.count
	}

	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MenuItemCollectionViewCell
		let menuItem = menu[indexPath.row]
		print(menuItem.toString())
		print(menuItem.description)
		print(indexPath.row)

		print(cell.menuItemDescription)
		cell.name.text = menuItem.name
		cell.menuItemDescription.text = menuItem.description
		cell.price.text = menuItem.price

		return cell
	}

	// MARK: UICollectionViewDelegate

	/*
	// Uncomment this method to specify if the specified item should be highlighted during tracking
	override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
	return true
	}
	*/

	/*
	// Uncomment this method to specify if the specified item should be selected
	override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
	return true
	}
	*/

	/*
	// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
	override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
	return false
	}

	override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
	return false
	}

	override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {

	}
	*/

}
