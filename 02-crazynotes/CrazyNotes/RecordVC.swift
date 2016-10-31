//
//  RecordVC.swift
//  CrazyNotes
//
//  Created by Roman Melnychok on 29.10.16.
//  Copyright © 2016 RoMeL. All rights reserved.
//

import UIKit

class RecordVC: UIViewController {

    @IBOutlet weak var recordMood: UISegmentedControl!
    @IBOutlet weak var recordName: UILabel!
    @IBOutlet weak var recordText: UITextView!

    private var _recordEntry:Record!
    
    var record:Record{
        get{
            return _recordEntry
        }
        set{
            _recordEntry = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recordName.text = _recordEntry.name
        recordText.text = _recordEntry.text
        recordMood.selectedSegmentIndex = _recordEntry.weather.rawValue
        
        //заголовок
        self.navigationItem.title       = _recordEntry.DateHumanReadable
        
    }
   
    
}
