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
	var charClass: CharacterClassDetail?
	var charRace: CharacterRaceDetail?
	var charStats: [CharacterStatDetail]
	var charStatsModified: Bool
	var characterBackgrounds: [CharacterBackgroundDetail]
	var characterIcons: CharacterIconMenu
	var characterUniqueThing: String
	init(charName: String) {
		self.charName = charName
		charID = UUID().uuidString
		charStats = CharacterStatMenu().list()
		charStatsModified = false
		characterBackgrounds = []
		characterIcons = CharacterIconMenu()
		characterUniqueThing = ""
	}
	public enum FeatPrereq: String, Codable {
			case None
			case CharRace
			case CharClass
			/*
			case Talent
			case BattleCry
			case SpellOrSong
			case Spell
			case Maneuver
			case Companion
			case Power
			*/
	}
	func updateName(new name:String){
		print("CharacterBase-- updateName-- running internal update name")
		charName = name
	}
	func updateClass(newClass selection: CharacterClassDetail ) {
		print("CharacterBase-- updateClass-- running internal update class")
		charClass = selection as CharacterClassDetail
	}
	func updateRace(newRace selection: CharacterRaceDetail){
		print("CharacterBase-- updateRace-- running internal update race")
		charRace = selection as CharacterRaceDetail
	}
	func updateStat(forStat: CharacterStatDetail, withLevel: Int){
		print("CharacterBase-- updateStat-- running internal update stat")
		let selectedStat = charStats.filter { $0 == forStat }.first
		selectedStat?.setLevel(newLevel: withLevel)
		let modifiedCount = charStats.filter { $0.itemModified == true }.count
		if modifiedCount == charStats.count {
			charStatsModified = true
			print("All stats have been set. Flipping the stats modified switch.")
		} else {
			charStatsModified = false
		}
	}
	func addBackground(_ background: CharacterBackgroundDetail) {
		print("CharacterBase-- addBackground")
		let index = characterBackgrounds.count
		if index == 0 {
			characterBackgrounds.append(background)
		} else {
			characterBackgrounds.insert(background, at: index)
		}
	}
	func deleteBackground(_ background: CharacterBackgroundDetail){
		let index = characterBackgrounds.firstIndex(of: background)
		characterBackgrounds.remove(at: index!)
	}
	func updateBackground(_ background: CharacterBackgroundDetail, with level: Int){
		if let index = characterBackgrounds.firstIndex(of: background) {
			characterBackgrounds.remove(at: index)
		} else {
			let selectedBackground = characterBackgrounds.filter { $0 == background}.first
			selectedBackground?.itemLevel = level
		}
	}
	/*
	func updateIconList(_ icon: CharacterIconDetail){
		characterIcons.first(where: {$0 == icon})?.toggle()

		if let currentIndex = characterIcons.firstIndex(of: icon) {
			print("Icon \(icon.itemName)found. Removing it from character")
			characterIcons.remove(at: currentIndex)
		} else {
			icon.itemModified = true
			characterIcons.append(icon)
		}
		
	}
	*/
	
	func updateOneUniqueThing(_ description: String){
		characterUniqueThing = description
	}
	
	
	
//	End of Class
}
