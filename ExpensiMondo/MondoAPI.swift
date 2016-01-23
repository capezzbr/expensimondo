//
//  MondoAPI.swift
//  ExpensiMondo
//
//  Created by Gilbert Jolly on 23/01/2016.
//  Copyright © 2016 Gilbert Jolly. All rights reserved.
//

import Foundation
import Alamofire


public class MondoAPI : NSObject {
    
    static let instance = MondoAPI()
    let token = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjaSI6Im9hdXRoY2xpZW50XzAwMDA5NFB2SU5ER3pUM2s2dHo4anAiLCJleHAiOjE0NTM4MjI2OTgsImlhdCI6MTQ1MzU2MzQ5OCwianRpIjoidG9rXzAwMDA5NFM3ZDAwRTRLZ2R5SlA2NUIiLCJ1aSI6InVzZXJfMDAwMDk0SzJBOWZ5eUNyZklyVGxrdiIsInYiOiIxIn0.ki-Br2aJQZsJPgXQu7eGQ9c1DimHuIJPYqWu4DjleAE"
    
    override init() {

        super.init()
    }
    
    func fetchToken(){
        let (username, password) = loadCredentials()
        
        let params = ["grant_type":"password",
                      "client_id":"oauthclient_000094RpteIGEnsZRmJrtJ",
                      "client_secret":"UuoNeRGv470bs0sCnpdWB7OqpCdcXbumna8OrISugyCjutS6zUqEqJy72cyO8hgwXkg+utcfBBdnFn6HAHde",
                      "username": username,
                      "password": password]
    }
    
    func loadCredentials() -> (String, String){
        let path = NSBundle.mainBundle().pathForResource("Credentials", ofType: ".json")
        let data = NSData(contentsOfFile: path!)
        
        let dict = try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
        let username = dict["username"] as! String
        let password = dict["password"] as! String
        return (username, password)
    }
    
    
    func fetchTransactions() {
        
        Alamofire.request(.GET, "https://api.getmondo.co.uk/transactions",
            parameters: ["account_id":"acc_000094K2A9kwfl0leKMn7x"],
            encoding: ParameterEncoding.URLEncodedInURL,
            headers: ["Authorization" : token]).response { (request, response, data, error) -> Void in
                let string = NSString(data: data!, encoding: NSUTF8StringEncoding)
        }
    }
}