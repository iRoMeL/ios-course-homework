//
//  Record.swift
//  CrazyNotes
//
//  Created by Roman Melnychok on 29.10.16.
//  Copyright © 2016 RoMeL. All rights reserved.
//

import Foundation

let userCalendar = Calendar.current
let myLocale = Locale(identifier: "uk_UA")



func entryDate(_ dateInString:String)->Date {
	
	let datemaker = DateFormatter()
	datemaker.calendar = userCalendar
	datemaker.dateFormat = "yyyy/MM/dd hh:mm"
	datemaker.locale = myLocale
	
	if let dateEntry = datemaker.date(from: dateInString) {
		return dateEntry
	} else {
		return Date()
	}
}

func recordDate(date:Date)->String{
	let datemaker = DateFormatter()
	datemaker.calendar = userCalendar
	datemaker.dateFormat = "yyyy/MM/dd hh:mm"
	datemaker.locale = myLocale
	
	return datemaker.string(from: date)
	
}

//MARK: Weather

enum Weather:Int {
	case  sun = 0
	case  rain = 1
	case  snow = 2
	case  storm = 3
	case  cloud = 4
}




//Щоденник
class RecordBook{
	
	fileprivate var records:[Record]
	
	init() {
		records = []
		
		records.append( Record(date: entryDate("2001/09/11 09:11"), name:"Какайа боль"  , text:"Жизнь боль......",weather: Weather.storm ))
		records.append( Record(date: entryDate("2016/11/6 18:59"),  name:"Я дурію"      , text: "а ем крейзі енд е лейзі енд ай нов іт",weather: Weather.sun))
		records.append( Record(date: entryDate("2016/11/7 18:59"),  name:"Ніч"          , text: "Хочу спати - рано вставати",weather: Weather.rain))
		records.append( Record(date: entryDate("2016/09/31 23:59"), name:"Кульпарків"   , text: "Вивчаю Свіфт",weather: Weather.snow))
		records.append( Record(date: entryDate("2016/10/21 17:00"), name:"Наполеон"     , text: "ЙА БОХ",weather: Weather.rain))
		records.append( Record(date: entryDate("2016/09/14 18:59"), name:"ХЗ"           , text: "ХТО ЗНАЄ ДЕ ЗНАЙДЕШ А ДЕ ЗАГУБИШ",weather: Weather.snow))
		records.append( Record(date: entryDate("2016/09/14 18:59"), name:"Кукувруку"    , text: "Какімакі і до фікі нагінакі",weather: Weather.sun))
		
	}
	
	init(records:[Record]){
		self.records = records
	}
	
	
	var allRecord: [Record] {
		return self.records.sorted(){$0.date > $1.date}
	}
	
	func addRecord(_ record: Record) {
		records.append(record)
	}
	
	func removeRecord(_ record: Record) {
		if let i = self.records.index(of: record) {
			records.remove(at: i)
		} else {
			debugPrint("Error in removeyRecord: cannot find record")
		}
	}
	
	
}

//Запис в щоденнику
class Record:NSObject {
	
	var date:Date
	var name:String?
	var text:String?
	var weather:Weather = .sun
	var jsonDictionary:[String:String]{
		return [
			"date":recordDate(date:self.date),
			"name":self.name ?? "",
			"text":self.text ?? "",
			"weather": String(self.weather.rawValue)
		]
		
	}
	
	
	var DateHumanReadable:String{
		
		let formatter = DateFormatter()
		formatter.locale = myLocale
		
		if let dateTimeOption = UserDefaults.standard.object(forKey: "dateTimeOption") as? Bool {
			if dateTimeOption == true {
				formatter.dateStyle = .medium
				formatter.timeStyle = .short
	
			}else{
				formatter.dateStyle = .medium
				formatter.timeStyle = .none
			}
			
		}else{
			UserDefaults.standard.set(false, forKey: "dateTimeOption")
			formatter.dateStyle = .medium
			formatter.timeStyle = .none
		}
		
		
		if let humanReadableDates = UserDefaults.standard.object(forKey: "humanReadableDates") as? Bool {
			formatter.doesRelativeDateFormatting = humanReadableDates
		}else{
			
			UserDefaults.standard.set(true, forKey: "humanReadableDates")
			formatter.doesRelativeDateFormatting = true
		}
		
		return formatter.string(from: self.date)
	}
	
	init(date:Date) {
		self.date = date
	}
	
	convenience init(date:Date,name:String?,text:String?,weather:Weather?){
		self.init(date:date)
		self.name = name?.capitalized
		self.text = text?.capitalized
		self.weather = weather ?? .sun
	}
	
	
	
}


