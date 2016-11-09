//
//  DatePickerVC.swift
//  CrazyNotes
//
//  Created by Roman Melnychok on 07.11.16.
//  Copyright © 2016 RoMeL. All rights reserved.
//

import UIKit

class DatePickerVC: UIViewController {

	@IBOutlet weak var datePicker: UIDatePicker!
	
	
	@IBAction func pickUpPressed(_ sender: UIButton) {
		close()
	}
	
	@IBAction func Close(_ sender: UIBarButtonItem) {
		
		close()
	}
	
	func close()  {
		
		_recordEntry.date = datePicker.date
		
		dismiss(animated: true)
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
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

		datePicker.setDate(_recordEntry.date, animated: true)
		
    }

	

}
