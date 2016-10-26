//Notebook

import Foundation

// I just want to use dates!
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

//Запис в щоденнику
class Record {
    let date:Date
    var name:String?
    var tags:[String]?
    var text:String?
    
    init(date:Date) {
        self.date = date
     }
    
    convenience init(date:Date,name:String?,tags:[String]?,text:String?){
        self.init(date:date)
        self.name = name
        self.tags = tags
        self.text = text
    }
    
    func fullDescription() -> String {
        
        var fulldescription = getDateHumanReadable()
        
        if let _name = name {
            fulldescription += "\r"+_name
        }
        
        if let hashtags = tags{
            fulldescription+="\r"
            for index in 0..<hashtags.count {
                fulldescription += "["+(hashtags[index]) + "]"
            }
            
        }
        
        if let _text = text {
            fulldescription += "\r"+_text
        }
        
        return fulldescription
        
    }
    
    //Додаткове 2
    func getDateHumanReadable() -> String {
        //Якщо вчора - пише Yesterday, якщо на цьому тижні - день
        //тижня, якщо сьогодні - пише час, і лише якщо давно - пише власне дату
        
        let now = Date()
        let components = userCalendar.dateComponents([.day], from: date, to: now)
        let formatter = DateFormatter()
        formatter.locale = myLocale
        
        // сьогодні
        if let day = components.day, day==0  {
            formatter.setLocalizedDateFormatFromTemplate("hh:mm")
            return formatter.string(from: date)
        }
        // вчора
        if let day = components.day, day==1  {
            return "Вчора"
        }
        // на цьому тижні ( в межах тижня )
        if let day = components.day, day<=6  {
            formatter.setLocalizedDateFormatFromTemplate("EEEE")
            return formatter.string(from: date)
        }
        
        // давно
        formatter.setLocalizedDateFormatFromTemplate("dd MMMM yyyy")
        return formatter.string(from: date)
        
        
    }
}


//1
let firstEntry = Record(date: entryDate("2001/09/11 09:11"))
firstEntry.fullDescription()

//2
let secondEntry = Record(date: entryDate("2016/10/24 18:59"), name: "Ніч", tags: ["кава рулить","ніч","сон"], text: "Хочу спати - рано вставати")
secondEntry.fullDescription()

//3
let thirdEntry = Record(date: entryDate(""), name: nil, tags: nil, text: "Хеллов")
thirdEntry.fullDescription()


//Додаткове 1
let ArrayEntry = [thirdEntry,secondEntry,firstEntry]

let sortedArray =  ArrayEntry.sorted() {$0.date < $1.date}

sortedArray


//Додаткове 3
extension Record:CustomStringConvertible{
    var description: String {
        return self.fullDescription()
    }
}
let Entry = secondEntry

print(Entry)

