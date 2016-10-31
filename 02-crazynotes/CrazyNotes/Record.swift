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

enum Weather:Int {
    case  sun = 0
    case  rain = 1
    case  snow = 2
    case  storm = 3
    case  cloud = 4
}

//Запис в щоденнику
class Record {
    static var NaturalLanguage = true
    let date:Date
    var name:String?
    var tags:[String]?
    var text:String?
    var weather:Weather = .sun
    
    
    var DateHumanReadable:String{
        
        let formatter = DateFormatter()
        formatter.locale = myLocale
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.doesRelativeDateFormatting = Record.NaturalLanguage
        
        return formatter.string(from: self.date)
        }
    
    init(date:Date) {
        self.date = date
    }
    
    convenience init(date:Date,name:String?,tags:[String]?,text:String?,weather:Weather?){
        self.init(date:date)
        self.name = name
        self.tags = tags
        self.text = text
        self.weather = weather ?? .sun
    }
    
    func fullDescription() -> String {
        
        var fulldescription = DateHumanReadable
        
        if let _name = name {
            fulldescription += "\r"+_name
        }
        
        if let hashtags = tags{
            fulldescription+="\r"
            for tag in hashtags {
                fulldescription += "["+(tag) + "]"
            }
            
        }
        
        if let _text = text {
            fulldescription += "\r"+_text
        }
        
        return fulldescription
        
    }
    
}

//extension Record:CustomStringConvertible{
//    var description: String {
//        return self.fullDescription()
//    }
//}

