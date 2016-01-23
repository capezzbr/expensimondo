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

- (void)createTransaction:(nonnull ExpensifyTransaction *)transaction;

@end
