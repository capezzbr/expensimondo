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

@interface ExpensifyAPI ()

@property (nonnull, nonatomic, retain) NSString *partnerUserID;
@property (nonnull, nonatomic, retain) NSString *partnerUserSecret;

@end

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
        [self loadConfiguration];
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
                @"partnerUserID": self.partnerUserID,
                @"partnerUserSecret": self.partnerUserSecret
        },
        @"inputSettings": @{
                @"type": @"expenses",
                @"employeeEmail": @"expensimondo@gmail.com",
                @"transactionList": transactionsArray
        }
    };
  
    __weak ExpensifyAPI *this = self;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
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

- (NSString *)jsonFromDictionary:(NSDictionary *)dictionary {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
    if (!jsonData) {
        NSLog(@"Unable to serialise the dictionary, error %@", error);
        return @"{}";
    }
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (nonnull NSDictionary *)dictionaryFromJson:(NSString *)json {
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding]
                                                               options:kNilOptions
                                                                 error:&error];
    if (!dictionary) {
        NSLog(@"Unable to deserialise the dictionary, error %@", error);
        return @{};
    }
    
    return dictionary;
}

- (void)loadConfiguration {
    NSError *error;
    NSString *filename = [[NSBundle mainBundle] pathForResource:@"Configuration" ofType:@".json"];
    NSString *fileContent = [NSString stringWithContentsOfFile:filename encoding:NSUTF8StringEncoding error:&error];
    if (!fileContent) {
        @throw([NSException exceptionWithName:@"FileNotFound"
                                       reason:@"You need to create a config file with the credentials."
                                     userInfo:nil]);
    }
    
    NSDictionary *config = [self dictionaryFromJson:fileContent];
    NSDictionary *expensifyConfig = config[ @"expensify" ];
    
    self.partnerUserID = expensifyConfig[ @"partnerUserID" ];
    self.partnerUserSecret = expensifyConfig[ @"partnerUserSecret" ];
}

@end
