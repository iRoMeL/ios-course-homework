//
//  CustomLines.swift
//  CrazyNotes
//
//  Created by Roman Melnychok on 14.11.16.
//  Copyright © 2016 RoMeL. All rights reserved.
//

import UIKit

class CustomLines: UIView {

        override func draw(_ rect: CGRect) {
			
		
			let aPath = UIBezierPath()
			
			aPath.move(to: CGPoint(x:43, y:0))
			aPath.addLine(to: CGPoint(x:43, y:50))
			aPath.close()
			UIColor.lightGray.set()
			aPath.stroke()
			aPath.fill()
			
			let bPath = UIBezierPath()
			
			bPath.move(to: CGPoint(x:43, y:25))
			bPath.addLine(to: CGPoint(x:125, y:25))
			bPath.close()
			UIColor.lightGray.set()
			bPath.stroke()
			bPath.fill()
			
	
			
	
	}
	
	

}
