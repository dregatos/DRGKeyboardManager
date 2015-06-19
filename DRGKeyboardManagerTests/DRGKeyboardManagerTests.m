//
//  DRGKeyboardManagerTests.m
//  DRGKeyboardManagerTests
//
//  Created by David Regatos on 15/06/15.
//  Copyright (c) 2015 DRG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "DRGKeyboardManager.h"
#import "DRGFakeNotificationCenter.h"
#import "DRGFakeKeyboardManagerDelegate.h"

@interface DRGKeyboardManagerTests : XCTestCase

/** A manager with a containerView = nil */
@property (nonatomic, strong) DRGKeyboardManager *simpleKbManager;

@end

@implementation DRGKeyboardManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    /** Initialized with a nil viewcontroller */
    self.simpleKbManager = [DRGKeyboardManager managerForViewController:nil];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    self.simpleKbManager = nil;
}

#pragma mark - Init

- (void)testcontainerViewPropertyStorage {
    UIViewController *vc = [[UIViewController alloc] init];
    DRGKeyboardManager *kbManager = [[DRGKeyboardManager alloc] initForViewController:vc];
    XCTAssertNotNil(kbManager.containerView, @"Keyboard Manager's containerView should be NOT nil");
    XCTAssertEqualObjects(vc.view, kbManager.containerView, @"containerView should be equal to view");
}

#pragma mark - Notification

- (void)testDidSuscribeToKeyboardNotifications {
    
    DRGFakeNotificationCenter *fakeNC = [[DRGFakeNotificationCenter alloc] init];
    
    [self.simpleKbManager beginObservingKeyboard:(NSNotificationCenter *)fakeNC];
    
    NSDictionary *obs = [fakeNC observers];
    id didShowObserver = [obs objectForKey:UIKeyboardDidShowNotification];
    id willShowObserver = [obs objectForKey:UIKeyboardWillShowNotification];
    id willHideObserver = [obs objectForKey:UIKeyboardWillHideNotification];
    id didHideObserver = [obs objectForKey:UIKeyboardDidHideNotification];

    XCTAssertEqualObjects(didShowObserver, self.simpleKbManager, @"kbManager must be suscribed to UIKeyboardDidShowNotification");
    XCTAssertEqualObjects(didHideObserver, self.simpleKbManager, @"kbManager must be suscribed to UIKeyboardDidHideNotification");
    XCTAssertEqualObjects(willShowObserver, self.simpleKbManager, @"kbManager must be suscribed to UIKeyboardWillShowNotification");
    XCTAssertEqualObjects(willHideObserver, self.simpleKbManager, @"kbManager must be suscribed to UIKeyboardWillHideNotification");
}

- (void)testDidUnSuscribeToKeyboardNotifications {
    
    DRGFakeNotificationCenter *fakeNC = [[DRGFakeNotificationCenter alloc] init];
    
    [self.simpleKbManager beginObservingKeyboard:(NSNotificationCenter *)fakeNC];
    
    [self.simpleKbManager endObservingKeyboard];

    NSDictionary *obs = [fakeNC observers];
    id didShowObserver = [obs objectForKey:UIKeyboardDidShowNotification];
    id willShowObserver = [obs objectForKey:UIKeyboardWillShowNotification];
    id willHideObserver = [obs objectForKey:UIKeyboardWillHideNotification];
    id didHideObserver = [obs objectForKey:UIKeyboardDidHideNotification];
    
    XCTAssertEqualObjects(didShowObserver, nil, @"kbManager must not be suscribed to UIKeyboardDidShowNotification");
    XCTAssertEqualObjects(didHideObserver, nil, @"kbManager must not be suscribed to UIKeyboardDidHideNotification");
    XCTAssertEqualObjects(willShowObserver, nil, @"kbManager must not be suscribed to UIKeyboardWillShowNotification");
    XCTAssertEqualObjects(willHideObserver, nil, @"kbManager must not be suscribed to UIKeyboardWillHideNotification");
}

#pragma mark - Delegates

- (void)testNotifyKeyboardWasShownToDelegate {
    
    DRGFakeKeyboardManagerDelegate *vcDelegate = [[DRGFakeKeyboardManagerDelegate alloc] init];
    self.simpleKbManager.delegate = vcDelegate;
    
    [self.simpleKbManager.delegate keyboardManagerDidShowKeyboard:self.simpleKbManager];
    
    XCTAssertTrue(vcDelegate.keyboardShown, @"keyboardShown property should be 'YES'");
}

- (void)testNotifyKeyboardWasHiddenToDelegate {
    
    DRGFakeKeyboardManagerDelegate *vcDelegate = [[DRGFakeKeyboardManagerDelegate alloc] init];
    self.simpleKbManager.delegate = vcDelegate;
    
    [self.simpleKbManager.delegate keyboardManagerDidHideKeyboard:self.simpleKbManager];
    
    XCTAssertTrue(vcDelegate.keyboardHidden, @"keyboardHidden property should be 'YES'");
}

- (void)testNotifyKeyboardWillShowToDelegate {
    
    DRGFakeKeyboardManagerDelegate *vcDelegate = [[DRGFakeKeyboardManagerDelegate alloc] init];
    self.simpleKbManager.delegate = vcDelegate;
    
    [self.simpleKbManager.delegate keyboardManagerWillShowKeyboard:self.simpleKbManager];
    
    XCTAssertTrue(vcDelegate.keyboardWillBeShown, @"keyboardWilBeShown property should be 'YES'");
}

