//
//  RecordVC.swift
//  CrazyNotes
//
//  Created by Roman Melnychok on 29.10.16.
//  Copyright © 2016 RoMeL. All rights reserved.
//

import UIKit

class RecordVC: UITableViewController,UITextViewDelegate,UITextFieldDelegate {

    @IBOutlet weak var recordText: UITextView!
    
    @IBOutlet weak var recordName: UITextField!
    
    @IBOutlet weak var recordMood: UISegmentedControl!
    
    @IBAction func ChangeMood(_ sender: UISegmentedControl) {
        if let selectedmood = Weather(rawValue: sender.selectedSegmentIndex) {
            record.weather = selectedmood
        }
    }
	
	@IBAction func changeDateEntry(_ sender: UIBarButtonItem) {
		
		performSegue(withIdentifier: "DatePickerVC", sender: _recordEntry)
		
	}

    
	private var _recordEntry:Record!
    var record:Record{
		
        get{
            return _recordEntry
        }
        set{
            _recordEntry = newValue
        }
 }
    
    
    func updateFields() {
        recordName.text = _recordEntry.name
        recordText.text = _recordEntry.text
        recordMood.selectedSegmentIndex = _recordEntry.weather.rawValue
		//заголовок
		self.navigationItem.title       = _recordEntry.DateHumanReadable
    }
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateFields()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		updateFields()
	}
    
    func textViewDidEndEditing(_ textView: UITextView) {
        record.text = textView.text
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        record.name = textField.text ?? ""
    }
   
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "DatePickerVC" {
			if let destination = segue.destination as? DatePickerVC {
				if let datePickerRecord = sender as? Record {
				destination.record = datePickerRecord
				}
			}

		}
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		
		recordText.becomeFirstResponder()
		return false
	}
	
	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		
		if (text=="\n") {
			textView.resignFirstResponder()
			return false
		}
		return true
	}
	
	override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
		if let headerView = view as?  UITableViewHeaderFooterView {
			headerView.textLabel?.textColor = UIColor.white
			headerView.textLabel?.font = UIFont(name: "Avenir", size: 25.0)
			headerView.backgroundView?.backgroundColor = UIColor.orange
			
		}

	}
	
}
