//
//  AppDelegate.swift
//  CrazyNotes
//
//  Created by Roman Melnychok on 29.10.16.
//  Copyright © 2016 RoMeL. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var crazyBook : RecordBook?
    
    func loadCrazyBook() {
        if let url = localDataURL {
            if let jsonData = try? Data(contentsOf: url) {
                
                var deserializedRecords:[Record] = []
                
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                    
                    if let arrayOfDictionaries = jsonObject as? [[String: String]] {
                        for dict in arrayOfDictionaries {
                            let name = dict["name"] ?? ""
                            let text = dict["text"] ?? ""
                            let stringWeather = dict["weather"] ?? "0"
                            let weatherEntry:Weather
                            
                            if let intWeather = Int(stringWeather) {
                                weatherEntry =  Weather(rawValue:intWeather)!
                            }else{
                                weatherEntry = Weather.sun
                            }
                            
                            let dateEntry:Date
                            if let dateString = dict["date"]{
                                dateEntry = entryDate(dateString)
                            }else{
                              dateEntry = Date()
                            }
                            if !name.isEmpty {
                                let record = Record(date: dateEntry, name: name, text: text, weather: weatherEntry)
                                deserializedRecords.append(record)
                            }
                        }
                    }
                } catch {
                }
                if deserializedRecords.count>0 {
                    crazyBook = RecordBook(records: deserializedRecords)
                }
                 }
        }
        if crazyBook == nil {
            crazyBook = RecordBook()
        }
    }
    
    
    func saveCrazyBook() {
        if let url = localDataURL {
            if let crazyBook = crazyBook {
                
                var arrayToSerialize : [[String: String]] = [[:]]
                
                for rec in crazyBook.allRecord {
                    arrayToSerialize.append(rec.jsonDictionary)
                }
                
                // convert to JSON
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: arrayToSerialize, options: [])
                    // write to file
                    if jsonData.count > 0 {
                        try? jsonData.write(to: url, options: [.atomic])
                    }
                    
                } catch {
                    print("Error")
                }
                
            }
        }
    }
    
    fileprivate lazy var localDataDirectoryURL: URL? = {
        
        var error : NSError? = nil
        do {
            let url = try FileManager.default.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: true)
            return url
        } catch var error1 as NSError {
            error = error1
            print("Error: Cannot create directory for storing local data, error: \(error)")
        } catch {
            fatalError()
        }
        return nil
    }()

    
    fileprivate lazy var localDataURL: URL? = {
        
        if let url = self.localDataDirectoryURL {
            let fileUrl = url.appendingPathComponent("crazyBook2.json")
            return fileUrl
        }
        return nil
    }()

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        loadCrazyBook()
        //crazyBook = RecordBook()//тест
        
        if let rootNavController = window?.rootViewController as? UINavigationController {
            if let masterController = rootNavController.topViewController as? TableVC {
                masterController.recordBook = crazyBook
            }
        } else {
            debugPrint("Unexpected root view controller structure")
        }

        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        saveCrazyBook()
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
         saveCrazyBook()
        
    }


}

