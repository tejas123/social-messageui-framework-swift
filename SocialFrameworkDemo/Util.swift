//
//  Util.swift
//  SocialFrameworkDemo
//
//  Created by TheAppGuruz-New-6 on 16/09/14.
//  Copyright (c) 2014 TheAppGuruz-New-6. All rights reserved.
//

import UIKit

class Util: NSObject
{
    class func invokeAlertMethod(strTitle: String, strBody: String, delegate: AnyObject?) {
        var alert: UIAlertView = UIAlertView()
        alert.message = strBody
        alert.title = strTitle
        alert.delegate = delegate
        alert.addButtonWithTitle("Ok")
        alert.show()
    }
   
}
