//
//  PublicENUMS.swift
//  CharacterBuilder5.0
//
//  Created by Derek Shore on 12/24/21.
//  Copyright © 2021 Luxumbra. All rights reserved.
//

import Foundation
class PublicLists: Codable {
	public var featList: FeatList = FeatList(featGroups: [
		FeatSubList(type: .General, feats: LevelListArray(levelListItems: [
			LevelListItem(featName: "Am a general", featTier: .Adventurer),
			LevelListItem(featName: "Another general", featTier: .Adventurer),
			LevelListItem(featName: "A champion", featTier: .Champion)
		])),
		FeatSubList(type: .CharRace, name: "Dwarf", feats: LevelListArray(levelListItems: [
			LevelListItem(featName: "Be a dwarf", featTier: .Adventurer),
			LevelListItem(featName: "Tallest dwarf", featTier: .Adventurer),
			LevelListItem(featName: "Not tall", featTier: .Champion)
		])),
		FeatSubList(type: .CharClass, name: "Barbarian", feats: LevelListArray(levelListItems: [
			LevelListItem(featName: "Be a barby", featTier: .Adventurer),
			LevelListItem(featName: "Be a big boy", featTier: .Adventurer),
			LevelListItem(featName: "Be a champion", featTier: .Champion)
		]))
	])
	
	
	public var classList: [LevelListItem] = [
		LevelListItem(itemName: "Barbarian", itemDescription: "Heavy hitter", itemSelected: false, listItemType: .classList),
		LevelListItem(itemName: "Bard", itemDescription: "Sweet talker", itemSelected: false, listItemType: .classList),
		LevelListItem(itemName: "Wizard", itemDescription: "Wise ass", itemSelected: false, listItemType: .classList)
	]
	public var raceList: [LevelListItem] = [
		LevelListItem(itemName: "Human", itemDescription: "Boring", itemSelected: false, listItemType: .raceList),
		LevelListItem(itemName: "Elf", itemDescription: "Jumpy", itemSelected: false, listItemType: .raceList),
		LevelListItem(itemName: "Dwarf", itemDescription: "Short", itemSelected: false, listItemType: .raceList)
	]
	public var statList: [LevelListItem] = [
		LevelListItem(characterStat: .STR, baseLevel: 8, statDescription: "Smash", statSelected: false),
		LevelListItem(characterStat: .CON),
		LevelListItem(characterStat: .DEX),
		LevelListItem(characterStat: .INT),
		LevelListItem(characterStat: .WIS),
		LevelListItem(characterStat: .CHA)
	]
	public var iconList: [LevelListItem] = [
		LevelListItem(itemName: "The Three", listItemType: .iconRelationship),
		LevelListItem(itemName: "The Diabolist", listItemType: .iconRelationship),
		LevelListItem(itemName: "The Crusader", listItemType: .iconRelationship),
		LevelListItem(itemName: "The Priestess", listItemType: .iconRelationship)
	]
}
