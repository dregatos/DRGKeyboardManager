//
//  ScrollViewController.m
//  DRGKeyboardManager
//
//  Created by David Regatos on 16/06/15.
//  Copyright (c) 2015 DRG. All rights reserved.
//

#import "ScrollViewController.h"
#import "DRGKeyboardManager.h"

@interface ScrollViewController () <DRGKeyboardManagerDelegate, UITextFieldDelegate>

@property (nonatomic, strong) DRGKeyboardManager *kbManager;
@property (nonatomic, strong) UITextField *activeField;

@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithHue:0/359.0 saturation:0/100.0 brightness:95/100.0 alpha:1.];

    self.kbManager = [[DRGKeyboardManager alloc] initForViewController:self];
    self.kbManager.delegate = self;
    
    self.topTextField.delegate = self;
    self.middleTextField.delegate = self;
    self.bottomTextField.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.kbManager beginObservingKeyboard:[NSNotificationCenter defaultCenter]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.kbManager endObservingKeyboard];
}

- (IBAction)didSelectBackground:(UIControl *)sender {
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.activeField = nil;
}

#pragma mark - DRGKeyboardManagerDelegate

- (void)keyboardManagerDidShowKeyboard:(DRGKeyboardManager *)kbManager {
    // handle tableview scroll here
    
    CGRect visibleRect = CGRectInset(self.activeField.frame, 0, -20);

    [self.scrollView scrollRectToVisible:visibleRect animated:YES];
}

- (void)keyboardManagerDidHideKeyboard:(DRGKeyboardManager *)kbManager {
    // do something after view did hide
}


@end
