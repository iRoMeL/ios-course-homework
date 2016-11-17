//
//  CustomVC.swift
//  CrazyNotes
//
//  Created by Roman Melnychok on 13.11.16.
//  Copyright © 2016 RoMeL. All rights reserved.
//

import UIKit

class CustomVC: UIViewController {

	var recordBook:RecordBook?{
		didSet {
			//invalidateDisplayedRecords()
		}
	}
	
	@IBOutlet weak var custom: CustomView!
	@IBOutlet weak var segControl: UISegmentedControl!
	@IBAction func SegControlChanged(_ sender: UISegmentedControl) {
		
		for view in scrollview.subviews {
			view.removeFromSuperview()
		}
		
		updateUI()
	}
	
	
	@IBOutlet weak var scrollview: UIScrollView!
	

	override func viewDidLoad() {
		super.viewDidLoad()
		
		
	}
	
	func updateUI() {
	
		if let allrecords = recordBook?.allRecord {
			
			var recordsDict = [String:[Record]]()
			var daysArray = [String]()
			
			for record in allrecords {
				
					let recordkey = record.shortDate
					
					if var recordValues = recordsDict[recordkey] {
						recordValues.append(record)
						recordsDict[recordkey] = recordValues
					}else{
						recordsDict[recordkey] = [record]
					}
				
			}
			
			var iteratorDate = allrecords[0].date
			
			while iteratorDate > allrecords[allrecords.count - 1].date  {
				
				
				if segControl.selectedSegmentIndex == 1 {
						daysArray.append(iteratorDate.shortDate)
				} else {
					
					if recordsDict[iteratorDate.shortDate] != nil {
						daysArray.append(iteratorDate.shortDate)
					}
				}

				iteratorDate = userCalendar.date(byAdding: .day, value: -1, to: iteratorDate)!
			}
			
			daysArray.append(allrecords[allrecords.count - 1].date.shortDate)
			
			var contentHight: CGFloat = 0.0
			
			var dateEntry = ""
			
			
			for (index, dayShort) in daysArray.enumerated() {
    
				
				if let recDic = recordsDict[dayShort] {
					
					for (_, record) in recDic.enumerated() {
						
						let nib			= UINib(nibName: "EntryView", bundle: nil)
						
						let nibObjects  = nib.instantiate(withOwner: nil, options: nil)
						if nibObjects.count == 1 {
							if let entryView = nibObjects[0] as? CustomView {
								
								entryView.record					= record
								
								//  запис тією ж датою
								if dateEntry == dayShort && (dateEntry != ""){
									entryView.containerDate.isHidden	= true
								}
								
								// пустий запис
								if  let recordname = record.name  {
									if recordname.isEmpty {
										entryView.containerText.isHidden = true
									}
								} else if record.name == nil {
									entryView.containerText.isHidden = true
								}
								
								
								
								dateEntry = record.shortDate
								
								let bounds = entryView.bounds
								
								scrollview.addSubview(entryView)
								
								contentHight = bounds.size.height * CGFloat(index+1)
								
								entryView.frame = CGRect(x: CGFloat(0), y:    bounds.size.height * CGFloat(index), width: bounds.size.width, height: bounds.size.height)
								
							}
						
						
					}
					
					
				
				
				
				}
				
				
				
	
				} else {
				
		
						let nib			= UINib(nibName: "EntryView", bundle: nil)
						
						let nibObjects  = nib.instantiate(withOwner: nil, options: nil)
						if nibObjects.count == 1 {
							if let entryView = nibObjects[0] as? CustomView {
								
								entryView.entryDate.text		 = dayShort
								entryView.entryDate.textColor	 = UIColor.lightGray
								entryView.containerImage.isHidden = true
								entryView.containerText.isHidden = true
								entryView.containerDate.layer.borderColor = UIColor.lightGray.cgColor
								


								dateEntry = dayShort
								
								let bounds = entryView.bounds
								
								scrollview.addSubview(entryView)
								
								contentHight = bounds.size.height * CGFloat(index+1)
								
								entryView.frame = CGRect(x: CGFloat(0), y:    bounds.size.height * CGFloat(index), width: bounds.size.width, height: bounds.size.height)
								
							}
						
					}
				
				}
				
				
			}
			
			
			scrollview.clipsToBounds = true
			
			scrollview.contentSize = CGSize(width: view.frame.size.width, height: contentHight  )
			
			
		}
	}

	
	func addEntry(_ record : Record) {
		
		
		
		
	}
	
	override func viewDidAppear(_ animated: Bool) {
		
		updateUI()
		
	}
	
	

}
