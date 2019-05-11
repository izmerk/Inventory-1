/*
 
 Copyright 2019 Marcus Deuß
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 
 */

//
//  Global.swift
//  Inventory
//  contains global variables and methods, all funcs are static so no variable needed
//
//  Created by Marcus Deuß on 17.04.18.
//  Copyright © 2018 Marcus Deuß. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import os
import LocalAuthentication
import AVFoundation

class Global: NSObject {
    
    // used in about view controller and for sending support emails
    static let versionString = "1.0"
    
    // compression factor in reducing jpg file size to 1/10th (value goes from 0.0 to 1.0)
    static let imageQuality: CGFloat = 0.0
    
    // system sound for drop operation
    static let systemSound = 1322
    
    // name of the app in about view
    static let appNameString = "Inventory App"
    static let emailAdr = "mdeuss+inventory@gmail.com"
    static let website = "https://marcus-deuss.de/?page_id=13"
    static let csvFile = "inventoryAppExport.csv"
    static let pdfFile = NSLocalizedString("Inventory App Report.pdf", comment: "Inventory App Report.pdf") // FIXME: why translate?
    
    // user default keys, also used for key/value iCloud store
    static let keyUserName = "UserName"
    static let keyHouseName = "UserHouse"
    
    // localization string
    static let item = NSLocalizedString("Item", comment: "Item")
    static let category = NSLocalizedString("Category", comment: "Category")
    static let owner = NSLocalizedString("Owner", comment: "Owner")
    static let room = NSLocalizedString("Room", comment: "Room")
    static let brand = NSLocalizedString("Brand", comment: "Brand")
    static let price = NSLocalizedString("Price", comment: "Price")
    static let all = NSLocalizedString("All", comment: "All")
    
    
    static let ok = NSLocalizedString("OK", comment: "OK")
    static let cancel = NSLocalizedString("Cancel", comment: "Cancel")
    static let delete = NSLocalizedString("Delete", comment: "Delete")
    static let confirm = NSLocalizedString("Confirm", comment: "Confirm")
    static let dismiss = NSLocalizedString("Dismiss", comment: "Dismiss")
    static let error = NSLocalizedString("Error", comment: "Error")
    static let done = NSLocalizedString("Done", comment: "Done")
    static let none = NSLocalizedString("None", comment: "None")
    
    static let documentNotFound = NSLocalizedString("Document not found!", comment: "Document not found")
    static let chooseDifferentName = NSLocalizedString("Please choose a different name", comment: "Please choose a different name")
    static let emailNotSent = NSLocalizedString("Email could not be sent", comment: "Email could not be sent")
    static let emailDevice = NSLocalizedString("Your device could not send email", comment: "Your device could not send email")
    static let emailConfig = NSLocalizedString("Please check your email configuration", comment: "Please check your email configuration")
    static let support = NSLocalizedString("Support", comment: "Support")
    
    static let takePhoto = NSLocalizedString("Take Photo", comment: "Take Photo")
    static let cameraRoll = NSLocalizedString("Camera Roll", comment: "Camera Roll")
    static let photoLibrary = NSLocalizedString("Photo Library", comment: "Photo Library")
    
    // general functions
    
    //User region setting return
    static let locale = Locale.current
    
    //Returns true if the locale uses the metric system (Note: Only three countries do not use the metric system: the US, Liberia and Myanmar.)
    static let isMetric = locale.usesMetricSystem
    
    //Returns the currency code of the locale. For example, for “zh-Hant-HK”, returns “HKD”.
    static let currencyCode  = locale.currencyCode
    
    //Returns the currency symbol of the locale. For example, for “zh-Hant-HK”, returns “HK$”.
    static let currencySymbol = locale.currencySymbol
    
    static let languageCode = locale.languageCode
    
    class func currentLocaleForDate() -> String{
        return languageCode!
    }
    
    // define column names for import and export functions for csv file
    static let inventoryName_csv = "inventoryName"
    static let dateofPurchase_csv = "dateofPurchase"
    static let price_csv = "price"
    static let serialNumber_csv = "serialNumber"
    static let remark_csv = "remark"
    static let timeStamp_csv = "timeStamp"
    static let roomName_csv = "roomName"
    static let ownerName_csv = "ownerName"
    static let categoryName_csv = "categoryName"
    static let brandName_csv = "brandName"
    static let warranty_csv = "warranty"
    static let imageFileName_csv = "imageFileName"
    static let invoiceFileName_csv = "invoiceFileName"
    static let id_csv = "id"
    
