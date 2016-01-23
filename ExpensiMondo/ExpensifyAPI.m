//
//  ExpensifyAPI.m
//  ExpensiMondo
//
//  Created by Bruno Capezzali on 1/23/16.
//  Copyright © 2016 Gilbert Jolly. All rights reserved.
//

#import "ExpensifyAPI.h"

@implementation ExpensifyAPI

#pragma mark Singleton Methods

+ (id)sharedManager {
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



@end
