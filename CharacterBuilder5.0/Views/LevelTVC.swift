//
//  LevelTVC.swift
//  CharacterBuilder5.0
//
//  Created by Derek Shore on 11/10/19.
//  Copyright © 2019 Luxumbra. All rights reserved.
//

import UIKit
protocol LevelTVCDelegate: AnyObject {
	func refreshLevelTVCDelegate()
	func levelTVCDelegate(add item: LevelListItem, at index: Int)
}


class LevelTVC: UITableViewController {

	weak var delegate: LevelTVCDelegate?
	var currentMenu: NavigationMenuItem.MenuName
	var cellData: [[LevelListItem]] = [[]]
	var selectedOption: LevelListItem?
	var currentCharacter: CharacterData?
	
	required init?(coder aDecoder: NSCoder) {
		currentMenu = NavigationMenuItem.MenuName.statList
		super.init(coder: aDecoder)
	}
	
	@IBAction func addButton(_ sender: Any) {
		switch currentMenu {
		case .backgrounds:
			performSegue(withIdentifier: "addLevelListDetail", sender: sender)
		case .iconRelationship:
			performSegue(withIdentifier: "showSimple", sender: sender)
		default:
			return
		}
	}
	override func viewDidLoad() {
        super.viewDidLoad()
		importCellData(from: currentMenu)
		switch currentMenu {
		case .backgrounds:
			navigationController?.isToolbarHidden = false
			navigationItem.rightBarButtonItem = editButtonItem
		case .iconRelationship:
			navigationController?.isToolbarHidden = false
			navigationItem.rightBarButtonItem = editButtonItem
		default:
			navigationController?.isToolbarHidden = true
		}
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
	
	override func setEditing(_ editing: Bool, animated: Bool) {
		super.setEditing(editing, animated: true)
		tableView.setEditing(tableView.isEditing, animated: true)
	}
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(true)
		delegate?.refreshLevelTVCDelegate()
	}
	
	// MARK: - Updating functions
	func importCellData(from currentMenu: NavigationMenuItem.MenuName){
		cellData.removeAll()
		var list: [[LevelListItem]] = [[]]
		switch currentMenu {
		case .statList:
			guard let stats = currentCharacter?.playerCharacter?.charStats else {return}
			list = [stats.fullList()]
		case .backgrounds:
			guard let backgrounds = currentCharacter?.playerCharacter?.characterBackgrounds else {return}
			list = [backgrounds.fullList()]
		case .iconRelationship:
			guard let icons = currentCharacter?.playerCharacter?.characterIcons?.selectionList(true) else {return}
			list = [icons]
		case .featList:
			guard let feats = currentCharacter?.playerCharacter?.charFeatsFull.selectionList(true) else {return}
			list = feats
		default:
			print("A non-level menu was selected but went to the level viewer")
			return
		}
		cellData = list
	}
	
	func configureLevelCell(for cell: UITableViewCell, with item: LevelListItem){
		if let levelCell = cell as? LevelListCell {
			levelCell.cellTitle.text = item.itemName
			levelCell.cellLevel.text = String(item.itemLevel)
			levelCell.levelStepperOutlet.value = Double(item.itemLevel)
			if item.itemModified {
				levelCell.accessoryType = .checkmark
			} else {
				levelCell.accessoryType = .disclosureIndicator
			}
		}
	}


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cellData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "levelCell", for: indexPath) as! LevelListCell
		configureLevelCell(for: cell, with: cellData[indexPath.section][indexPath.row])
		cell.delegate = self
		cell.cellIndexPath = indexPath
        return cell
    }
	
	
	// Will add this back in when I know if a cell will specifically need an action on tap
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		selectedOption = cellData[indexPath.section][indexPath.row]
		performSegue(withIdentifier: "showLevelDetail", sender: self)
	}

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
			let item = cellData[indexPath.section][indexPath.row]
			
			switch currentMenu {
			case .backgrounds:
				cellData[indexPath.section].remove(at: indexPath.row)
				currentCharacter?.playerCharacter?.deleteElement(targetElement: item, elementType: .backgrounds)
			case .iconRelationship:
				item.toggle()
				currentCharacter?.playerCharacter?.characterIcons?.toggleSelection(item)
			case .featList:
				item.toggle()
				currentCharacter?.playerCharacter?.charFeatsFull.toggleFeatFromSelection(selection: item)
			default:
				return
			}
			
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
			return
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // MARK: - Navigation
	override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
		
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showSimple" {
			let vc = segue.destination as! SimpleTVC
			vc.title = currentMenu.rawValue
			vc.currentMenu = currentMenu
			vc.delegate = self
			vc.currentCharacter = currentCharacter
		} else {
			
			let vc = segue.destination as! LevelListDetailVC
			vc.currentMenu = currentMenu
			vc.delegate = self
			if let selection = selectedOption {
				vc.selectedOption = selection
			}
			switch segue.identifier {
			case "showLevelDetail":
				vc.title = "Details \(currentMenu.rawValue)"
			case "addLevelListDetail":
				vc.title = "Add \(currentMenu.rawValue)"
				vc.selectedOption = nil
				return
			case "editLevelDetail":
				vc.title = "Edit \(currentMenu.rawValue)"
			default:
				return
			}
		}
	}
	
