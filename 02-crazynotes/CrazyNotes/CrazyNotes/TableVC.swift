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
    var recordArray:[Record]  {
        if let cachedArray = _displayedRecordsArray {
            return cachedArray
        }
        if let recordBook = recordBook {
            _displayedRecordsArray = recordBook.allRecord
            return _displayedRecordsArray!
        }
        return []
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //оновленнйа таблиці
        tableView.reloadData()
    }

  
  
}

extension TableVC:UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let recordcellvc = recordArray[indexPath.row]
        performSegue(withIdentifier: "RecordVC", sender: recordcellvc)
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Record") as? RecordCell {
            
            let recordEntry = recordArray[indexPath.row]
            
            cell.name?.text  = recordEntry.name
            cell.date?.text  = recordEntry.DateHumanReadable
            
            return cell
            
        }
        
        return UITableViewCell()
        
    }
    
}
