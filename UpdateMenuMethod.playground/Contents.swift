import UIKit
import Foundation

class CurrentCharacter {
	var charClass: LevelListItem?
	var charRace: LevelListItem?
}


class LevelListItem: Codable, Equatable {
	static func == (lhs: LevelListItem, rhs: LevelListItem) -> Bool {
		return lhs.itemName == rhs.itemName && lhs.itemDescription == rhs.itemDescription && lhs.itemLevel == rhs.itemLevel
	}
	var itemName: String
	var itemDescription: String
	var itemLevel: Int
	var itemModified: Bool
	var baseLevel: Int
	init(itemName: String, itemDescription: String = "", itemLevel: Int = 0,itemSelected: Bool = false, baseLevel: Int = 0) {
		self.itemName = itemName
		self.itemDescription = itemDescription
		self.itemLevel = itemLevel
		self.itemModified = itemSelected
		self.baseLevel = baseLevel
	}
	
	func setLevel(newLevel: Int) {
		self.itemLevel = newLevel
		if self.itemLevel != baseLevel {
			self.itemModified = true
		} else {
			self.itemModified = false
		}
	}
}
enum MenuName: String, CaseIterable, Codable {
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
var classData: [LevelListItem] = [
	LevelListItem(itemName: "Barbarian", itemDescription: "Heavy hitter", itemSelected: false),
	LevelListItem(itemName: "Bard", itemDescription: "Sweet talker", itemSelected: false),
	LevelListItem(itemName: "Wizard", itemDescription: "Wise ass", itemSelected: false)
]

var raceData: [LevelListItem] = [
	LevelListItem(itemName: "Human", itemDescription: "Boring", itemSelected: false),
	LevelListItem(itemName: "Elf", itemDescription: "Jumpy", itemSelected: false),
	LevelListItem(itemName: "Dwarf", itemDescription: "Short", itemSelected: false)
]

var currentCharacter = CurrentCharacter()
var indexPath = IndexPath(row: 0, section: 1)

func update(_ data: [LevelListItem], menu: MenuName) {
	
}
