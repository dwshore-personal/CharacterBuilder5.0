//
//  CharacterBaseData.swift
//  CharacterBuilder5.0
//
//  Created by Derek Shore on 11/5/19.
//  Copyright © 2019 Luxumbra. All rights reserved.
//

import Foundation

class CharacterData {
	var playerCharacter: CharacterBase?
	func createNewCharacter(forCharacter name: String) {
		print("CharacterBase-- createNewCharacter-- creating new character with name: \(name)")
		playerCharacter = CharacterBase(charName: name)
	}
}

class CharacterBase: Codable {
	var charID: String!
	var charName: String
	var elementList: [NavigationMenuItem]
	var charClass: LevelListItem?
	var charRace: LevelListItem?
	var charStats: LevelListArray?
	var charStatsModified: Bool
	var characterBackgrounds: LevelListArray?
	var characterIcons: LevelListArray?
	var characterUniqueThing: String
	var charFeats: LevelListArray?
	init(charName: String) {
		self.charName = charName
		charID = UUID().uuidString
		charStats = LevelListArray(levelListItems: PublicLists().statList)
		charStatsModified = false
		characterBackgrounds = LevelListArray(levelListItems: [])
		characterIcons = LevelListArray(levelListItems: PublicLists().iconList)
		characterUniqueThing = ""
		elementList = NavigationMenuList().menuList()
		charFeats = LevelListArray(levelListItems: PublicLists().featList)
	}
	func updateName(new name:String){
		print("CharacterBase-- updateName-- running internal update name")
		charName = name
	}
	func updateOneUniqueThing(_ description: String){
		characterUniqueThing = description
	}
	
	func addElement(targetElement selection: LevelListItem, elementType: NavigationMenuItem.MenuName, level: Int){
		print("CharacterBase-- addElement-- adding new element type: " + elementType.rawValue + selection.itemName)
		switch elementType {
		case .statList:
			charStats?.updateListItem(selection, with: level)
		case .iconRelationship:
			characterIcons?.updateListItem(selection, with: level)
		case .featList:
			charFeats?.updateListItem(selection)
		case .backgrounds:
			characterBackgrounds?.addListItem(selection)
		default:
			print("CharacterBase-- addElement-- selected menu item not applicable")
		}
	}
	func deleteElement(targetElement selection: LevelListItem, elementType: NavigationMenuItem.MenuName){
		print("CharacterBase-- deleteElement-- removing selection: " + selection.itemName)
		switch elementType {
		case .featList:
			charFeats?.deleteListItem(selection)
		case .backgrounds:
			characterBackgrounds?.deleteListItem(selection)
		case .iconRelationship:
			characterIcons?.deleteListItem(selection)
		default:
			print("CharacterBase-- deleteElement-- selected menu item not applicable")
		}
	}
	func updateElement(targetElement selection: LevelListItem, elementType: NavigationMenuItem.MenuName, level: Int = 0){
		print("CharacterBase-- updateElement-- updating: " + selection.itemName + " with type: " + elementType.rawValue)
		
		switch elementType {
		case .featList:
			charFeats?.updateListItem(selection)
		case .classList:
			charClass = selection
		case .raceList:
			charRace = selection
		case .statList:
			charStats?.updateListItem(selection, with: level)
// CHECK IF ALL STATS HAVE BEEN MODIFIED
			var modifiedStats: Int = 0
			for stat in charStats!.fullList() {
				if stat.itemModified {
					modifiedStats += 1
				}
			}
			charStatsModified = {modifiedStats == charStats?.fullList().count}()
		case .backgrounds:
			characterBackgrounds?.updateListItem(selection, with: level)
		case .iconRelationship:
			characterIcons?.updateListItem(selection, with: level)
		default:
			print("CharacterBase-- updateElement-- selected menu item not applicable")
		}
		
	}	
//	End of Class
}
