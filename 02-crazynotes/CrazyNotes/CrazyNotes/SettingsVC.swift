//
//  SettingsVC.swift
//  CrazyNotes
//
//  Created by Roman Melnychok on 30.10.16.
//  Copyright © 2016 RoMeL. All rights reserved.
//

import UIKit

class SettingsVC: UITableViewController {

  
    @IBOutlet weak var NLS: UISwitch!
    
    @IBAction func ChangeNLS(_ sender: UISwitch) {
        
        if NLS.isOn {
            Record.NaturalLanguage = true
        }else{
            Record.NaturalLanguage = false
        }
      
    }
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }

    
}
