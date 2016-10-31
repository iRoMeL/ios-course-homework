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

    //масив записів в щоденику
    //-------------------------------------
    let recordArray:[Record]  = [
        Record(date: entryDate("2001/09/11 09:11"), name:"Какайа боль"  ,tags: nil,text:"Жизнь боль......",weather: Weather.storm ),
        Record(date: entryDate("2016/10/30 18:59"), name:"Я дурію"      ,tags: nil, text: "а ем крейзі енд е лейзі енд ай нов іт",weather: Weather.sun),
        Record(date: entryDate("2016/10/29 18:59"), name:"Ніч"          ,tags: ["кава рулить","ніч","сон"], text: "Хочу спати - рано вставати",weather: Weather.rain),
        Record(date: entryDate("2016/09/31 23:59"), name:"Кульпарків"   ,tags: ["хз"], text: "Вивчаю Свіфт",weather: Weather.snow),
        Record(date: entryDate("2016/10/21 17:00"), name:"Наполеон"     ,tags: ["хз"], text: "ЙА БОХ",weather: Weather.rain),
        Record(date: entryDate("2016/09/14 18:59"), name:"ХЗ"           ,tags: ["хз"], text: "ХТО ЗНАЄ ДЕ ЗНАЙДЕШ А ДЕ ЗАГУБИШ",weather: Weather.snow),
        Record(date: entryDate("2016/09/14 18:59"), name:"Кукувруку"    ,tags: ["хз"], text: "Какімакі і до фікі нагінакі",weather: Weather.sun)
    ].sorted(){$0.date>$1.date}
    //--------------------------------------
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //забираємо текст кнопки "Назад"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //navigationController?.hidesBarsOnSwipe = true
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
