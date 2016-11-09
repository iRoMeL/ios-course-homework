//
//  SettingsVC.swift
//  CrazyNotes
//
//  Created by Roman Melnychok on 30.10.16.
//  Copyright © 2016 RoMeL. All rights reserved.
//

import UIKit

class SettingsVC: UITableViewController {

  
    @IBOutlet weak var NaturalLanguageSupportSwitch: UISwitch!
    
    @IBAction func ChangeNLS(_ sender: UISwitch) {
        
       UserDefaults.standard.set(NaturalLanguageSupportSwitch.isOn, forKey: "humanReadableDates")
      
    }
	
	var dateTimeOption:Bool{
		get{
			
			if dateTime.accessoryType == .checkmark {
				return true
			} else{
				return false}
			
		}
		set{
			if newValue == true {
				dateTime.accessoryType = .checkmark
				dateOnly.accessoryType = .none
				UserDefaults.standard.set(true, forKey: "dateTimeOption")
			} else{
				dateTime.accessoryType = .none
				dateOnly.accessoryType = .checkmark
				UserDefaults.standard.set(false, forKey: "dateTimeOption")
			}
			
		}
		
	}
	

	@IBOutlet weak var dateTime: UITableViewCell!
	@IBOutlet weak var dateOnly: UITableViewCell!
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		if indexPath.section == 0{
			if indexPath.row == 0  {
				//datetime selected
				dateTimeOption = true
			}else{
				//dateOnly selected
				dateTimeOption = false
			}
		}
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		if let humanReadableDates = UserDefaults.standard.object(forKey: "humanReadableDates") as? Bool {
			NaturalLanguageSupportSwitch.isOn = humanReadableDates
		}else{
			
			UserDefaults.standard.set(true, forKey: "humanReadableDates")
			NaturalLanguageSupportSwitch.isOn = true
		}
		
		if let _dateTimeOption = UserDefaults.standard.object(forKey: "dateTimeOption" ) as? Bool {
			
			dateTimeOption = _dateTimeOption
		} else {
			UserDefaults.standard.set(true, forKey: "dateTimeOption")
			dateTimeOption = true
			
		}
	
    }
	
}
