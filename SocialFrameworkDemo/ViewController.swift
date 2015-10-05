//
//  ViewController.swift
//  SocialFrameworkDemo
//
//  Created by TheAppGuruz-New-6 on 30/07/14.
//  Copyright (c) 2014 TheAppGuruz-New-6. All rights reserved.
//

import UIKit
import Social
import MessageUI


class ViewController: UIViewController,UINavigationControllerDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate,UIAlertViewDelegate {
    
    var objRechability = Reachability.reachabilityForInternetConnection()
    
    @IBOutlet weak var ivImage: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func btnTwitterClicked(sender: AnyObject)
    {
        if objRechability!.isReachable()
        {
            shareTwitter()
        }
        else
        {
            Util .invokeAlertMethod("Warning", strBody: "Internet connection not available.", delegate: self)
        }
    }
    
    @IBAction func btnFacebookClicked(sender: AnyObject)
    {
        if objRechability!.isReachable()
        {
            shareFacebook()
        }
        else
        {
            Util .invokeAlertMethod("Warning", strBody: "Internet connection not available.", delegate: self)
        }
    }
    
    @IBAction func btniMessageClicked(sender: AnyObject)
    {
        shareiMessage()
    }
    
    @IBAction func btnMailClicked(sender: AnyObject)
    {
        if objRechability!.isReachable()
        {
            shareMail()
        }
        else
        {
            Util .invokeAlertMethod("Warning", strBody: "Internet connection not available.", delegate: self)
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func shareFacebook()
    {
        let fvc: SLComposeViewController=SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        fvc.completionHandler =
        {
            result -> Void in
            let getResult = result as SLComposeViewControllerResult;
            switch(getResult.rawValue)
            {
                case SLComposeViewControllerResult.Cancelled.rawValue:
                    Util .invokeAlertMethod("Warning", strBody: "Post Cancalled", delegate: self)
                case SLComposeViewControllerResult.Done.rawValue:
                    Util .invokeAlertMethod("Warning", strBody: "Post Successfull.", delegate: self)
                default:
                    Util .invokeAlertMethod("Warning", strBody: "Error Occured.", delegate: self)
            }
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        self.presentViewController(fvc, animated: true, completion: nil)
        fvc.setInitialText("Facebook Sharing !")
        fvc.addImage(ivImage.image)
        fvc.addURL(NSURL(string: "www.google.com"))
    }
    
    func shareTwitter()
    {
        let tvc: SLComposeViewController=SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        tvc.completionHandler =
            {
                result -> Void in
                let getResult = result as SLComposeViewControllerResult;
                switch(getResult.rawValue)
                {
                    case SLComposeViewControllerResult.Cancelled.rawValue:
                        Util .invokeAlertMethod("Warning", strBody: "Post Cancalled", delegate: self)
                    case SLComposeViewControllerResult.Done.rawValue:
                        Util .invokeAlertMethod("Warning", strBody: "Post Successfull.", delegate: self)
                    default:
                        Util .invokeAlertMethod("Warning", strBody: "Error Occured.", delegate: self)
                }
                self.dismissViewControllerAnimated(true, completion: nil)
        }
        self.presentViewController(tvc, animated: true, completion: nil)
        tvc.setInitialText("Twitter Sharing !")
        tvc.addImage(ivImage.image)
        tvc.addURL(NSURL(string: "www.google.com"))
    }
    
    func shareiMessage()
    {
        let controller: MFMessageComposeViewController=MFMessageComposeViewController()
        if(MFMessageComposeViewController .canSendText())
        {
            controller.body="iMessage Sharing !"
            controller.addAttachmentData(UIImageJPEGRepresentation(UIImage(named: "images.jpg")!, 1)!, typeIdentifier: "image/jpg", filename: "images.jpg")
            controller.delegate=self
            controller.messageComposeDelegate=self
            self.presentViewController(controller, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "Text messaging is not available", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult)
    {
        switch result.rawValue
        {
            case MessageComposeResultCancelled.rawValue:
                Util .invokeAlertMethod("Warning", strBody: "Message cancelled", delegate: self)
            case MessageComposeResultFailed.rawValue:
                Util .invokeAlertMethod("Warning", strBody: "Message failed", delegate: self)
            case MessageComposeResultSent.rawValue:
                Util .invokeAlertMethod("Success", strBody: "Message sent", delegate: self)
            default:
                Util .invokeAlertMethod("Warning", strBody: "error", delegate: self)
        }
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    func shareMail()
    {
        let mailClass:AnyClass?=NSClassFromString("MFMailComposeViewController")
        if(mailClass != nil)
            {
                if((mailClass?.canSendMail()) != nil)
                {
                    displayComposerSheet()
                }
                else
                {
                    launchMailAppOnDevice()
                }
            }
            else
            {
                launchMailAppOnDevice()
            }
    }
    func launchMailAppOnDevice()
    {
        let recipients:NSString="";
        let body:NSString="Mail Sharing"
        var email:NSString="\(recipients) \(body)"
        email=email.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        UIApplication.sharedApplication().openURL(NSURL(string: email as String)!)
    }
    func displayComposerSheet()
    {
        let picker: MFMailComposeViewController=MFMailComposeViewController()
        picker.mailComposeDelegate=self;
        picker .setSubject("Test")
        picker.setMessageBody("Mail Sharing !", isHTML: true)
        let data: NSData = UIImagePNGRepresentation(UIImage(named: "images.jpg")!)!
        
        picker.addAttachmentData(data, mimeType: "image/png", fileName: "images.png")
        
        self.presentViewController(picker, animated: true, completion: nil)
    }
    func mailComposeController(controller:MFMailComposeViewController, didFinishWithResult result:MFMailComposeResult, error:NSError?)
    {
        switch result.rawValue
        {
            case MFMailComposeResultCancelled.rawValue:
                Util .invokeAlertMethod("Warning", strBody: "Mail cancelled", delegate: self)
            case MFMailComposeResultSaved.rawValue:
                Util .invokeAlertMethod("Warning", strBody: "Mail saved", delegate: self)
            case MFMailComposeResultSent.rawValue:
                Util .invokeAlertMethod("Success", strBody: "Mail sent", delegate: self)
            case MFMailComposeResultFailed.rawValue:
                Util .invokeAlertMethod("Warning", strBody: "Mail sent failure", delegate: self)
            default:
                Util .invokeAlertMethod("Warning", strBody: "error", delegate: self)
        }
        self.dismissViewControllerAnimated(false, completion: nil)
    }
}

