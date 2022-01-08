//
//  LevelListArray.swift
//  CharacterBuilder5.0
//
//  Created by Derek Shore on 12/18/21.
//  Copyright © 2021 Luxumbra. All rights reserved.
//

import Foundation

class LevelListArray: Codable, Equatable {
	static func == (lhs: LevelListArray, rhs: LevelListArray) -> Bool {
		return lhs.levelListItems == rhs.levelListItems && lhs.selectionLimit == rhs.selectionLimit

	}
	var levelListItems: [LevelListItem]
	var selectionLimit: Int?
	var isSet: Bool?
	var arrayTitle: String?
	
	
	
	init(title: String = "", levelListItems: [LevelListItem]) {
		self.levelListItems = levelListItems
		self.arrayTitle = title
	}
	init(title: String = "", selectionLimit: Int, levelListItems: [LevelListItem]) {
		self.levelListItems = levelListItems
		self.selectionLimit = selectionLimit
		self.arrayTitle = title
	}
	
//	RETURN LISTS
	func fullList() -> [LevelListItem]{
		return levelListItems
	}
	func selectionList(_ selected: Bool) -> [LevelListItem]{
		return levelListItems.filter {$0.itemModified == selected}
	}
	
//	MAKE CHANGES TO LISTS
	func addListItem(_ listItem: LevelListItem) {
		let index = levelListItems.count
		if index == 0 {
			print("[LevelListArray]-- addListItem at beginning of list")
			levelListItems.append(listItem)
		} else {
			print("[LevelListArray]-- addListItem at index")
			levelListItems.insert(listItem, at: index)
		}
	}
	func deleteListItem(_ listItem: LevelListItem){
		print("[LevelListArray]-- deleteListItem")
		let index = levelListItems.firstIndex(of: listItem)
		levelListItems.remove(at: index!)
	}
	func updateListItem(_ listItem: LevelListItem, with level: Int = 0){
		if let index = levelListItems.firstIndex(of: listItem) {
			print("[LevelListArray]-- updateListItem entire listItem")
			levelListItems[index] = listItem
		} else {
			print("[LevelListArray]-- updateListItem itemLevel")
			let selectedListItem = levelListItems.filter { $0 == listItem}.first
			selectedListItem?.itemLevel = level
		}
		listItem.setSelection(status: (level != listItem.itemBaseLevel))
	}
	
// HANDLE SELECTIONS
	func selectItem(for selectedItem: LevelListItem) {
		for item in levelListItems {
			if item === selectedItem {
				item.setSelection(status: true)
			} else {
				item.setSelection(status: false)
			}
		}
	}
	
	func toggleSelection(_ selection: LevelListItem) {
		levelListItems.filter { $0 === selection }.first?.toggle()
	}

	
}
