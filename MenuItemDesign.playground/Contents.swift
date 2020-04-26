import UIKit
import Foundation

/*
class SimpleList {
	var itemName: String = ""
	var itemDescription: String = ""
	var itemSelected: Bool = false
	init(itemName: String, itemDescription: String = "", itemSelected: Bool = false) {
		self.itemName = itemName
		self.itemDescription = itemDescription
		self.itemSelected = itemSelected
	}
}

class CharacterClass: SimpleList {
	var statA: Int = 0
}

var classTest = CharacterClass(itemName: "exampleA")


//
//  NavigationMenuItem.swift
//  CharacterBuilder5.0
//
//  Created by Derek Shore on 11/3/19.
//  Copyright © 2019 Luxumbra. All rights reserved.
//

import Foundation
class NavigationMenuItem: NSObject {
	public enum MenuName: String {
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
	}
	public enum MenuSegue: String {
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


import Foundation
import UIKit
class NavigationMenuList {
	private var navigationMenuList: [NavigationMenuItem] = [
	NavigationMenuItem(menuName: .characterName, modified: false, menuSegue: .showPopup, menuDescription: ""),
	NavigationMenuItem(menuName: .classList, modified: false, menuSegue: .showSimpleList, menuDescription: ""),
	NavigationMenuItem(menuName: .raceList, modified: false, menuSegue: .showSimpleList, menuDescription: ""),
//	NavigationMenuItem(menuName: .statList, modified: false, menuSegue: .showLevelList, menuDescription: ""),
//	NavigationMenuItem(menuName: .abilityList, modified: false, menuSegue: .showOptionList, menuDescription: ""),
//	NavigationMenuItem(menuName: .spellList, modified: false, menuSegue: .showOptionList, menuDescription: ""),
//	NavigationMenuItem(menuName: .featList, modified: false, menuSegue: .showOptionList, menuDescription: ""),
//	NavigationMenuItem(menuName: .iconRelationship, modified: false, menuSegue: .showLevelList, menuDescription: ""),
//	NavigationMenuItem(menuName: .backgrounds, modified: false, menuSegue: .showLevelList, menuDescription: ""),
//	NavigationMenuItem(menuName: .equipment, modified: false, menuSegue: .showLevelList, menuDescription: "")
	]
	func menuList() -> [NavigationMenuItem]{
		return navigationMenuList
	}
	func updateNavigationMenuListDescription(menuName: NavigationMenuItem.MenuName, menuDescription: String, modified: Bool = true) {
		let menuSelection = navigationMenuList.filter {$0.menuName == menuName} .first
		menuSelection?.menuDescription = menuDescription
		menuSelection?.modified = modified
		print("description: \(String(describing: menuSelection?.menuDescription)), modified: \(String(describing: menuSelection?.modified))")
	}
}


var menu = NavigationMenuList()
menu.updateNavigationMenuListDescription(menuName: .raceList, menuDescription: "barb", modified: true)

let menuSelection = menu.menuList().filter {$0.menuName == .raceList} .first
menuSelection
*/


class CharacterBaseClass {
	var charID: UUID!
	var charName: String
	var charClass: String?
	var charRace: String?
	init(charName: String) {
		self.charName = charName
		charID = UUID()
	}
	enum CharacterFeature: CaseIterable {
		case charClass, charRace, charName
	}
}

var base = CharacterBaseClass(charName: "test")

struct CharacterClass : Codable {
	var name: String
	var description: String
	var hpModifier: Int
	var acModifierA: [Stats]
	var acModifierB: [Stats]
	var mdModifier: [Stats]
	var pdModifier: [Stats]
//	var recoveryDiceType: recoveryDiceType
	var recoveryDiceCount: Int
	var meleeAttack: String
	var meleeHit: String
	var meleeMiss: String
	var rangeAttack: String
	var rangeHit: String
	var rangeMiss: String
	var acBonusA: Int
	var acBonusB: Int
	var pdBonus: Int
	var mdBonus: Int
	
	enum Stats: String, Codable, CaseIterable {
		case STR
		case CON
		case DEX
		case INT
		case WIS
		case CHA
	}
	
		
}

var test: Dictionary<<#Key: Hashable#>, Any>
