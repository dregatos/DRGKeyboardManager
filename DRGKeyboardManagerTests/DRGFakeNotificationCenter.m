//
//  DRGFakeNotificationCenter.m
//  MyWallet
//
//  Created by David Regatos on 12/06/15.
//  Copyright (c) 2015 DRG. All rights reserved.
//

#import "DRGFakeNotificationCenter.h"

@implementation DRGFakeNotificationCenter

- (instancetype)init {
    if (self = [super init]) {
        _observers = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)addObserver:(id)observer
           selector:(SEL)aSelector
               name:(NSString *)aName
             object:(id)anObject {
        
    [self.observers setObject:observer forKey:aName];
}

- (void)removeObserver:(id)observer
                  name:(NSString *)aName
                object:(id)anObject {
    
    [self.observers removeObjectForKey:aName];
}

@end
