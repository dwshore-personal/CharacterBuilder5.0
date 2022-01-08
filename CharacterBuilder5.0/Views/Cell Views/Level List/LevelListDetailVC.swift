//
//  LevelListDetailVC.swift
//  CharacterBuilder5.0
//
//  Created by Derek Shore on 11/10/19.
//  Copyright © 2019 Luxumbra. All rights reserved.
//

import UIKit
protocol LeveListDetailDelegate: AnyObject {
	func levelListDetailDidCancel(_ controller: LevelListDetailVC)
	func levelListDetail(_ controller: LevelListDetailVC, didFinishAdding item: LevelListItem)
	func levelListDetail(_ controller: LevelListDetailVC, didFinishEditing item: LevelListItem)
}


class LevelListDetailVC: UIViewController {
	var currentMenu: NavigationMenuItem.MenuName?
	weak var delegate: LeveListDetailDelegate?
	weak var selectedOption: LevelListItem?
//	weak var currentCharacter: CharacterData?
	
	@IBOutlet weak var detailTitle: UILabel!
	@IBOutlet weak var detailDescription: UILabel!
	@IBOutlet weak var textField: UITextField!
	@IBOutlet weak var addBarButton: UIBarButtonItem!
	@IBOutlet weak var cancelBarButton: UIBarButtonItem!
	
	@IBAction func cancel(_ sender: Any){
		delegate?.levelListDetailDidCancel(self)
	}
	
	@IBAction func done(_ sender: Any){
		if currentMenu != NavigationMenuItem.MenuName.backgrounds { return }
		if let item = selectedOption, let text = textField.text {
			item.itemName = text
			delegate?.levelListDetail(self, didFinishEditing: item)
		} else {
			if let backgroundName = textField.text {
				let newBackground = LevelListItem(itemName: backgroundName, listItemType: .backgrounds)
//				currentCharacter?.playerCharacter?.addBackground(newBackground)
				delegate?.levelListDetail(self, didFinishAdding: newBackground)
			}
		}
	}
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		switch currentMenu {
		case .backgrounds:
			textField.isHidden = false
			detailTitle.isHidden = true
			detailDescription.isHidden = true
			if let item = selectedOption {
				title = "Edit Item"
				textField.text = item.itemName
			} else {
				title = "Add Item"
			}
			addBarButton.isEnabled = true
		case .iconRelationship:
			textField.isHidden = false
			detailTitle.isHidden = false
			detailDescription.isHidden = false
			
			
		default:
			textField.isHidden = true
			addBarButton.isEnabled = false
			if let selection = selectedOption {
				detailTitle.text = selection.itemName
				detailTitle.isHidden = false
				detailDescription.text = selection.itemDescription
				detailDescription.isHidden = false
			}
		}

        // Do any additional setup after loading the view.
    }
	
	override func viewWillAppear(_ animated: Bool) {
		textField.becomeFirstResponder()
	}
	
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension LevelListDetailVC: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return false
	}
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		guard let oldText = textField.text,
			let stringRange = Range(range, in: oldText) else { return false }
		let newText = oldText.replacingCharacters(in: stringRange, with: string)
		if newText.isEmpty {
			addBarButton.isEnabled = false
		} else {
			addBarButton.isEnabled = true
		}
		return true
	}
	
	
}
