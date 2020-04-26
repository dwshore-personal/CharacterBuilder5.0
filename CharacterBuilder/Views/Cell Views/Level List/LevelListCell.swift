//
//  LevelListCellTableViewCell.swift
//  CharacterBuilder5.0
//
//  Created by Derek Shore on 11/10/19.
//  Copyright © 2019 Luxumbra. All rights reserved.
//

import UIKit

protocol LevelListCellDelegate: class {
	func updateLevels(for cell: LevelListCell)
}
class LevelListCell: UITableViewCell {

	weak var delegate: LevelListCellDelegate?
	var indexRow: Int?
	
	@IBOutlet weak var cellTitle: UILabel!
	@IBOutlet weak var cellLevel: UILabel!
	@IBOutlet weak var levelStepperOutlet: UIStepper!
	@IBAction func levelStepper(_ sender: UIStepper) {
		cellLevel.text = Int(sender.value).description
		let currentCell = self as LevelListCell
		delegate?.updateLevels(for: currentCell)
		self.accessoryType = .checkmark
	}
	
	
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: false)
		
        // Configure the view for the selected state
    }
    
}
