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
	var itemDescription: String = ""
	var itemLevel: Int = 0
	var itemModified: Bool = false
	var itemBaseLevel: Int = 0
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
	var featTier: FeatTier? = .Adventurer
	var featReqName: String? = "General"
	var featReqType: FeatPrereqType? = .General
	public enum FeatTier: String, Codable {
		case Adventurer
		case Champion
		case Epic
	}
	public enum Stat: String, Codable, CaseIterable{
		case STR = "Strength"
		case CON = "Constitution"
		case DEX = "Dexterity"
		case INT = "Intelligence"
		case WIS = "Wisdom"
		case CHA = "Charisma"
	}
	public enum FeatPrereqType: String, Codable, CaseIterable {
		static var allCases: [FeatPrereqType] {
			return [.CharRace,.CharClass,.General]
		}
			case General = "General"
			case CharRace = "Racial"
			case CharClass = "Class"
//			case Ability = "Ability"
	}
	
	init(itemName: String, itemDescription: String = "", itemLevel: Int = 0,itemSelected: Bool = false, baseLevel: Int = 0, listItemType: NavigationMenuItem.MenuName) {
		self.itemName = itemName
		self.itemDescription = itemDescription
		self.itemLevel = itemLevel
		self.itemModified = itemSelected
		self.itemBaseLevel = baseLevel
		self.listItemType = listItemType
	}
	init(characterStat: Stat, baseLevel: Int = 8, statDescription: String = "", statSelected: Bool = false){
		let stat = characterStat
		self.itemName = stat.rawValue
		self.itemBaseLevel = baseLevel
		self.itemDescription = statDescription
		self.itemModified = statSelected
		self.itemLevel = baseLevel
		self.listItemType = .statList
	}
	init(featName: String, featTier: FeatTier, description: String = "", requirement: String = "General", featReqType: FeatPrereqType = .General) {
		self.itemName = featName
		self.itemDescription = description
		self.featTier = featTier
		self.featReqName = requirement
		self.featReqType = featReqType
		self.listItemType = .featList
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
	func setSelection(status: Bool){
		itemModified = status
	}
}

struct FeatPrereq {
	var name: String
	var prereqType: LevelListItem.FeatPrereqType
	var tier: LevelListItem.FeatTier
}
