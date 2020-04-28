//
//  NavigationMenuList.swift
//  CharacterBuilder5.0
//
//  Created by Derek Shore on 10/19/19.
//  Copyright © 2019 Luxumbra. All rights reserved.
//

import Foundation
import UIKit
class NavigationMenuList {
	private var navigationMenuList: [NavigationMenuItem] = [
		NavigationMenuItem(menuName: .characterName, 	menuSegue: .showPopup),
		NavigationMenuItem(menuName: .classList, 		menuSegue: .showSimpleList),
		NavigationMenuItem(menuName: .raceList, 		menuSegue: .showSimpleList),
		NavigationMenuItem(menuName: .statList, 		menuSegue: .showLevelList),
		NavigationMenuItem(menuName: .backgrounds, 		menuSegue: .showLevelList),
//		NavigationMenuItem(menuName: .iconRelationship,	menuSegue: .showLevelList),
//		NavigationMenuItem(menuName: .featList, 		menuSegue: .showOptionList),
//		NavigationMenuItem(menuName: .abilityList, 		menuSegue: .showOptionList),
//		NavigationMenuItem(menuName: .spellList, 		menuSegue: .showOptionList),
//		NavigationMenuItem(menuName: .equipment, 		menuSegue: .showLevelList)
		NavigationMenuItem(menuName: .uniqueThing, 		menuSegue: .showPopup)
	]
	func menuList() -> [NavigationMenuItem]{
		return navigationMenuList
	}
	func updateMenuFromCharacterSettings(character: CharacterBase){
		for menu in navigationMenuList {
			var newDescription = ""
			var isSet = false
			switch menu.menuName {
//	CHARACTER NAME
			case .characterName:
				newDescription = character.charName
				isSet = !character.charName.isEmpty
			case .classList:
				newDescription = character.charClass?.itemName ?? ""
				isSet = character.charClass?.itemModified ?? false
			case .raceList:
				newDescription = character.charRace?.itemName ?? ""
				isSet = character.charRace?.itemModified ?? false
			case .statList:
				isSet = character.charStatsModified 
				if isSet {
					newDescription = "All stats have been updated."
				}
//	BACKGROUNDS
			case .backgrounds:
				switch character.characterBackgrounds.count {
				case 0:
					newDescription = "No backgrounds have been added yet."
					isSet = false
				case 1...3 :
					newDescription = "\(character.characterBackgrounds.count) backgrounds have been set."
					isSet = false
				default:
					newDescription = "Backgrounds have been added."
					isSet = true
				}
//	ICON RELATIONSHIP
			case .iconRelationship:
				switch character.characterIcons.selectionList(true).count {
				case 0:
					newDescription = "No icons have been added yet."
					isSet = false
				case 1...2 :
					newDescription = "\(character.characterIcons.selectionList(true).count) icons have been set."
					isSet = false
				default:
					newDescription = "Icons have been added."
					isSet = true
				}
//	ONE UNIQUE THING
			case .uniqueThing:
				isSet = (character.characterUniqueThing != "")
//				let descriptionLength = character.characterUniqueThing.count
//				if descriptionLength > 20 {
//					newDescription = String(character.characterUniqueThing.dropLast(character.characterUniqueThing.count - 20))+"..."
//				} else {
					newDescription = character.characterUniqueThing
//				}
			default:
				return
			}
			menu.menuDescription = newDescription
			menu.modified = isSet
		}
	}
}
