//
//  ExpensifyTransaction.h
//  ExpensiMondo
//
//  Created by Bruno Capezzali on 1/23/16.
//  Copyright © 2016 Gilbert Jolly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpensifyTransaction : NSObject

@property (nonatomic, readwrite, nonnull) NSString *merchant;
@property (nonatomic, readwrite, nonnull) NSString *created;
@property (nonatomic, readwrite) NSInteger amount;
@property (nonatomic, readwrite, nonnull) NSString *currency;
@property (nonatomic, readwrite, nullable) NSString *externalID;
@property (nonatomic, readwrite, nullable) NSString *comment;

+ (nonnull ExpensifyTransaction *)transactionWithMerchant:(nonnull NSString *)merchant
                                                  created:(nonnull NSString *)created
                                                   amount:(NSInteger)amount
                                                 currency:(nonnull NSString *)currency
                                               externalID:(nullable NSString *)externalID
                                                  comment:(nullable NSString *)comment;

- (nonnull NSDictionary *)toDictionary;

@end