- (void)testNotifyKeyboardWillBeHiddenToDelegate {
    
    DRGFakeKeyboardManagerDelegate *vcDelegate = [[DRGFakeKeyboardManagerDelegate alloc] init];
    self.simpleKbManager.delegate = vcDelegate;
    
    [self.simpleKbManager.delegate keyboardManagerWillHideKeyboard:self.simpleKbManager];
    
    XCTAssertTrue(vcDelegate.keyboarWillBeHidden, @"keyboardWillBeHidden property should be 'YES'");
}

#pragma mark - Resize

- (void)testViewHeightIsEqualToScreenHeightMinusKeyboardEndYPositionWhenKeyboardAppears {
    
    UIViewController *vc = [[UIViewController alloc] init];
    DRGKeyboardManager *kbManager = [[DRGKeyboardManager alloc] initForViewController:vc];
    
    CGFloat kbY = 400;
    NSDictionary *info = @{@"UIKeyboardFrameEndUserInfoKey":[NSValue valueWithCGRect:CGRectMake(0, kbY, 0, 0)]};
    NSNotification *notification = [NSNotification notificationWithName:@"fake" object:nil userInfo:info];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    
    [kbManager performSelector:@selector(keyboardWillBeShown:) withObject:notification];
    
#pragma clang diagnostic pop
    
    XCTAssertEqual(kbManager.containerView.frame.size.height, kbY,
                   @"Container view's height should be equal to Keyboard End Y position");
}

- (void)testViewHeightIsEqualToScreenHeightMinusKeyboardEndYPositionWhenKeyboardDisappears {
    
    UIViewController *vc = [[UIViewController alloc] init];
    DRGKeyboardManager *kbManager = [[DRGKeyboardManager alloc] initForViewController:vc];
    
    CGFloat kbY = 650;
    NSDictionary *info = @{@"UIKeyboardFrameEndUserInfoKey":[NSValue valueWithCGRect:CGRectMake(0, kbY, 0, 0)]};
    NSNotification *notification = [NSNotification notificationWithName:@"fake" object:nil userInfo:info];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    
    [kbManager performSelector:@selector(keyboardWillBeHidden:) withObject:notification];
    
#pragma clang diagnostic pop

    XCTAssertEqual(kbManager.containerView.frame.size.height, kbY,
                   @"Container view's height should be equal to Keyboard End Y position");
}

- (void)testViewWidthDoesNotChangeWhenKeyboardAppears {
    
    UIViewController *vc = [[UIViewController alloc] init];
    DRGKeyboardManager *kbManager = [[DRGKeyboardManager alloc] initForViewController:vc];
    
    CGFloat kbY = 400;
    NSDictionary *info = @{@"UIKeyboardFrameEndUserInfoKey":[NSValue valueWithCGRect:CGRectMake(0, kbY, 0, 0)]};
    NSNotification *notification = [NSNotification notificationWithName:@"fake" object:nil userInfo:info];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    
    [kbManager performSelector:@selector(keyboardWillBeShown:) withObject:notification];
    
#pragma clang diagnostic pop
    
    XCTAssertEqual(kbManager.containerView.frame.size.width, vc.view.frame.size.width,
                   @"Container view's width should not change");
}

- (void)testViewWidthDoesNotChangeWhenKeyboardDisappears {
    
    UIViewController *vc = [[UIViewController alloc] init];
    DRGKeyboardManager *kbManager = [[DRGKeyboardManager alloc] initForViewController:vc];
    
    CGFloat kbY = 650;
    NSDictionary *info = @{@"UIKeyboardFrameEndUserInfoKey":[NSValue valueWithCGRect:CGRectMake(0, kbY, 0, 0)]};
    NSNotification *notification = [NSNotification notificationWithName:@"fake" object:nil userInfo:info];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    
    [kbManager performSelector:@selector(keyboardWillBeHidden:) withObject:notification];
    
#pragma clang diagnostic pop
    
    XCTAssertEqual(kbManager.containerView.frame.size.width, vc.view.frame.size.width,
                   @"Container view's width should not change");
}

#pragma mark - Bugs

- (void)testViewFrameChangeIfKeyboardWasResized {
    // handle manual show/hide suggestion bar in the keyboard
    UIViewController *vc = [[UIViewController alloc] init];
    DRGKeyboardManager *kbManager = [[DRGKeyboardManager alloc] initForViewController:vc];
    
    [kbManager beginObservingKeyboard:[NSNotificationCenter defaultCenter]];
    
    CGFloat kbY = 400;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    
    NSDictionary *info1 = @{@"UIKeyboardFrameEndUserInfoKey":[NSValue valueWithCGRect:CGRectMake(0, kbY, 0, 0)]};
    NSNotification *notification1 = [NSNotification notificationWithName:@"fake" object:nil userInfo:info1];
    [kbManager performSelector:@selector(keyboardWillBeShown:) withObject:notification1];
    
    NSDictionary *info2 = @{@"UIKeyboardFrameEndUserInfoKey":[NSValue valueWithCGRect:CGRectMake(0, kbY + 50, 0, 0)]};
    NSNotification *notification2 = [NSNotification notificationWithName:@"fake" object:nil userInfo:info2];
    [kbManager performSelector:@selector(keyboardWillBeShown:) withObject:notification2];

#pragma clang diagnostic pop
    
    XCTAssertEqual(kbManager.containerView.frame.size.height,kbY + 50,
                   @"Container view's height should be reduced 450 points");
}


@end
