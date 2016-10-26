//Notebook

import Foundation

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
    
    func getDateHumanReadable(date:Date) -> String {
        return date.description
    }
}


//1
let firstEntry = Record(date: Date(timeIntervalSinceNow: -3600))
firstEntry.fullDescription()

//2
let secondEntry = Record(date: Date(timeIntervalSinceNow:-600), name: "Ніч", tags: ["кава рулить","ніч","сон"], text: "Хочу спати - рано вставати")
secondEntry.fullDescription()

//3
let thirdEntry = Record(date: Date(), name: nil, tags: nil, text: "Хеллов")
thirdEntry.fullDescription()


//Додаткове 1
let ArrayEntry = [thirdEntry,secondEntry,firstEntry]

let sortedArray =  ArrayEntry.sorted() {$0.date < $1.date}

sortedArray

//Додаткове 2



//Додаткове 3
extension Record:CustomStringConvertible{
    var description: String {
        return self.fullDescription()
    }
}
let Entry = secondEntry

print(Entry)

