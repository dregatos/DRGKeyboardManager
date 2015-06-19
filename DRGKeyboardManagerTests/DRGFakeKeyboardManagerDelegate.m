//
//  DRGFakeKeyboardManagerDelegate.m
//  DRGKeyboardManager
//
//  Created by David Regatos on 16/06/15.
//  Copyright (c) 2015 DRG. All rights reserved.
//

#import "DRGFakeKeyboardManagerDelegate.h"

@implementation DRGFakeKeyboardManagerDelegate

#pragma mark - DRGKeyboardManagerDelegate

- (void)keyboardManagerDidShowKeyboard:(DRGKeyboardManager *)kbManager {
    self.keyboardShown = YES;
}

- (void)keyboardManagerDidHideKeyboard:(DRGKeyboardManager *)kbManager {
    self.keyboardHidden = YES;
}

- (void)keyboardManagerWillHideKeyboard:(DRGKeyboardManager *)kbManager {
    self.keyboarWillBeHidden = YES;
}

- (void)keyboardManagerWillShowKeyboard:(DRGKeyboardManager *)kbManager {
    self.keyboardWillBeShown = YES;
}

@end
