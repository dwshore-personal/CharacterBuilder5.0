//
//  CharacterBuilderParentTVC.swift
//  CharacterBuilder5.0
//
//  Created by Derek Shore on 11/1/19.
//  Copyright © 2019 Luxumbra. All rights reserved.
//

import UIKit

class CharacterBuilderParentTVC: UITableViewController {

	var mainMenu = NavigationMenuList()
	var selectedMenu: NavigationMenuItem?
	var currentCharacter = CharacterData()
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }

	func configureCell(for cell: UITableViewCell, with menuItem: NavigationMenuItem) {
		cell.textLabel?.text = menuItem.menuName.rawValue
		cell.detailTextLabel?.text = menuItem.menuDescription
		if menuItem.modified {
			cell.imageView?.image = .checkmark
		} else {
			cell.imageView?.image = .none
		}
			
	}
	
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
		if mainMenu.menuList()[0].modified {
		return mainMenu.menuList().count
		} else {
			return 1
		}
	}

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainMenuCell", for: indexPath)
		let menuItem = mainMenu.menuList()[indexPath.row]
		configureCell(for: cell, with: menuItem)
		cell.accessoryType = .disclosureIndicator
		
        return cell
    }
    

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		selectedMenu = mainMenu.menuList()[indexPath.row]
		performSegue(withIdentifier: (selectedMenu?.menuSegue.rawValue)!, sender: (Any).self)
	}
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		switch segue.identifier {
		case "showSimple":
			let vc = segue.destination as! SimpleTVC
			vc.currentMenu = selectedMenu!.menuName
			vc.delegate = self
			vc.currentCharacter = currentCharacter
			vc.title = selectedMenu?.menuName.rawValue
		case "showPopup":
			let vc = segue.destination as! SimplePopupVC
			vc.delegate = self
			vc.currentMenu = selectedMenu?.menuName
			if selectedMenu?.menuName == .characterName {
				if let characterName = currentCharacter.playerCharacter?.charName {
					vc.createNewCharacter = false
					vc.textFieldDescription = characterName
				} else {
					vc.createNewCharacter = true
					vc.textFieldDescription = ""
				}
			} else if selectedMenu?.menuName == .uniqueThing {
				let description = currentCharacter.playerCharacter?.characterUniqueThing
				if description == "" { return }
				vc.textFieldDescription = description
			}
			
		case "showLevel":
			let vc = segue.destination as! LevelTVC
			vc.delegate = self
			vc.currentMenu = selectedMenu!.menuName
			vc.currentCharacter = currentCharacter
			vc.title = selectedMenu?.menuName.rawValue

		default:
			print("navigated from parent TVC to undefined destination")
		}
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}

//	MARK: Extensions
extension CharacterBuilderParentTVC: SimpleTVCDelegate {
	func updateCharacter(_ selection: LevelListItem, from cellData: [[LevelListItem]], for currentMenu: NavigationMenuItem.MenuName) {
		selection.itemModified = true
		switch currentMenu {
		case .classList:
			currentCharacter.playerCharacter?.updateElement(targetElement: selection, elementType: .classList)
			mainMenu.updateMenuFromCharacterSettings(character: currentCharacter.playerCharacter!)
		case .raceList:
			currentCharacter.playerCharacter?.updateElement(targetElement: selection, elementType: .raceList)
			mainMenu.updateMenuFromCharacterSettings(character: currentCharacter.playerCharacter!)
		case .featList:
			currentCharacter.playerCharacter?.updateElement(targetElement: selection, elementType: .featList)
		default:
			print("Missing appropriate criteria for -updateCharacter- protocol in BuilderParent.")
			return
		}
		for menu in mainMenu.menuList() {
			if menu.menuName == currentMenu {
				menu.updateMenuDescription(with: selection.itemName)
				menu.updateMenuModified(with: true)
			}
		}
		tableView.reloadData()
	}

	func updateDelegateView(_ currentCharacter: CharacterData) {
		tableView.reloadData()
	}
}

extension CharacterBuilderParentTVC: SimplePopupVCDelegate {
	func simplePopupVCDelegate(update menuName: NavigationMenuItem.MenuName, with newDescription: String) {
		if newDescription.isEmpty { return }
		switch menuName {
		case .characterName:
			if currentCharacter.playerCharacter == nil {
				currentCharacter.createNewCharacter(forCharacter: newDescription)
				print("SimplePopupVCDelegate-- createCharacter-- created new character = \(String(describing: currentCharacter.playerCharacter?.charName))")
			} else {
				currentCharacter.playerCharacter?.updateName(new: newDescription)
				print("SimplePopupVCDelegate-- updateCharacter-- updated character = \(String(describing: currentCharacter.playerCharacter?.charName))")
			}
		case .uniqueThing:
			currentCharacter.playerCharacter?.updateOneUniqueThing(newDescription)
		default:
			print("missing a usable menu")
			return
		}
		mainMenu.updateMenuFromCharacterSettings(character: currentCharacter.playerCharacter!)
		tableView.reloadData()
	}
	

}

extension CharacterBuilderParentTVC: LevelTVCDelegate {
	func levelTVCDelegate(add item: LevelListItem, at index: Int) {
		return
	}
	
	func refreshLevelTVCDelegate() {
		mainMenu.updateMenuFromCharacterSettings(character: currentCharacter.playerCharacter!)
		tableView.reloadData()
	}
	
	

}
