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
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateFields()
        
        //заголовок
        self.navigationItem.title       = _recordEntry.DateHumanReadable
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        record.text = textView.text
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        record.name = textField.text ?? ""
    }
   
    
}
