//
//  MenuCollectionViewController.swift
//  Restaurant Solution
//
//  Created by Danny Harding on 2/9/17.
//  Copyright © 2017 Danny Harding. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MenuItemCell"

class MenuItemsCollectionViewController: UICollectionViewController {

	@IBOutlet weak var categoryNavItem: UINavigationItem!

	var category: MenuCategory?

	override func viewDidLoad() {
		super.viewDidLoad()

		categoryNavItem.title = category?.name

		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false

		// Register cell classes  DONT NEED IN STORYBOARD?
		//        self.collectionView!.register(MenuItemCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// MARK: - Navigation

	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

		if segue.identifier == "showMenuItem", let nextScene = segue.destination as? MenuItemViewController {
			let cell = sender as! MenuItemCollectionViewCell
			let indexPath = self.collectionView?.indexPath(for: cell)
			let selectedMenuItem = category?.contents[(indexPath?.row)!]
			nextScene.menuItem = selectedMenuItem
		}
	}

	// MARK: UICollectionViewDataSource

	override func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}


	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if let category = category {
			return category.contents.count
		} else {
			return 0
		}
	}

	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MenuItemCollectionViewCell

		guard let category = category else {
			print("how did you select something when it's not there...")
			return cell
		}

		let menuItem = category.contents[indexPath.row]

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