    static let csvMetadata = "\(Global.inventoryName_csv),\(Global.dateofPurchase_csv),\(Global.price_csv),\(Global.serialNumber_csv),\(Global.remark_csv),\(Global.timeStamp_csv),\(Global.roomName_csv),\(Global.ownerName_csv),\(Global.categoryName_csv),\(Global.brandName_csv),\(Global.warranty_csv),\(Global.imageFileName_csv),\(Global.invoiceFileName_csv),\(Global.id_csv)\n"
    
    
    // MARK: - helper functions
    
    // sending a local notification
    
    /// send a local notification (does not require server)
    ///
    /// - Parameters:
    ///   - title: notification title
    ///   - subtitle: notification subtitle
    ///   - body: notification body text
    ///   - badge: when using badge show number of messages in icon
    /// - Returns: <none>
    
    class func sendLocalNotification(title: String, subtitle: String, body: String, badge: NSNumber) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.badge = badge
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5,
                                                        repeats: false)
        
        let requestIdentifier = "demoNotification"
        let request = UNNotificationRequest(identifier: requestIdentifier,
                                            content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request,
                                               withCompletionHandler: { (error) in
                                                // Handle error
        })
    }
    
    /// generate a UUID
    ///
    /// - Parameters:
    ///
    ///
    /// - Returns: UUID as String
    
    class func generateUUID() -> String{
        return UUID().uuidString
    }

    /// generate a UUID
    ///
    /// - Parameters:
    ///
    ///
    /// - Returns: UUID
    
    class func generateUUID() -> UUID{
        return UUID()
    }
    

    /// get max of two values
    ///
    /// - Parameters:
    ///   - array: integer array
    ///
    /// - Returns: (minumum value, maximum value)? or nil if array empty

    class func minMax(array: [Int]) -> (min: Int, max: Int)? {
        if array.isEmpty { return nil }
        var currentMin = array[0]
        var currentMax = array[0]
        for value in array[1..<array.count] {
            if value < currentMin {
                currentMin = value
            } else if value > currentMax {
                currentMax = value
            }
        }
        return (currentMin, currentMax)
    }
    
    /// call iOS app settings dialog from inside the app
    ///
    /// - Parameters:
    ///
    ///
    /// - Returns:
    
    class func callAppSettings(){
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    // Finished opening URL
                })
            } else {
                // Fallback on earlier versions
                UIApplication.shared.openURL(settingsUrl)
            }
        }
    }
    
    /// show an alert dialog
    ///
    /// - Parameters:
    ///   - title: notification title
    ///   - message: notification message
    ///
    /// - Returns:

    class func showAlertController(title: String, message: String) {
        if title.count == 0{
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: Global.ok, style: .default, handler: nil))
        }
        else{
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: Global.ok, style: .default, handler: nil))
        }
        //present(alertController, animated: true, completion: nil)
    }
    
    
    /// authenticate with touch id or face id
    ///
    /// - Parameters:
    ///
    /// - Returns: true if auth did work, false otherwise

    class func authWithTouchID(_ sender: Any) -> Bool{
        // Get the authentication context from the Local Authentication framework
        let context = LAContext()
        var error: NSError?
        var successFlag : Bool = false
        
        // The canEvaluatePolicy method checks if Touch ID is available on the device
        // check if Touch ID is available
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // The policy is evaluated where the third parameter is a completion handler block.
            let reason = NSLocalizedString("Authenticate with Touch ID", comment: "Authenticate with Touch ID")
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply:
                {(success, error) in
                    // An Alert message is shown wether the Touch ID authentication succeeded or not
                    if success {
                        self.showAlertController(title: "", message: "Touch ID Authentication Succeeded")
                        os_log("Global authWithTouchID: touch ID Authentication succeeded", log: Log.viewcontroller, type: .info)
                        
                        successFlag = true
                    }
                    else {
                        self.showAlertController(title: "", message: "Touch ID Authentication Failed")
                        os_log("Global authWithTouchID: touch ID Authentication failed", log: Log.viewcontroller, type: .error)
                    }
            })
        }
            // If Touch ID is not available an Alert message is shown.
        else {
            showAlertController(title: "", message: "Touch ID not available")
            os_log("Global authWithTouchID: touch ID not available", log: Log.viewcontroller, type: .error)
        }
        
        return successFlag
    }
    
    /// check for camera permissions
    ///
    /// - Parameters:
    ///
    /// - Returns: true if camera allowed, false otherwise

    class func checkCameraPermission() -> Bool{
        //os_log("Global checkCameraPermission", log: Log.viewcontroller, type: .info)
        
        var allowed : Bool = true
        
        // check for camera permissions
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: // The user has previously granted access to the camera.
            allowed = true
            break
            
        case .notDetermined: // The user has not yet been asked for camera access.
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    allowed = true
                }
            }
            
        case .denied: // The user has previously denied access.
            allowed = false
            break
            
        case .restricted: // The user can't grant access due to restrictions.
            allowed = false
            break
            
        @unknown default:
            os_log("Global checkCameraPermission", log: Log.viewcontroller, type: .error)
        }
        
        return allowed
    }
    
    // give filename based on current date, independent of current locale
    // format like invname_20191022060310
    static func generateFilename(invname: String) -> String{
        //os_log("Global generateFilename", log: Log.viewcontroller, type: .info)
        
        let cal = Calendar.current
        let now = Date()
        let comps = cal.dateComponents([.day, .month, .year, .hour, .minute, .second], from: now)
        
        let imageName = invname + "_" + String(comps.year!) + "_" + String(comps.day!) + "_" + String(comps.month!) + "_" + String(comps.hour!) + "_" + String(comps.minute!) + "_" + String(comps.second!)
        
        return imageName
    }
    
    // helper for saving dropped file in temp directory, and getting if back from URL
    static func createTempDropObject(fileItems: [DropFile]) -> URL?{
        //os_log("Global createTempDropObject", log: Log.viewcontroller, type: .info)
        
        let docURL = (FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)).last as NSURL?
        let dropFilePath = docURL!.appendingPathComponent("File")!.appendingPathExtension("pdf")
        
        for file in fileItems {
            do {
                try file.fileData?.write(to:dropFilePath)
            } catch {
                os_log("Global createTempDropObject", log: Log.viewcontroller, type: .error)
            }
        }
        
        return dropFilePath
    }
    
    // scale an image
    static func scaleImage (image:UIImage, width: CGFloat) -> UIImage {
        let oldWidth = image.size.width
        let scaleFactor = width / oldWidth
        
        let newHeight = image.size.height * scaleFactor
        let newWidth = oldWidth * scaleFactor
        
        UIGraphicsBeginImageContext(CGSize(width:newWidth, height:newHeight))
        image.draw(in: CGRect(x:0, y:0, width:newWidth, height:newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

// extensions
extension String {
    /*
     Truncates the string to the specified length number of characters and appends an optional trailing string if longer.
     - Parameter length: Desired maximum lengths of a string
     - Parameter trailing: A 'String' that will be appended after the truncation.
     
     - Returns: 'String' object.
     Swift 4.0 Example
     let str = "I might be just a little bit too long".truncate(10) // "I might be…"
     */
    func truncate(length: Int, trailing: String = "…") -> String {
        return (self.count > length) ? self.prefix(length) + trailing : self
    }
    
    // return an array of lines of strings
    var lines: [String] {
        return self.components(separatedBy: "\n")
    }
}

// used to create folders inside of document folder like this:
// For example, to create the folder "MyStuff", you would call it like this:
// let myStuffURL = URL.createFolder(folderName: "MyStuff")
extension URL {
    static func createFolder(folderName: String) -> URL? {
        let fileManager = FileManager.default
        // Get document directory for device, this should succeed
        if let documentDirectory = fileManager.urls(for: .documentDirectory,
                                                    in: .userDomainMask).first {
            // Construct a URL with desired folder name
            let folderURL = documentDirectory.appendingPathComponent(folderName)
            // If folder URL does not exist, create it
            if !fileManager.fileExists(atPath: folderURL.path) {
                do {
                    // Attempt to create folder
                    try fileManager.createDirectory(atPath: folderURL.path,
                                                    withIntermediateDirectories: true,
                                                    attributes: nil)
                } catch {
                    // Creation failed. Print error & return nil
                    print(error.localizedDescription)
                    return nil
                }
            }
            // Folder either exists, or was created. Return URL
            return folderURL
        }
        // Will only be called if document directory not found
        return nil
    }
}
