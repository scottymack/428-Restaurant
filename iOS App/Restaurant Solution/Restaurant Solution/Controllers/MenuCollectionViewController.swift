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

	var menu: Menu?
	var currentCategory: MenuCategory?

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
		ServerCommunicator.GET(route: "/restaurants/menus/2") { data in
			guard let restaurant = data["restaurant"] as! [String : Any]?, let menuCategories = restaurant["menu_categories"] as! [[String : Any]]? else {
				print("no restaurant or menu")
				return
			}

			self.menu = Menu(json: menuCategories)
			self.currentCategory = MenuCategory(json: menuCategories[0]) // Maybe get this from the menu?

			self.collectionView?.reloadData()
		}
	}

	// MARK: - Navigation

	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

		if let nextScene = segue.destination as? MenuItemViewController {
			let cell = sender as! MenuItemCollectionViewCell
			let indexPath = self.collectionView?.indexPath(for: cell)
			let selectedMenuItem = currentCategory?.contents[(indexPath?.row)!]
			nextScene.menuItem = selectedMenuItem
		}
	}

	// MARK: UICollectionViewDataSource

	override func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}


	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if let category = currentCategory {
			return category.contents.count
		} else {
			return 0
		}
	}

	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MenuItemCollectionViewCell

		guard let category = currentCategory else {
			print("how did you select something when it's not there...")
			return cell
		}

		let menuItem = category.contents[indexPath.row]
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
