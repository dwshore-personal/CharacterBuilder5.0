//
//  SimpleTVC.swift
//  CharacterBuilder5.0
//
//  Created by Derek Shore on 10/19/19.
//  Copyright © 2019 Luxumbra. All rights reserved.
//

import UIKit

protocol SimpleTVCDelegate: AnyObject {
	func updateDelegateView(_ currentCharacter: CharacterData)
	func updateCharacter(_ selection: LevelListItem, from cellData: [LevelListItem], for currentMenu: NavigationMenuItem.MenuName)
}

class SimpleTVC: UITableViewController {

	weak var delegate: SimpleTVCDelegate?
	var currentMenu: NavigationMenuItem.MenuName
	var cellData: [LevelListItem] = []
	var currentCharacter: CharacterData?
	var selectedOption: LevelListItem?
	var showFullList: Bool = true
	
	required init?(coder aDecoder: NSCoder) {
		currentMenu = NavigationMenuItem.MenuName.classList
		super.init(coder: aDecoder)
	}
	override func viewWillDisappear(_ animated: Bool) {
		delegate?.updateDelegateView(currentCharacter!)
	}
    override func viewDidLoad() {
        super.viewDidLoad()
		importCellData(from: currentMenu)
    }

    // MARK: - Table view data source
//	NUMBER OF SECTIONS
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
//	NUMBER OF ROWS IN SECTION
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
		return cellData.count
    }
//	LOAD CELL DATA
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleCell", for: indexPath)
		let cellInfo = cellData[indexPath.row]
		cell.textLabel?.text = cellInfo.itemName
		cell.detailTextLabel?.text = cellInfo.itemDescription
		configureCheckmark(for: cell, with: cellInfo)
        return cell
    }
//	ACCESSORY BUTTON TAP
	override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
		selectedOption = cellData[indexPath.row]
		performSegue(withIdentifier: "showLevelDetail", sender: self)
		
	}
//	SELECTION PROCESS
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		selectedOption = cellData[indexPath.row] as LevelListItem
		delegate?.updateCharacter(selectedOption!, from: cellData, for: currentMenu)
		print("Selected: "+selectedOption!.itemName as String)
		switch currentMenu {
		case .iconRelationship:
			let selectedIcon = PublicLists().iconList[indexPath.row]
			currentCharacter?.charData?.characterIcons?.toggleSelection(selectedIcon)
			delegate?.updateDelegateView(currentCharacter!)
			cellData[indexPath.row].toggle()
		default:
			print("no unique selection process")
			for item in cellData {
				item.itemModified = (item === selectedOption)
			}
		}
		tableView.reloadData()
	}
    

    // MARK: - Navigation
//	PREP SEGUE
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		switch segue.identifier {
		case "showLevelDetail":
			let vc = segue.destination as! LevelListDetailVC
			vc.selectedOption = selectedOption
		default:
			return
		}
    }

}

extension SimpleTVC {
//	CONFIGURE CHECKMARK
	func configureCheckmark( for cell: UITableViewCell, with listItem: LevelListItem) {
		cell.accessoryType = .detailButton
		if listItem.itemModified {
			cell.imageView?.image = .checkmark
		} else {
			cell.imageView?.image = .none
		}
	}
	
	func importCellData(from currentMenu: NavigationMenuItem.MenuName){
		cellData.removeAll()
		switch currentMenu {
		case .raceList:
			let currentRace = currentCharacter?.charData?.charRace
			cellData = PublicLists().raceList
			cellData.filter {$0 == currentRace}.first?.itemModified = true
		case .classList:
			let currentClass = currentCharacter?.charData?.charClass
			cellData = PublicLists().classList
			cellData.filter {$0 == currentClass}.first?.itemModified = true
		case .iconRelationship:
			if showFullList {
				cellData = (currentCharacter?.charData?.characterIcons?.fullList())!
			} else {
				cellData = (currentCharacter?.charData?.characterIcons?.selectionList(showFullList))!
			}
		default:
			print("A non-simple list was selected")
		}
	}
}
