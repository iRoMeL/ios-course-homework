//
//  ViewController.swift
//  CrazyNotes
//
//  Created by Roman Melnychok on 29.10.16.
//  Copyright © 2016 RoMeL. All rights reserved.
//

import UIKit

class TableVC: UIViewController {
    
    
    @IBOutlet weak var tableView:UITableView!
    
    
    var recordBook:RecordBook?{
        didSet {
            invalidateDisplayedRecords()
        }
    }
    
    
    fileprivate var _displayedRecordsArray: [Record]?
    
    
    //масив записів в щоденику
    var recordArray:[Record] {
        if let cachedArray = _displayedRecordsArray {
            return cachedArray
        }
        if let recordBook = recordBook {
            _displayedRecordsArray = recordBook.allRecord
            return _displayedRecordsArray!
        }
        return []
        
    }
	
	//перелік секцій
	enum sectonTitle:Int {
		case today=0
		case thisWeek
		case thisMonth
		case earlier
	}
	
	
	var recordsDict = [sectonTitle:[Record]]()
	var recordsSectionTitles = [sectonTitle]()
	
	func createRecordDict()  {
		
		let now = Date()
		for record in recordArray{
			
			let recordkey = getDateSection(from: record.date, to: now)
			
			if var recordValues = recordsDict[recordkey] {
				recordValues.append(record)
				recordsDict[recordkey] = recordValues
			}else{
				recordsDict[recordkey] = [record]
			}
			
		}
		recordsSectionTitles = [sectonTitle](recordsDict.keys)
		recordsSectionTitles.sort(){$0.rawValue < $1.rawValue}
			
	}
	
	
	
	
	func getDateSection(from date: Date, to now: Date) -> sectonTitle {
		//Якщо  сьогодні - Today, якщо на цьому тижні - This week

		let components = userCalendar.dateComponents([.day], from: date, to: now)
		let formatter = DateFormatter()
		formatter.locale = myLocale
		
		// сьогодні
		if let day = components.day, day==0  {
			return .today
		}
		//цього тижн
		if let day = components.day, day<=6  {
			return .thisWeek
		}
		
		//цього місйасйа
		if  let day = components.day, day<=30  {
			return .thisMonth
		}

		
		// давно
		return .earlier
		
		
	}

	func getSectionName(_ title:sectonTitle) -> String {
		
		switch title {
		case .today :
			return "Today"
		case .thisWeek :
			return "This week"
		case .thisMonth :
			return "This month"
		case .earlier :
			return "Earlier"
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
    
    
    //--------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //забираємо текст кнопки "Назад"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
		
		createRecordDict()

		let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(TableVC.insertNewObject(_:)))
		self.navigationItem.rightBarButtonItem = addButton
		
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //оновленнйа таблиці
		
		updateUI()
		tableView.reloadData()
    }
	
	func updateUI() {
	
		invalidateDisplayedRecords()
		
		recordsDict = [sectonTitle:[Record]]()
		recordsSectionTitles = [sectonTitle]()
		
		createRecordDict()
		
		
	}
    
	
	func insertNewObject(_ sender: AnyObject) {
		if let Book = recordBook {
			let record = Record(date: Date())
			record.name = "New Entry"
			Book.addRecord(record)
			
			updateUI()
			tableView.reloadData()
			
		}
	}
	
    func imageMood(_ weather:Weather) -> UIImage{
        
        switch weather {
        case .sun:
            return #imageLiteral(resourceName: "weather_sun")
        case .rain:
            return #imageLiteral(resourceName: "weather_rain")
        case .snow:
            return #imageLiteral(resourceName: "weather_snow")
        case .storm:
            return #imageLiteral(resourceName: "weather_storm")
        case .cloud:
            return #imageLiteral(resourceName: "weather_cloud")
        }
        
    }
	
	func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
		
		if let headerView = view as?  UITableViewHeaderFooterView {
			headerView.textLabel?.textColor = UIColor.white
			headerView.textLabel?.font = UIFont(name: "Avenir", size: 25.0)
			headerView.backgroundView?.backgroundColor = UIColor.orange
			
		}
		
		
		
	}
    
	
    
}

extension TableVC:UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
 		let recordkey = recordsSectionTitles[indexPath.section]
		
		if  let recordEntry = recordsDict[recordkey]?[indexPath.row]{
			performSegue(withIdentifier: "RecordVC", sender: recordEntry)
			
		}
		
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RecordVC {
            if let cell = sender as? Record {
                destination.record = cell
            }
        }
    }
	
	
	
}

extension TableVC:UITableViewDataSource {
	
	
	//кількість комірок в секції
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		let recordkey = recordsSectionTitles[section]
		if let recordValue = recordsDict[recordkey] {
			return recordValue.count
		}
		
		return 0
		
	}
	
	//заповненнйа комірки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Record") as? RecordCell {
			
			let recordkey = recordsSectionTitles[indexPath.section]
			
			if  let recordEntry = recordsDict[recordkey]?[indexPath.row]{
				
				cell.name?.text  = recordEntry.name
				cell.date?.text  = recordEntry.DateHumanReadable
				cell.textEntry?.text = recordEntry.text
				cell.mood?.image = imageMood(recordEntry.weather)
	 		}
			
			return cell
			
        }
        
        return UITableViewCell()
        
    }
	
	//кількість секцій
	func numberOfSections(in tableView: UITableView) -> Int {
		return recordsSectionTitles.count
	}
	
	//заголовок секції
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return getSectionName(recordsSectionTitles[section])
		
	}
	
	//редагуваннйа
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			
			let recordkey = recordsSectionTitles[indexPath.section]
			let recordValue = recordsDict[recordkey]
			
			let countsection = recordValue?.count ?? 0
			
				if  let recordToDelete = recordValue?[indexPath.row] {
				
				
				recordBook?.removeRecord(recordToDelete)
				updateUI()
				
				tableView.beginUpdates()
					if countsection == 1 {
						tableView.deleteSections([indexPath.section], with: .automatic)

					}
					
				tableView.deleteRows(at: [indexPath], with: .automatic)
				tableView.endUpdates()
			
			}
		}
		
	}

	
	
    
}

