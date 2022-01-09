//
//  LevelListDictionary.swift
//  CharacterBuilder5.0
//
//  Created by Derek Shore on 1/7/22.
//  Copyright © 2022 Luxumbra. All rights reserved.
//

import Foundation
class LevelListDictionary: Codable {
	var itemList: [String: LevelListArray]
	var selectionLimit: Int?
	var isSet: Bool?
	
	init(listType: String, selectionLimit: Int = 1, list: LevelListArray){
		self.itemList = [listType: list]
		self.selectionLimit = selectionLimit
		self.isSet = false
	}
	
	
	
	
//	ENTIRE LIST FUNCTIONS
	func updateListByName(_ name: String, list: LevelListArray, updateType: PublicLists.EntryUpdateType){
		switch updateType{
		case .Delete:
			itemList.removeValue(forKey: name)
		default:
			itemList.updateValue(list, forKey: name)
		}
	}
	func updateListByIndex(_ indexPath: IndexPath, list: LevelListArray, updateType: PublicLists.EntryUpdateType){
		switch updateType {
		case .Delete:
			itemList.removeValue(forKey: Array(itemList)[indexPath.section].key)
		default:
			itemList.updateValue(list, forKey: Array(itemList)[indexPath.section].key)
		}
		
	}
	
//	LIST ENTRY FUNCTIONS
	func updateListItemByIndex(_ indexPath: IndexPath, updateType: PublicLists.EntryUpdateType, item: LevelListItem){
		switch updateType {
		case .Delete:
			if Array(itemList)[indexPath.section].value.levelListItems.contains(where: {$0 == item}) {
				Array(itemList)[indexPath.section].value.deleteListItem(item)
			} else {
				print("LevelListDictionary-- deleteListItemByIndex-- Could not find \(item.itemName) and indicated path: \(indexPath.description)")
			}
		default:
			if Array(itemList)[indexPath.section].value.levelListItems.contains(where: {$0 == item}) {
				Array(itemList)[indexPath.section].value.updateListItem(item)
			} else {
				Array(itemList)[indexPath.section].value.addListItem(item)
			}

		}
	}
	func updateListItemByName(_ name: String, updateType: PublicLists.EntryUpdateType, item: LevelListItem){
		switch updateType {
		case .Delete:
			itemList[name]?.deleteListItem(item)
		default:
			itemList[name]?.updateListItem(item)
		}
	}
	
	
	
	
}
