//
//  MondoAuthenticator.swift
//  ExpensiMondo
//
//  Created by Gilbert Jolly on 23/01/2016.
//  Copyright © 2016 Gilbert Jolly. All rights reserved.
//

import Foundation
import UIKit
public typealias LoginCallback = (success: Bool) -> Void


public class MondoAuthenticator : NSObject {
    
    public static let instance = MondoAuthenticator()
    let oath2: OAuth2CodeGrant
    var callback: LoginCallback = {_ in}
    
    override init() {
        let settings = ["client_id":"oauthclient_000094RpteIGEnsZRmJrtJ",
                        "client_secret":"UuoNeRGv470bs0sCnpdWB7OqpCdcXbumna8OrISugyCjutS6zUqEqJy72cyO8hgwXkg+utcfBBdnFn6HAHde",
                        "token_uri":"https://api.getmondo.co.uk/oauth2/token",
                        "authorize_uri":"https://auth.getmondo.co.uk",
                        "redirect_uris": ["expensimondo://oauth/callback"],
                        "response_type":"code"]
        
        self.oath2 = OAuth2CodeGrant(settings: settings)
        self.oath2.verbose = true
        
        super.init()
    }
    
    
    public func login(callback: LoginCallback){

    }
    
    
    static public func isLoggedIn() -> Bool{
        return false
    }
}