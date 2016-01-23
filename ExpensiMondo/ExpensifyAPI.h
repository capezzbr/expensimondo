//
//  ExpensifyAPI.h
//  ExpensiMondo
//
//  Created by Bruno Capezzali on 1/23/16.
//  Copyright © 2016 Gilbert Jolly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExpensifyTransaction.h"

@interface ExpensifyAPI : NSObject

+ (nonnull id)sharedManager;
- (void)createTransaction:(nonnull ExpensifyTransaction *)transaction
             withCallback:(nonnull void (^)(NSError * _Nullable error))callback;

@end
