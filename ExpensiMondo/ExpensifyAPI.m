//
//  ExpensifyAPI.m
//  ExpensiMondo
//
//  Created by Bruno Capezzali on 1/23/16.
//  Copyright © 2016 Gilbert Jolly. All rights reserved.
//

#import "ExpensifyAPI.h"
#import "AFNetworking.h"

static NSString *API_BASE_URL = @"https://integrations.expensify.com/Integration-Server/ExpensifyIntegrations";

@implementation ExpensifyAPI

#pragma mark Singleton Methods

+ (nonnull id)sharedManager {
    static ExpensifyAPI *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {

    }
    return self;
}

- (void)createTransaction:(nonnull ExpensifyTransaction *)transaction {
    
    NSDictionary *requestJobDescription =
    @{
        @"type": @"create",
        @"credentials": @{
                @"partnerUserID": @"",
                @"partnerUserSecret": @""
        },
        @"inputSettings": @{
                @"type": @"expenses",
                @"employeeEmail": @"expensimondo@gmail.com",
                @"transactionList": @[
                        [transaction toDictionary]
                ]
        }
    };
    
    
//    -d 'requestJobDescription={
//    "type": "create",
//    "credentials": {
//        "partnerUserID": "aa_expensimondo_gmail_com",
//        "partnerUserSecret": "d22980dbaa229b6e7aeae4dbcc18b56bcb6a6327"
//    },
//    "inputSettings": {
//        "type": "expenses",
//        "employeeEmail": "expensimondo@gmail.com",
//        "transactionList": [
//                            {
//                                "merchant": "My merchant",
//                                "created": "2016-01-23",
//                                "amount": 100,
//                                "currency": "USD",
//                                "externalID": "UniqueID",
//                                "comment": "My comment"
//                            }
//                            ]
//    }
  
    __weak ExpensifyAPI *this = self;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:API_BASE_URL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSString *jsonBody = [this jsonFromDictionary:requestJobDescription];
        [formData appendPartWithFormData:[jsonBody dataUsingEncoding:NSUTF8StringEncoding] name:@"requestJobDescription"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"progress %@", uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Success %@", responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error %@", error);
    }];
    
}

-(NSString *)jsonFromDictionary:(NSDictionary *)dictionary {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
    if (!jsonData) {
        NSLog(@"Unable to serialise the dictionary, error %@", error);
        return @"{}";
    }
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}




@end
