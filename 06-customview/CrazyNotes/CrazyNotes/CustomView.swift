//
//  CustomView.swift
//  CrazyNotes
//
//  Created by Roman Melnychok on 13.11.16.
//  Copyright © 2016 RoMeL. All rights reserved.
//

import UIKit

class CustomView: UIView {

	var record:Record?{
		didSet {
			//if window != nil {
			updateEntry()
			//}
		}
	}
	

	
	// дата
	@IBOutlet weak var containerDate: UIView!
	@IBOutlet weak var entryDate: UILabel!
	// картинка погоди
	@IBOutlet weak var containerImage: UIView!
	@IBOutlet weak var imageMood: UIImageView!
	// назва запису
	@IBOutlet weak var containerText: UIView!
	@IBOutlet weak var entryText: UILabel!
	@IBOutlet weak var customLines: CustomLines!
	
	override func awakeFromNib() {
		
		super.awakeFromNib()

	
		updateEntry()
		
	}
	
	func updateEntry() {
		
		
		
		let colorMood = moodColor(record?.weather)
		
		
		for containerView in [containerDate,containerImage,containerText] {
			if let rect = containerView?.bounds {
				containerView?.layer.cornerRadius = 0.5 * rect.size.height
			}
			containerView?.layer.borderColor = colorMood.cgColor
			containerView?.layer.borderWidth = 1.0
			containerView?.tintColor	= colorMood
			//containerView?.clipsToBounds = true
			//containerView?.tintColor = colorMood
		}

		
			entryDate?.text				 = record?.shortDate
			entryDate?.textColor		 = colorMood
		    //imageMood?.image			 = imageMood(record?.weather)
		
	
			imageMood?.tintColor		 = colorMood
			imageMood?.isHighlighted	 = true
			imageMood?.highlightedImage  = imageMood(record?.weather)
			imageMood?.layer.borderColor = colorMood.cgColor
		
			entryText?.text				 = record?.name
			entryText?.textColor		 = colorMood
		

	}
	
	
	func imageMood(_ weather:Weather?) -> UIImage {
		
		if weather != nil {
			
			switch weather! {
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
		else {
			return #imageLiteral(resourceName: "weather_sun")
		}
		
	}
	
	func moodColor(_ weather:Weather?) -> UIColor {
		
		if weather != nil {
			
			switch weather! {
			case .sun:
				return UIColor.orange
			case .rain:
				return UIColor.purple
			case .snow:
				return UIColor.gray
			case .storm:
				return UIColor.red
			case .cloud:
				return UIColor.black
			}
		}
		else {
			return UIColor.orange
		}
		
	}

	

	
	
	
	
}
