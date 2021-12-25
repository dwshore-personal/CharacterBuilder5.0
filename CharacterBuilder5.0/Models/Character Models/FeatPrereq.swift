//
//  FeatPrereq.swift
//  CharacterBuilder5.0
//
//  Created by Derek Shore on 12/25/21.
//  Copyright © 2021 Luxumbra. All rights reserved.
//

import Foundation
class FeatPrereq: Codable, Equatable {
	static func == (lhs: FeatPrereq, rhs: FeatPrereq) -> Bool {
		return lhs.reqName == rhs.reqName
		}
	

	init(reqName: FeatPrereqName) {
		self.reqName = reqName
		self.none = true
	}
	init(reqName: FeatPrereqName, charRace: LevelListItem) {
		self.reqName = reqName
		self.charRace = charRace
		self.none = false
	}
	init(reqName: FeatPrereqName, charClass: LevelListItem){
		self.reqName = reqName
		self.charClass = charClass
		self.none = false
	}
	init(reqName: FeatPrereqName, ability: LevelListItem){
		self.reqName = reqName
		self.ability = ability
		self.none = false
	}
	
	var reqName: FeatPrereqName
	var charRace: LevelListItem?
	var charClass: LevelListItem?
	var ability: LevelListItem?
	var none: Bool
	
	public enum FeatPrereqName: String, Codable {
			case None
			case CharRace
			case CharClass
			case Ability
	}
	
}
