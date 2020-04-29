//
//  CharacterIcons.swift
//  CharacterBuilder5.0
//
//  Created by Derek Shore on 12/3/19.
//  Copyright © 2019 Luxumbra. All rights reserved.
//

import Foundation
class CharacterIconMenu: Codable {
	private var iconList: [CharacterIconDetail] = [
	 CharacterIconDetail(itemName: "The Three"),
	 CharacterIconDetail(itemName: "The Diabolist"),
	 CharacterIconDetail(itemName: "The Crusader"),
	 CharacterIconDetail(itemName: "The Priestess")
	]
	
	func fullList() -> [CharacterIconDetail] {
		return iconList
	}
	
	func selectionList(_ selected: Bool) -> [CharacterIconDetail]{
		return iconList.filter {$0.itemModified == selected}
	}
	
	func toggleSelection(_ icon: CharacterIconDetail) {
		iconList.filter { $0 === icon }.first?.itemModified = icon.itemModified
	}
}

class CharacterIconDetail: LevelListItem {
	
}
