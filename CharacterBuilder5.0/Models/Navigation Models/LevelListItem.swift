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
	var itemBaseLevel: Int
	var classHPModifier: Int?
	var classACModifierA: [String]?
	var classACModifierB: [String]?
	var classMDModifier: [String]?
	var classPDModifier: [String]?
//	var classRecoveryDiceType: recoveryDiceType
	var classRecoveryDiceCount: Int?
	var classMeleeAttack: String?
	var classMeleeHit: String?
	var classMeleeMiss: String?
	var classRangeAttack: String?
	var classRangeHit: String?
	var classRangeMiss: String?
	var classACBonusA: Int?
	var classACBonusB: Int?
	var classPDBonus: Int?
	var classMDBonus: Int?
	var listItemType: NavigationMenuItem.MenuName?
	var featPrereq: FeatPrereq?
	var featTier: Tier?
	enum Tier: String, Codable {
		case Adventurer
		case Champion
		case Epic
	}
	enum Stat: String, Codable, CaseIterable{
		case STR = "Strength"
		case CON = "Constitution"
		case DEX = "Dexterity"
		case INT = "Intelligence"
		case WIS = "Wisdom"
		case CHA = "Charisma"
	}
	
	init(itemName: String, itemDescription: String = "", itemLevel: Int = 0,itemSelected: Bool = false, baseLevel: Int = 0) {
		self.itemName = itemName
		self.itemDescription = itemDescription
		self.itemLevel = itemLevel
		self.itemModified = itemSelected
		self.itemBaseLevel = baseLevel
	}
	init(characterStat: Stat, baseLevel: Int = 8, statDescription: String = "", statSelected: Bool = false){
		let stat = characterStat
		self.itemName = stat.rawValue
		self.itemBaseLevel = baseLevel
		self.itemDescription = statDescription
		self.itemModified = statSelected
		self.itemLevel = baseLevel
	}
	
	
	func setLevel(newLevel: Int) {
		self.itemLevel = newLevel
		if self.itemLevel != itemBaseLevel {
			self.itemModified = true
		} else {
			self.itemModified = false
		}
	}
	func toggle(){
		itemModified = !itemModified
	}
	func setSelection(isSelected: Bool){
		itemModified = isSelected
	}
}
