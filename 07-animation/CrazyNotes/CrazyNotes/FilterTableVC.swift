//
//  FilterTableVC.swift
//  CrazyNotes
//
//  Created by Roman Melnychok on 09.11.16.
//  Copyright © 2016 RoMeL. All rights reserved.
//

import UIKit

class FilterTableVC: UITableViewController {


	var recordBook:RecordBook?{
		didSet {
			tableView?.reloadData()
		}
	}
	
	fileprivate func invalidateDisplayedRecords(animated: Bool = false) {
		_displayedRecordsArray = nil
		if animated {
			tableView?.reloadSections(IndexSet(integer: 0), with: UITableViewRowAnimation.automatic)
		} else {
			tableView?.reloadData()
		}
	}
	
	fileprivate var _displayedRecordsArray: [Record]?
	
	//масив записів в щоденику
	var recordArray:[Record] {
		if let cachedArray = _displayedRecordsArray {
			return cachedArray
		}
		if let recordBook = recordBook {
			
			if let selectedFilter = Weather(rawValue: filter.selectedSegmentIndex) {
    
				_displayedRecordsArray = recordBook.allRecord.filter{$0.weather == selectedFilter}
				
			return _displayedRecordsArray!
				
			}
		}
		return []		
	}
	
	// MARK: - Outlets
	
	@IBOutlet weak var filter: UISegmentedControl!
	
	@IBAction func filterChanged(_ sender: UISegmentedControl) {
		invalidateDisplayedRecords()
	}
	

	// MARK: - Standart func
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

    }
	
	override func viewWillAppear(_ animated: Bool) {
		invalidateDisplayedRecords()
		tableView.reloadData()
	}


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
         return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
        return recordArray.count
    }

	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		
		let entry = recordArray[indexPath.row]
		cell.textLabel?.text = entry.name
		cell.detailTextLabel?.text = entry.DateHumanReadable

        return cell
    }
	

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		if let destination = segue.destination as? RecordVC {
			if let cell = sender as? Record {
				destination.record = cell
			}
		}

	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		
		let recordEntry = recordArray[indexPath.row]
		
		performSegue(withIdentifier: "RecordVC", sender: recordEntry)
			
		
		
		
	}


}
