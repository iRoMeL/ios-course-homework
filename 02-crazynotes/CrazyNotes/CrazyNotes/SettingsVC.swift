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
        
       UserDefaults.standard.set(NLS.isOn, forKey: "humanReadableDates")
      
    }
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let humanReadableDates = UserDefaults.standard.object(forKey: "humanReadableDates") as? Bool {
           NLS.isOn = humanReadableDates
        }else{
            
           UserDefaults.standard.set(true, forKey: "humanReadableDates")
           NLS.isOn = true
        }
        
        
        
        // Do any additional setup after loading the view.
    }

    
}
