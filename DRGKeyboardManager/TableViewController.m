//
//  TableViewController.m
//  DRGKeyboardManager
//
//  Created by David Regatos on 16/06/15.
//  Copyright (c) 2015 DRG. All rights reserved.
//

#import "TableViewController.h"
#import "DRGKeyboardManager.h"
#import "CustomCell.h"

@interface TableViewController () <UITextFieldDelegate, DRGKeyboardManagerDelegate>

@property (nonatomic, strong) DRGKeyboardManager *kbManager;
@property (nonatomic, strong) CustomCell *activeCell;

@end

@implementation TableViewController

#pragma mark - View events

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.kbManager = [[DRGKeyboardManager alloc] initForViewController:self];
    self.kbManager.delegate = self;
    
    [self customAppearance];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.kbManager beginObservingKeyboard:[NSNotificationCenter defaultCenter]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.kbManager endObservingKeyboard];
}

# pragma mark - TableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Custom Cell
    static NSString *CellIdentifier = @"Cell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[CustomCell alloc] init];
    }
    
    // Configure the cell...
    cell.textField.tag = indexPath.row;
    cell.label.text = [NSString stringWithFormat:@"Cell %li", (long)indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Hide keyboard when a cell was selected
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSIndexPath *index = [NSIndexPath indexPathForRow:textField.tag inSection:0];
    self.activeCell = (CustomCell *)[self.tableView cellForRowAtIndexPath:index];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.activeCell = nil;
}

#pragma mark - DRGKeyboardManagerDelegate

- (void)keyboardManagerDidShowKeyboard:(DRGKeyboardManager *)kbManager {
    // handle tableview scroll here
    [self.tableView scrollRectToVisible:self.activeCell.frame animated:YES];
}

- (void)keyboardManagerDidHideKeyboard:(DRGKeyboardManager *)kbManager {
    // do something after view did hide
}

#pragma mark - Helpers

- (void)customAppearance {
    
    self.view.backgroundColor = [UIColor colorWithHue:0/359.0 saturation:0/100.0 brightness:95/100.0 alpha:1.];

    CGRect footerRect = CGRectMake(0, 0, self.view.bounds.size.width, self.tabBarController.tabBar.bounds.size.height);
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:footerRect];
    self.tableView.tableFooterView.backgroundColor = [UIColor clearColor];
}


@end
