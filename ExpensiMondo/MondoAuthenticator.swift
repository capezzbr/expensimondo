//
//  MondoAuthenticator.swift
//  ExpensiMondo
//
//  Created by Gilbert Jolly on 23/01/2016.
//  Copyright © 2016 Gilbert Jolly. All rights reserved.
//

import Foundation
import UIKit
public typealias LoginCallback = (NSError?) -> Void


public class MondoAuthenticator : NSObject {
    
    public static let instance = MondoAuthenticator()
    let oath2: OAuth2CodeGrant
    var callback: LoginCallback = {_ in}
    
    override init() {
        let settings = ["client_id":"oauthclient_000094RpteIGEnsZRmJrtJ",
                        "client_secret":"UuoNeRGv470bs0sCnpdWB7OqpCdcXbumna8OrISugyCjutS6zUqEqJy72cyO8hgwXkg+utcfBBdnFn6HAHde",
                        "authorize_uri":"https://auth.getmondo.co.uk",
                        "redirect_uris": ["expensimondo://oauth/callback"],
                        "state":"alsudfqoinertucilnadilnu",
                        "response_type":"code"]
        
        self.oath2 = OAuth2CodeGrant(settings: settings)
        self.oath2.verbose = true
        
        super.init()
    }
    
    
    public func login(vc: UIViewController, callback: LoginCallback){
        self.callback = callback
        
        oath2.onAuthorize =  {
            params in
            vc.dismissViewControllerAnimated(true, completion: {})
        }
        
        oath2.onFailure = {
            error in
            if let error = error{
                self.callback(error)
            }
        }
        let webVC = oath2.authorizeEmbeddedFrom(vc, params: [:])
        webVC?.title = "Mondo Login"
    }
    
    
    static public func isLoggedIn() -> Bool{
        return false
    }
}