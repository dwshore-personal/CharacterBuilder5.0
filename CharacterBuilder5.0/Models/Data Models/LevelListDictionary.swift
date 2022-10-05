//
//  LevelListDictionary.swift
//  CharacterBuilder5.0
//
//  Created by Derek Shore on 1/7/22.
//  Copyright © 2022 Luxumbra. All rights reserved.
//

import Foundation
class LevelListDictionary: Codable {
	var itemList: [NavigationMenuItem.MenuName: [LevelListItem]]
	var selectionLimit: Int?
	var isSet: Bool?
	
	init(listType: NavigationMenuItem.MenuName, selectionLimit: Int = 1, list: [LevelListItem]){
		self.itemList = [listType: list]
		self.selectionLimit = selectionLimit
		self.isSet = false
	}
	
	
	
//	LIST OUTPUTS
	func fullList(of menuName: NavigationMenuItem.MenuName) -> [LevelListItem] {
		return itemList[menuName]!
	}
	
	func selectionList(of menuName: NavigationMenuItem.MenuName, selectedState: Bool) -> [LevelListItem]{
		return itemList[menuName]!.filter { $0.itemModified == selectedState}
	}
	
	
//	ENTIRE LIST FUNCTIONS
	func updateListByName(_ name: NavigationMenuItem.MenuName, list: [LevelListItem], updateType: PublicLists.EntryUpdateType){
		switch updateType{
		case .Delete:
			itemList.removeValue(forKey: name)
		case .Add:
			itemList[name] = list
		default:
			itemList.updateValue(list, forKey: name)
		}
	}
	
	func updateListByIndex(_ indexPath: IndexPath, list: [LevelListItem], updateType: PublicLists.EntryUpdateType){
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
			if Array(itemList)[indexPath.section].value.contains(where: {$0 == item}) {
				Array(itemList)[indexPath.section].value.
			} else {
				print("LevelListDictionary-- deleteListItemByIndex-- Could not find \(item.itemName) and indicated path: \(indexPath.description)")
			}
		case .Add:
			Array(itemList)[indexPath.section].value.levelListItems[indexPath.row] = item
		default:
			if Array(itemList)[indexPath.section].value.levelListItems.contains(where: {$0 == item}) {
				Array(itemList)[indexPath.section].value.updateListItem(item)
			} else {
				Array(itemList)[indexPath.section].value.addListItem(item)
			}

		}
	}
	func updateListItemByName(_ name: NavigationMenuItem.MenuName, updateType: PublicLists.EntryUpdateType, item: LevelListItem){
		switch updateType {
		case .Delete:
			itemList[name]?.deleteListItem(item)
		case .Add:
			itemList[name]?.addListItem(item)
		default:
			itemList[name]?.updateListItem(item)
		}
	}
	
	
	
	
}
