//
//  LevelTVC.swift
//  CharacterBuilder5.0
//
//  Created by Derek Shore on 11/10/19.
//  Copyright © 2019 Luxumbra. All rights reserved.
//

import UIKit
protocol LevelTVCDelegate: class {
	func refreshLevelTVCDelegate()
	func levelTVCDelegate(add item: LevelListItem, at index: Int)
}


class LevelTVC: UITableViewController {

	weak var delegate: LevelTVCDelegate?
	var currentMenu: NavigationMenuItem.MenuName
	var cellData: [LevelListItem] = []
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
		var list: [LevelListItem] = []
		switch currentMenu {
		case .statList:
			guard let stats = currentCharacter?.playerCharacter?.charStats else {return}
			list = stats
		case .backgrounds:
			guard let backgrounds = currentCharacter?.playerCharacter?.characterBackgrounds else {return}
			list = backgrounds
		case .iconRelationship:
			print("icon level menu getting imported now")
			guard let icons = currentCharacter?.playerCharacter?.characterIcons.selectionList(true) else {return}
			list = icons
		default:
			print("A non-level menu was selected but went to the level viewer")
			return
		}
		for item in list {
			cellData.append(item as LevelListItem)
		}
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
		configureLevelCell(for: cell, with: cellData[indexPath.row])
		cell.delegate = self
		cell.indexRow = indexPath.row
        return cell
    }
	
	
	// Will add this back in when I know if a cell will specifically need an action on tap
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		selectedOption = cellData[indexPath.row]
		performSegue(withIdentifier: "showLevelDetail", sender: self)
	}

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
			let item = cellData[indexPath.row]
			
			switch currentMenu {
			case .backgrounds:
				currentCharacter?.playerCharacter?.updateBackground(item as! CharacterBackgroundDetail, with: item.itemLevel)
			case .iconRelationship:
				item.toggle()
				currentCharacter?.playerCharacter?.updateIconList(item as! CharacterIconDetail)
			default:
				return
			}
			
			cellData.remove(at: indexPath.row)
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
		let cellIndexRow = cell.indexRow
		let currentData = cellData[cellIndexRow!]
		currentData.itemLevel = Int(cell.levelStepperOutlet.value)
		switch currentMenu {
		case .statList:
			let currentStat = (currentCharacter?.playerCharacter?.charStats.filter { $0.itemName == currentData.itemName }.first)!
			currentCharacter?.playerCharacter?.updateStat(forStat: currentStat, withLevel: currentData.itemLevel)
		case .backgrounds:
			let currentBackground = currentCharacter?.playerCharacter?.characterBackgrounds.filter {$0.itemName == currentData.itemName}.first
			currentCharacter?.playerCharacter?.updateBackground(currentBackground!, with: currentData.itemLevel)
			return
			
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
			currentCharacter?.playerCharacter?.addBackground(item as! CharacterBackgroundDetail)
			let rowIndex = ((currentCharacter?.playerCharacter?.characterBackgrounds.count)!) - 1
			let indexPath = IndexPath(row: rowIndex, section: 0)
			let indexPaths = [indexPath]
			cellData.insert(item, at: rowIndex)
			tableView.insertRows(at: indexPaths, with: .automatic)
			
//			tableView.reloadData()
		default:
			return
		}
	}
	
	func levelListDetail(_ controller: LevelListDetailVC, didFinishEditing item: LevelListItem) {
		switch currentMenu {
		case .backgrounds:
			let currentList = currentCharacter?.playerCharacter?.characterBackgrounds
			if let index = currentList?.firstIndex(of: item as! CharacterBackgroundDetail) {
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
	func updateCharacter(_ selection: LevelListItem, from cellData: [LevelListItem], for currentMenu: NavigationMenuItem.MenuName) {
		if self.currentMenu != currentMenu { print("Menu passed from SimpleDelegate does not match current menu in LevelList"); return }
	}
	func updateDelegateView(_ currentCharacter: CharacterData) {
		importCellData(from: currentMenu)
		tableView.reloadData()
	}
}
