//
//  ScrollViewController.h
//  DRGKeyboardManager
//
//  Created by David Regatos on 16/06/15.
//  Copyright (c) 2015 DRG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIControl *scrollContentView;

@property (weak, nonatomic) IBOutlet UITextField *topTextField;
@property (weak, nonatomic) IBOutlet UITextField *middleTextField;
@property (weak, nonatomic) IBOutlet UITextField *bottomTextField;

@end
