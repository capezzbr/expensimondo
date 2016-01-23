//
//  ExpensifyTransaction.m
//  ExpensiMondo
//
//  Created by Bruno Capezzali on 1/23/16.
//  Copyright © 2016 Gilbert Jolly. All rights reserved.
//

#import "ExpensifyTransaction.h"

@implementation ExpensifyTransaction

+ (nonnull ExpensifyTransaction *)transactionWithMerchant:(nonnull NSString *)merchant
                                                  created:(nonnull NSString *)created
                                                   amount:(NSInteger)amount
                                                 currency:(nonnull NSString *)currency
                                               externalID:(nullable NSString *)externalID
                                                  comment:(nullable NSString *)comment {
    
    ExpensifyTransaction *transaction = [ExpensifyTransaction new];
    transaction.merchant = merchant;
    transaction.created = created;
    transaction.amount = amount;
    transaction.currency = currency;
    transaction.externalID = externalID;
    transaction.comment = comment;
    
    return transaction;
}

- (nonnull NSDictionary *)toDictionary {
    
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    [dictionary setValue:self.merchant forKey:@"merchant"];
    [dictionary setValue:self.created forKey:@"created"];
    [dictionary setValue:[NSNumber numberWithLong:self.amount] forKey:@"amount"];
    [dictionary setValue:self.currency forKey:@"currency"];
    
    if (self.externalID) {
        [dictionary setValue:self.externalID forKey:@"externalID"];
    }
    
    if (self.comment) {
        [dictionary setValue:self.comment forKey:@"comment"];
    }
    
    return dictionary;
}


@end