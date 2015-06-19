//
//  DRGFakeKeyboardManagerDelegate.h
//  DRGKeyboardManager
//
//  Created by David Regatos on 16/06/15.
//  Copyright (c) 2015 DRG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRGKeyboardManager.h"

@interface DRGFakeKeyboardManagerDelegate : NSObject <DRGKeyboardManagerDelegate>

@property (nonatomic, getter = isKeyboardShown) BOOL keyboardShown;
@property (nonatomic, getter = isKeyboardHidden) BOOL keyboardHidden;
@property (nonatomic, getter = willKeyboardShown) BOOL keyboardWillBeShown;
@property (nonatomic, getter = willKeyboardHidden) BOOL keyboarWillBeHidden;

@end
