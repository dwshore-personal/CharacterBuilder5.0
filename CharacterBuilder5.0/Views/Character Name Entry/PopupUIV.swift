//
//  PopupUIV.swift
//  CharacterBuilder4.0
//
//  Created by Derek Shore on 9/20/19.
//  Copyright © 2019 Luxumbra. All rights reserved.
//

import UIKit

class PopupUIV: UIView {

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		layer.shadowOpacity = 1
		layer.shadowOffset = CGSize.zero
		layer.shadowColor = UIColor.darkGray.cgColor
		layer.cornerRadius = 10
		
	}

}
