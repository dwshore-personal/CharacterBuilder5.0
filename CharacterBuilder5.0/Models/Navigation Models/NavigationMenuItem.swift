//
//  NavigationMenuItem.swift
//  CharacterBuilder5.0
//
//  Created by Derek Shore on 11/3/19.
//  Copyright © 2019 Luxumbra. All rights reserved.
//

import Foundation
class NavigationMenuItem: NSObject, Codable {
	public enum MenuName: String, CaseIterable, Codable {
		case characterName = "Character Name"
		case classList = "Class"
		case raceList = "Race"
		case statList = "Stats"
		case abilityList = "Abilities"
		case spellList = "Spells"
		case featList = "Feats"
		case iconRelationship = "Icon Relationship"
		case backgrounds = "Backgrounds"
		case equipment = "Equipment"
		case uniqueThing = "One Unique Thing"
	}
	public enum MenuSegue: String, Codable {
		case showPopup = "showPopup"
		case showSimpleList = "showSimple"
		case showLevelList = "showLevel"
		case showOptionList = "showOption"
	}
	var menuName: MenuName
	var modified: Bool
	var menuSegue: MenuSegue
	var menuDescription: String
	
	init(menuName: MenuName, modified: Bool = false, menuSegue: MenuSegue, menuDescription: String = ""){
		self.menuName = menuName
		self.modified = modified
		self.menuSegue = menuSegue
		self.menuDescription = menuDescription
	}
	func updateMenuDescription(with menuDescription: String){
		self.menuDescription = menuDescription
		print("used built in description update")
	}
	func updateMenuModified(with menuState: Bool) {
		self.modified = menuState
		print("used build in modified update")
	}
	
}
