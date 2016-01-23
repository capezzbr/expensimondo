//
//  MondoAPI.swift
//  ExpensiMondo
//
//  Created by Gilbert Jolly on 23/01/2016.
//  Copyright © 2016 Gilbert Jolly. All rights reserved.
//

import Foundation


public class MondoAPI : NSObject {
    
    static let instance = MondoAPI()
    let manager = AFHTTPSessionManager(baseURL: NSURL(string:"https://api.getmondo.co.uk"))
    
    override init() {
        manager.requestSerializer = AFHTTPRequestSerializer();

        super.init()
    }
    
    func fetchToken(){
        let (username, password) = fetchCredentials()
        
        let params = ["grant_type":"password",
                      "client_id":"oauthclient_000094RpteIGEnsZRmJrtJ",
                      "client_secret":"UuoNeRGv470bs0sCnpdWB7OqpCdcXbumna8OrISugyCjutS6zUqEqJy72cyO8hgwXkg+utcfBBdnFn6HAHde",
                      "username": username,
                      "password": password]
        
        
        
        manager.POST("oath2/token", parameters: nil, constructingBodyWithBlock: { (data) -> Void in
            
            for key in params.keys {
                let value = params[key]! as String
                let valueData = value.dataUsingEncoding(NSUTF8StringEncoding)
                data.appendPartWithFormData(valueData!, name: key)
            }
            
            }, success: { (task, response) -> Void in
                print(response)
            }) { (task, error) -> Void in
                print(error)
        }
    }
    
    func fetchCredentials() -> (String, String){
        let path = NSBundle.mainBundle().pathForResource("Credentials", ofType: ".json")
        let data = NSData(contentsOfFile: path!)
        
        let dict = try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
        print(dict)
        let username = dict["username"] as! String
        let password = dict["password"] as! String
        return (username, password)
    }
}