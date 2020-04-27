//
//  LevelListItem.swift
//  CharacterBuilder5.0
//
//  Created by Derek Shore on 11/10/19.
//  Copyright © 2019 Luxumbra. All rights reserved.
//

import Foundation

class LevelListItem: Codable, Equatable {
	static func == (lhs: LevelListItem, rhs: LevelListItem) -> Bool {
		return lhs.itemName == rhs.itemName && lhs.itemDescription == rhs.itemDescription && lhs.itemLevel == rhs.itemLevel
	}
	var itemName: String
	var itemDescription: String
	var itemLevel: Int
	var itemModified: Bool
	var baseLevel: Int
	init(itemName: String, itemDescription: String = "", itemLevel: Int = 0,itemSelected: Bool = false, baseLevel: Int = 0) {
		self.itemName = itemName
		self.itemDescription = itemDescription
		self.itemLevel = itemLevel
		self.itemModified = itemSelected
		self.baseLevel = baseLevel
	}
	
	func setLevel(newLevel: Int) {
		self.itemLevel = newLevel
		if self.itemLevel != baseLevel {
			self.itemModified = true
		} else {
			self.itemModified = false
		}
	}
	func toggle(){
		itemModified = !itemModified
	}
}
