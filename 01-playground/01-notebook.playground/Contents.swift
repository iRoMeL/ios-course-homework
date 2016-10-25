//Notebook

import Foundation

class Record:CustomDebugStringConvertible {
    let date:Date
    var name:String?
    var tags:[String]?
    var text:String?
    var debugDescription: String {
        return self.fullDescription()
    }
    
    
    init(date:Date) {
        self.date = date
     }
    
    func fullDescription() -> String {
        
        var fulldescription = date.description
        
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
}


//1
let firstEntry = Record(date: Date(timeIntervalSinceNow: -3600))
firstEntry.fullDescription()

//2
let secondEntry = Record(date: Date(timeIntervalSinceNow:-800))
secondEntry.name = "Ніч"
secondEntry.tags = ["кава рулить","ніч","сон"]
secondEntry.text = "Хочу спати - рано вставати"
secondEntry.fullDescription()

//3
let thirdEntry = Record(date: Date())
thirdEntry.text = "Хеллов"
thirdEntry.fullDescription()


//Додаткове 1
let ArrayEntry = [thirdEntry,secondEntry,firstEntry]

let sortedArray =  ArrayEntry.sorted() {$0.date < $1.date}

sortedArray

//Додаткове 2



//Додаткове 3

let Entry = secondEntry

print(Entry)

