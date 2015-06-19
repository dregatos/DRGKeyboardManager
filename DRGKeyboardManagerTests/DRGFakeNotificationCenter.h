//
//  DRGFakeNotificationCenter.h
//  MyWallet
//
//  Created by David Regatos on 12/06/15.
//  Copyright (c) 2015 DRG. All rights reserved.
//

@import Foundation;

@interface DRGFakeNotificationCenter : NSObject

@property (nonatomic, strong) NSMutableDictionary *observers;

- (void)addObserver:(id)observer
           selector:(SEL)aSelector
               name:(NSString *)aName
             object:(id)anObject;

- (void)removeObserver:(id)observer
                  name:(NSString *)aName
                object:(id)anObject;

@end
