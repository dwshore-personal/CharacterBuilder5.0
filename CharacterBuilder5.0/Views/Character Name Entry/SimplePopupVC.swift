//
//  SimplePopupVC.swift
//  CharacterBuilder4.0
//
//  Created by Derek Shore on 9/20/19.
//  Copyright © 2019 Luxumbra. All rights reserved.
//

import UIKit

protocol SimplePopupVCDelegate: AnyObject {
//	func simplePopupVCDelegate(createCharacterName: Bool, withName: String)
	func simplePopupVCDelegate(update menuName: NavigationMenuItem.MenuName, with newDescription: String)
}

class SimplePopupVC: UIViewController {

	@IBOutlet weak var popupLabel: UILabel!
	@IBOutlet weak var textField: UITextField!
	@IBOutlet weak var paragraphField: UITextView!
	
	weak var delegate: SimplePopupVCDelegate?
	var currentMenu: NavigationMenuItem.MenuName?
	var createNewCharacter = true
	var textFieldDescription: String?
	
	@IBAction func cancelButton(_ sender: UIButton) {
		dismiss(animated: true)
	}
	
	@IBAction func saveButton(_ sender: UIButton) {
		let newDescription = grabNewData()
		if newDescription == "" {
			return
		} else {
			delegate?.simplePopupVCDelegate(update: currentMenu!, with: newDescription)
			dismiss(animated: true)
		}		
	}
	
	func grabNewData() -> String {
		switch currentMenu {
		case .characterName:
			return textField.text ?? ""
		case .uniqueThing:
			return paragraphField.text
		default:
			print("Need to update poup with \(String(describing: currentMenu))")
			return ""
		}
	}
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
		textField.isHidden = true
		paragraphField.isHidden = true
		if let text = textFieldDescription {
			textField.text = text
			paragraphField.text = text
		}
		switch currentMenu {
		case .characterName:
			popupLabel.text = "Enter your character name here. Don't worry, you can change it later."
			textField.isHidden = false
		case .uniqueThing:
			popupLabel.text = "Enter your one unique thing about your character here."
			paragraphField.layer.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).cgColor
			paragraphField.isHidden = false
		default:
			print("no valid menu passed to the SimplePopupVC")
		}
        // Do any additional setup after loading the view.
    }
}
