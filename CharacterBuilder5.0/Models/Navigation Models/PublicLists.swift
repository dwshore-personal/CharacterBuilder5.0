//
//  PublicENUMS.swift
//  CharacterBuilder5.0
//
//  Created by Derek Shore on 12/24/21.
//  Copyright © 2021 Luxumbra. All rights reserved.
//

import Foundation
class PublicLists: Codable {
	 public var featList: [LevelListItem] = [
		LevelListItem(itemName: "Roll With It"),
		LevelListItem(itemName: "Spiky Bastard"),
		LevelListItem(itemName: "Sure Cut")
	]
	public var classList: [LevelListItem] = [
		LevelListItem(itemName: "Barbarian", itemDescription: "Heavy hitter", itemSelected: false),
		LevelListItem(itemName: "Bard", itemDescription: "Sweet talker", itemSelected: false),
		LevelListItem(itemName: "Wizard", itemDescription: "Wise ass", itemSelected: false)
	]
	public var raceList: [LevelListItem] = [
		LevelListItem(itemName: "Human", itemDescription: "Boring", itemSelected: false),
		LevelListItem(itemName: "Elf", itemDescription: "Jumpy", itemSelected: false),
		LevelListItem(itemName: "Dwarf", itemDescription: "Short", itemSelected: false)
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
		LevelListItem(itemName: "The Three"),
		LevelListItem(itemName: "The Diabolist"),
		LevelListItem(itemName: "The Crusader"),
		LevelListItem(itemName: "The Priestess")
	]
}
