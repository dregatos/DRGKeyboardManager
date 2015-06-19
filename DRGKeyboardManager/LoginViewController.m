//
//  LoginViewController.m
//  DRGKeyboardManager
//
//  Created by David Regatos on 16/06/15.
//  Copyright (c) 2015 DRG. All rights reserved.
//

#import "LoginViewController.h"
#import "DRGKeyboardManager.h"

@interface LoginViewController ()

@property (nonatomic, strong) DRGKeyboardManager *kbManager;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithHue:0/359.0 saturation:0/100.0 brightness:95/100.0 alpha:1.];

    self.kbManager = [[DRGKeyboardManager alloc] initForViewController:self];
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

@end
