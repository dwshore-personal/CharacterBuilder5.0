//
//  CharacterStats.swift
//  CharacterBuilder5.0
//
//  Created by Derek Shore on 11/16/19.
//  Copyright © 2019 Luxumbra. All rights reserved.
//

import Foundation
class CharacterStatMenu: Codable {
	private var statList: [CharacterStatDetail] = [
		CharacterStatDetail(characterStat: .STR, baseLevel: 8, statDescription: "Smash", statSelected: false),
		CharacterStatDetail(characterStat: .CON),
		CharacterStatDetail(characterStat: .DEX),
		CharacterStatDetail(characterStat: .INT),
		CharacterStatDetail(characterStat: .WIS),
		CharacterStatDetail(characterStat: .CHA)
	]
	func list() -> [CharacterStatDetail]{
		return statList
	}
}


class CharacterStatDetail: LevelListItem {
	init(characterStat: Stat, baseLevel: Int = 8, statDescription: String = "", statSelected: Bool = false){
		self.characterStat = characterStat
//		self.baseLevel = baseLevel
		super.init(itemName: characterStat.rawValue, itemDescription: statDescription, itemLevel: baseLevel, itemSelected: statSelected, baseLevel: baseLevel)
	}
	
	required init(from decoder: Decoder) throws {
		fatalError("init(from:) has not been implemented")
	}
//	var baseLevel: Int
	var characterStat: Stat?
	enum Stat: String, Codable, CaseIterable{
		case STR = "Strength"
		case CON = "Constitution"
		case DEX = "Dexterity"
		case INT = "Intelligence"
		case WIS = "Wisdom"
		case CHA = "Charisma"
	}
	/*
	func setLevel(newLevel: Int) {
		self.itemLevel = newLevel
		if self.itemLevel != baseLevel {
			self.itemModified = true
		} else {
			self.itemModified = false
		}
	}
	*/
}
