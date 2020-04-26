//
//  CharacterRaces.swift
//  CharacterBuilder5.0
//
//  Created by Derek Shore on 10/19/19.
//  Copyright © 2019 Luxumbra. All rights reserved.
//

import Foundation
//		Used in the character creation and updating models and methods
class CharacterRaceMenu: Codable {
	private var raceList: [CharacterRaceDetail] = [
		CharacterRaceDetail(itemName: "Human", itemDescription: "Boring", itemSelected: false),
		CharacterRaceDetail(itemName: "Elf", itemDescription: "Jumpy", itemSelected: false),
		CharacterRaceDetail(itemName: "Dwarf", itemDescription: "Short", itemSelected: false)
	]
	func list() -> [CharacterRaceDetail] {
		return raceList
	}
	func selectRace(for raceItem: CharacterRaceDetail){
		for item in raceList {
			if item === raceItem {
				item.itemModified = true
			} else {
				item.itemModified = false
			}
		}
	}
}

//		Used to update the character itself
class CharacterRaceDetail: LevelListItem {

}
