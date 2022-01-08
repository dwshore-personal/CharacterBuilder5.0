//
//  FeatPrereq.swift
//  CharacterBuilder5.0
//
//  Created by Derek Shore on 12/25/21.
//  Copyright © 2021 Luxumbra. All rights reserved.
//

import Foundation
class FeatSubList: Codable {
	var featReqType: LevelListItem.FeatPrereqType = .General
	var featReqName: String = "General"
	var feats: LevelListArray
	
	init (type: LevelListItem.FeatPrereqType = .General, name: String = "General", feats: LevelListArray){
		self.featReqType = type
		self.featReqName = name
		self.feats = feats
	}
	
}



class FeatList: Codable {
	var featGroups: [FeatSubList]
	
	init(featGroups: [FeatSubList]){
		self.featGroups = featGroups
	}
	
//	FEAT LIST OUTPUTS
	func filteredList(_ playerCharacter: CharacterBase) -> [[LevelListItem]] {	// filter based on player
		var output: [[LevelListItem]] = [[]]
		if let generalIndex = featGroups.firstIndex(where: {$0.featReqType == .General}){
			output.append(featGroups[generalIndex].feats.fullList())
		}
		if let racialIndex = featGroups.firstIndex(where: {$0.featReqName == playerCharacter.charRace?.itemName}){
			output.append(featGroups[racialIndex].feats.fullList())
		}
		if let classIndex = featGroups.firstIndex(where: {$0.featReqName == playerCharacter.charClass?.itemName}){
			output.append(featGroups[classIndex].feats.fullList())
		}
		return output
	}
//	func selectedList()	// filter based on player AND selected

//	FEAT LIST MANIPULATION
//	func addFeat()		// add new feat to character array
//	func deleteFeat()	// remove feat from character array
	
	
	
	
	
	func filteredFeats(playerCharacter: CharacterBase) ->[[LevelListItem]]{
		var output = [featGroups[featGroups.firstIndex(where: {$0.featReqType == .General})!].feats]
		var racialFeats = [LevelListItem]()
		var classFeats = [LevelListItem]()
		if playerCharacter.charRace != nil{
			racialFeats = featGroups[featGroups.firstIndex(where: {$0.featReqName == playerCharacter.charRace?.itemName})!].feats
			output.append(racialFeats)
		} else {
			output.append(featGroups[featGroups.firstIndex(where: {$0.featReqType == .CharRace})!].feats)
		}
		if playerCharacter.charClass != nil {
			classFeats = featGroups[featGroups.firstIndex(where: {$0.featReqName == playerCharacter.charClass?.itemName})!].feats
			output.append(classFeats)
		} else {
			output.append(featGroups[featGroups.firstIndex(where: {$0.featReqType == .CharClass})!].feats)
		}
		return output
	}
	
//	func fullList() -> [[LevelListItem]]{
//		let racialFeats = featGroups.first(where: {$0.featReqType == .CharRace})?.feats
//		let classFeats = featGroups.first(where: {$0.featReqType == .CharClass})?.feats
//		let generalFeats = featGroups.first(where: {$0.featReqType == .General})?.feats
//		return [racialFeats!, classFeats!, generalFeats!]
//	}
	
	func isFeatSelected(_ selection: LevelListItem) -> Bool {
		switch selection.featReqType {
		case .General:
			return ((featGroups[featGroups.firstIndex(where: {$0.featReqType == .General})!].feats.first(where: { $0 == selection })?.itemModified) != nil)
		case .CharRace:
			return ((featGroups[featGroups.firstIndex(where: {$0.featReqType == .CharRace})!].feats.first(where: { $0 == selection })?.itemModified) != nil)
		case .CharClass:
			return ((featGroups[featGroups.firstIndex(where: {$0.featReqType == .CharClass})!].feats.first(where: { $0 == selection })?.itemModified) != nil)
		default:
			print("[FEATS]-- selectFeatFromItem-- failed to match featReqType")
			return false
		}
	}
	
	func selectionList(_ status: Bool) -> [[LevelListItem]] {
		let racialFeats = featGroups[featGroups.firstIndex(where: {$0.featReqType == .CharRace})!].feats.filter {$0.itemModified == status}
		let classFeats = featGroups[featGroups.firstIndex(where: {$0.featReqType == .CharClass})!].feats.filter {$0.itemModified == status}
		let generalFeats = featGroups[featGroups.firstIndex(where: {$0.featReqType == .General})!].feats.filter {$0.itemModified == status}
		return [racialFeats, classFeats, generalFeats]
	}
	
//	TOGGLE SELECTIONS
	func toggleFeatFromSelection(selection: LevelListItem){
		switch selection.featReqType {
		case .General:
			featGroups[featGroups.firstIndex(where: {$0.featReqType == .General})!].feats.first(where: { $0 == selection })?.toggle()
		case .CharRace:
			featGroups[featGroups.firstIndex(where: {$0.featReqType == .CharRace})!].feats.first(where: { $0 == selection })?.toggle()
		case .CharClass:
			featGroups[featGroups.firstIndex(where: {$0.featReqType == .CharClass})!].feats.first(where: { $0 == selection })?.toggle()
		default:
			print("[FEATS]-- selectFeatFromItem-- failed to match featReqType")
		}
	}
	func setFeatSelection(selection: LevelListItem, set status: Bool){
		switch selection.featReqType {
		case .General:
			featGroups[featGroups.firstIndex(where: {$0.featReqType == .General})!].feats.first(where: { $0 == selection })?.setSelection(status: status)
		case .CharRace:
			featGroups[featGroups.firstIndex(where: {$0.featReqType == .CharRace})!].feats.first(where: { $0 == selection })?.setSelection(status: status)
		case .CharClass:
			featGroups[featGroups.firstIndex(where: {$0.featReqType == .CharClass})!].feats.first(where: { $0 == selection })?.setSelection(status: status)
		default:
			print("[FEATS]-- selectFeatFromItem-- failed to match featReqType")
		}
	}
	
}
