//
//  CharacterFeats.swift
//  CharacterBuilder5.0
//
//  Created by Derek Shore on 1/21/20.
//  Copyright © 2020 Luxumbra. All rights reserved.
//

import Foundation
class CharacterFeatMenu: Codable {
	private var featList: [CharacterFeatDetail] = [
		CharacterFeatDetail(itemName: "Roll With It"),
		CharacterFeatDetail(itemName: "Spiky Bastard"),
		CharacterFeatDetail(itemName: "Sure Cut")
	]
	
	func fullList() -> [CharacterFeatDetail]{
		return featList
	}
	func selectionList(_ selected: Bool) -> [CharacterFeatDetail]{
		return featList.filter {$0.itemModified == selected}
	}
	
	func toggleSelection(_ feat: CharacterFeatDetail){
//		feat.itemModified = !feat.itemModified
		featList.filter {$0 === feat}.first?.itemModified = !feat.itemModified
	}
}

class CharacterFeatDetail: LevelListItem {
	/*
	var charRace: CharacterRaceDetail?
	var charClass: CharacterClassDetail?
	var featTier: Tier
	var prerequisite: CharacterBase.FeatPrereq

	enum Tier: String, Codable {
		case Adventurer
		case Champion
		case Epic
	}
	init(featName: String, charRace: CharacterRaceDetail, charClass: CharacterClassDetail, featTier: Tier, prerequisite: CharacterBaseClass.FeatPrereq){
		self.charRace = charRace
		self.charClass = charClass
		self.featTier = featTier
		self.prerequisite = prerequisite
		super.init(itemName: featName)
	}
	
	required init(from decoder: Decoder) throws {
		fatalError("init(from:) has not been implemented")
	}
	*/
}