//	MARK: Extensions
}

extension LevelTVC: LevelListCellDelegate {
	func updateLevels(for cell: LevelListCell) {
		let currentData = cellData[cell.cellIndexPath!.section][cell.cellIndexPath!.row]
		currentData.itemLevel = Int(cell.levelStepperOutlet.value)
		switch currentMenu {
		case .statList:
//			let currentStat = (currentCharacter?.playerCharacter?.charStats?.fullList().filter { $0.itemName == currentData.itemName }.first)!
			currentCharacter?.playerCharacter?.updateElement(targetElement: currentData, elementType: .statList, level: currentData.itemLevel)
		case .backgrounds:
//			let currentBackground = currentCharacter?.playerCharacter?.characterBackgrounds?.fullList().filter {$0.itemName == currentData.itemName}.first
			currentCharacter?.playerCharacter?.updateElement(targetElement: currentData, elementType: .backgrounds, level: currentData.itemLevel)
			return
		case .iconRelationship:
//			let currentIcon = currentCharacter?.playerCharacter?.characterIcons?.fullList().filter({ $0.itemName == currentData.itemName }).first
//			let currentIcon = currentCharacter?.playerCharacter?.characterIcons.selectionList(true).filter { $0.itemName == currentData.itemName }.first
			currentCharacter?.playerCharacter?.updateElement(targetElement: currentData, elementType: .iconRelationship, level: currentData.itemLevel)
		case .featList:
			currentCharacter?.playerCharacter?.updateElement(targetElement: currentData, elementType: .featList)
		default:
			print("error passing LevelListCellDelegate data to -updateLevel-")
		}
	}
}

extension LevelTVC: LeveListDetailDelegate {
	func levelListDetailDidCancel(_ controller: LevelListDetailVC) {
		navigationController?.popViewController(animated: true)
	}
	
	func levelListDetail(_ controller: LevelListDetailVC, didFinishAdding item: LevelListItem) {
		navigationController?.popViewController(animated: true)
		switch currentMenu {
		case .backgrounds:
			currentCharacter?.playerCharacter?.addElement(targetElement: item, elementType: .backgrounds, level: item.itemLevel)
//			currentCharacter?.playerCharacter?.addBackground(item as! CharacterBackgroundDetail)
			let rowIndex = ((currentCharacter?.playerCharacter?.characterBackgrounds?.fullList().count)!) - 1
			let indexPath = IndexPath(row: rowIndex, section: 0)
			let indexPaths = [indexPath]
			cellData[0].insert(item, at: rowIndex)
			tableView.insertRows(at: indexPaths, with: .automatic)
//			tableView.reloadData()
		default:
			return
		}
	}
	
	func levelListDetail(_ controller: LevelListDetailVC, didFinishEditing item: LevelListItem) {
		switch currentMenu {
		case .backgrounds:
			let currentList = currentCharacter?.playerCharacter?.characterBackgrounds?.fullList()
			if let index = currentList?.firstIndex(of: item) {
				let indexPath = IndexPath(row: index, section: 0)
				if let cell = tableView.cellForRow(at: indexPath) {
					configureLevelCell(for: cell, with: item)
				}
			}
		default:
			return
		}
		navigationController?.popViewController(animated: true)
	}
}

extension LevelTVC: SimpleTVCDelegate {
	func updateCharacter(_ selection: LevelListItem, from cellData: [[LevelListItem]], for currentMenu: NavigationMenuItem.MenuName) {
		print("LevelTVC-- DelegateCall-- updateCharacter: " + currentMenu.rawValue)
		if self.currentMenu != currentMenu { print("Menu passed from SimpleDelegate does not match current menu in LevelList"); return }
		switch currentMenu {
		case .iconRelationship:
			self.cellData = cellData.filter { $0[0].itemModified == true}
		default:
			return
		}
	}
	func updateDelegateView(_ currentCharacter: CharacterData) {
		importCellData(from: currentMenu)
		tableView.reloadData()
	}
}
