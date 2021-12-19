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
		return lhs.levelListItems == rhs.levelListItems

	}
	var levelListItems: [LevelListItem]
	
	
	init(levelListItems: [LevelListItem]) {
		self.levelListItems = levelListItems
	}
	
	func fullList() -> [LevelListItem]{
		return levelListItems
	}
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
	func updateListItem(_ listItem: LevelListItem, with level: Int){
		if let index = levelListItems.firstIndex(of: listItem) {
			print("[LevelListArray]-- updateListItem entire listItem")
			levelListItems[index] = listItem
		} else {
			print("[LevelListArray]-- updateListItem itemLevel")
			let selectedListItem = levelListItems.filter { $0 == listItem}.first
			selectedListItem?.itemLevel = level
		}
		if level != 0 {
			print("[LevelListArray]-- toggle selected")
			listItem.toggle()
		}
	}
	func selectionList(_ selected: Bool) -> [LevelListItem]{
		return levelListItems.filter {$0.itemModified == selected}
	}
	
	func toggleSelection(_ icon: LevelListItem) {
		levelListItems.filter { $0 === icon }.first?.itemModified = !icon.itemModified
	}

	
}
