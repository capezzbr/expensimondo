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
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    }
    return self;
}


- (void)createTransaction:(nonnull ExpensifyTransaction *)transaction
             withCallback:(nonnull void (^)(NSError * _Nullable error))callback {
    
    [self createTransactions:@[transaction] withCallback:callback];
}

- (void)createTransactions:(nonnull NSArray<ExpensifyTransaction *> *)transactions
              withCallback:(nonnull void (^)(NSError * _Nullable error))callback {
    
    NSMutableArray *transactionsArray = [[NSMutableArray alloc] initWithCapacity:transactions.count];
    for (ExpensifyTransaction *transaction in transactions) {
        [transactionsArray addObject:[transaction toDictionary]];
    }
    
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
                @"transactionList": transactionsArray
        }
    };
  
    __weak ExpensifyAPI *this = self;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:API_BASE_URL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        NSString *jsonBody = [this jsonFromDictionary:requestJobDescription];
        [formData appendPartWithFormData:[jsonBody dataUsingEncoding:NSUTF8StringEncoding] name:@"requestJobDescription"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"progress %@", uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        NSLog(@"Success %@", responseObject);
        callback( nil );
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error %@", error);
        callback( error );
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
