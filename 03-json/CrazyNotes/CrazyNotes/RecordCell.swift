//
//  RecordCell.swift
//  CrazyNotes
//
//  Created by Roman Melnychok on 30.10.16.
//  Copyright © 2016 RoMeL. All rights reserved.
//

import UIKit

class RecordCell: UITableViewCell {


    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
