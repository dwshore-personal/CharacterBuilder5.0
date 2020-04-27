//
//  CharacterClasses.swift
//  CharacterBuilder5.0
//
//  Created by Derek Shore on 10/19/19.
//  Copyright © 2019 Luxumbra. All rights reserved.
//

import Foundation
class CharacterClassMenu: Codable {
	private var classList: [CharacterClassDetail] = [
		CharacterClassDetail(itemName: "Barbarian", itemDescription: "Heavy hitter", itemSelected: false),
		CharacterClassDetail(itemName: "Bard", itemDescription: "Sweet talker", itemSelected: false),
		CharacterClassDetail(itemName: "Wizard", itemDescription: "Wise ass", itemSelected: false)
	]
	
	func list() -> [CharacterClassDetail] {
		return classList
	}

	func selectClass(for classItem: CharacterClassDetail) {
		for item in classList {
			if item === classItem {
				item.itemModified = true
			} else {
				item.itemModified = false
			}
		}
	}


}


class CharacterClassDetail: LevelListItem {
	
/*
	var hpModifier: Int?
	var acModifierA: [String]?
	var acModifierB: [String]?
	var mdModifier: [String]?
	var pdModifier: [String]?
//	var recoveryDiceType: recoveryDiceType
	var recoveryDiceCount: Int?
	var meleeAttack: String?
	var meleeHit: String?
	var meleeMiss: String?
	var rangeAttack: String?
	var rangeHit: String?
	var rangeMiss: String?
	var acBonusA: Int?
	var acBonusB: Int?
	var pdBonus: Int?
	var mdBonus: Int?
	init(itemName: String, itemDescription: String = "", itemModified: Bool = false, hpModifier: Int, acModifierA: [String], acModifierB: [String], pdModifier: [String], recoveryDiceCount: Int, meleeAttack: String, meleeHit: String, meleeMiss: String, rangeAttack: String, rangeHit: String, rangeMiss: String, acBonusA: Int, acBonusB: Int, pdBonus: Int, mdBonus: Int) {
		self.itemName = itemName
		self.itemDescription = itemDescription
		self.itemSelected = itemSelected
		self.hpModifier = hpModifier
		self.acModifierA = acModifierA
		self.acModifierB = acModifierB
		self.pdModifier = pdModifier
		self.recoveryDiceCount = recoveryDiceCount
		self.meleeAttack = meleeAttack
		self.meleeMiss = meleeMiss
		self.meleeHit = meleeHit
		self.rangeAttack = rangeAttack
		self.rangeHit = rangeHit
		self.rangeMiss = rangeMiss
		self.acBonusA = acBonusA
		self.acBonusB = acBonusB
		self.pdBonus = pdBonus
		self.mdBonus = mdBonus
	}
	
	required init(from decoder: Decoder) throws {
		fatalError("init(from:) has not been implemented")
	}
*/
}
