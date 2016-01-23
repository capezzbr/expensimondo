//
//  MondoAuthenticator.swift
//  ExpensiMondo
//
//  Created by Gilbert Jolly on 23/01/2016.
//  Copyright © 2016 Gilbert Jolly. All rights reserved.
//

import Foundation
import UIKit


public typealias LoginCallback = (error: NSError?) -> Void


public class MondoAuthenticator : NSObject {
    
    public static let instance = MondoAuthenticator()
    let oath2: OAuth2CodeGrant
    var callback: LoginCallback = {_ in}
    
    override init() {
        let settings = ["client_id":"oauthclient_000094SAgQehjKdTolZG5p",
                        "client_secret":"pmO82ayM6W7rF1jRZndD5gfZJxIXyNY6k9+f7VJSOgEcaJSemthlIZLycCrz9L9A8aAXCD68y2u9UBk1r8Da",
                        "token_uri":"https://api.getmondo.co.uk/oauth2/token",
                        "authorize_uri":"https://auth.getmondo.co.uk",
                        "redirect_uris": ["expensimondo://oauth/callback"],
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
                self.callback(error: error)
            }
        }
        let webVC = oath2.authorizeEmbeddedFrom(vc, params: [:])
        webVC?.title = "Mondo Login"
    }
    
    
    static public func isLoggedIn() -> Bool{
        return false
    }
}