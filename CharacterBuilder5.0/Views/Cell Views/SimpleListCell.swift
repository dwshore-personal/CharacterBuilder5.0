//
//  SimpleListCell.swift
//  CharacterBuilder5.0
//
//  Created by Derek Shore on 10/20/19.
//  Copyright © 2019 Luxumbra. All rights reserved.
//

import UIKit

class SimpleListCell: UITableViewCell {

	@IBOutlet weak var itemIcon: UIImageView!
	@IBOutlet weak var itemName: UILabel!
	@IBOutlet weak var itemDescription: UILabel!
	
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
