//
//  TSGameChargeController.m
//  TTShop
//
//  Created by Steven Li on 11-12-15.
//  Copyright (c) 2011年 TTF Inc. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "TSGameChargeController.h"
#import "TSHistoryPhoneController.h"


@implementation TSGameChargeController

@synthesize tab_ctrl_inner;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"游戏充值";

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section)
    {
        return 2;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (0 == indexPath.section)
    {
        if (0 == indexPath.row)
        {
            if (cell == nil)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = @"268pk充值卡";
            cell.detailTextLabel.text = @"5元卡";
            
            return cell;
        }
        else
        {
            if (cell == nil)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"手机号码：";
            
            UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(88.0f, 12.0f, 188.0f, 26.0f)];
            tf.font = [UIFont systemFontOfSize:14.0f];
            tf.placeholder = @"请输入手机号码";
            tf.keyboardType = UIKeyboardTypeNumberPad;
            [cell addSubview:tf];
            [tf release];
            
            tf_phone_no = tf;
            
            cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
            [btn addTarget:self action:@selector(btnContactClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.accessoryView = btn;
            
            return cell;
        }
    }
    
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (0 == section)
    {
        return nil;
    }
    else if (1 == section)
    {
        return @"历史充值号码";
    }
    
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (0 == section)
    {
        return @"手机号码仅用于接收游戏点卡卡号和卡密";
    }
    
    return nil;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (1 == indexPath.section)
    {
        return 234.0f;
    }
    
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if (1 == indexPath.section)
    {
        cell.clipsToBounds = YES;
        
        for (id sv in cell.subviews)
        {
            if ([@"UITableViewCellContentView" isEqualToString:NSStringFromClass([sv class])])
            {
                UIView *tmp_v = (UIView *)sv;
                tmp_v.clipsToBounds = YES;
                
                TSHistoryPhoneController *ctrl = [[TSHistoryPhoneController alloc] initWithStyle:UITableViewStylePlain];
                ctrl.tableView.frame = tmp_v.frame;
                [cell addSubview:ctrl.tableView];
                ctrl.tableView.layer.borderWidth = 1.0f;
                ctrl.tableView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
                
                CALayer *mask_layer = [CALayer layer];
                [tmp_v.layer addSublayer:mask_layer];
                mask_layer.backgroundColor = [[UIColor yellowColor] CGColor];
                mask_layer.frame = tmp_v.frame;
                mask_layer.cornerRadius = 13.0f;
                cell.layer.mask = mask_layer;
                
                ctrl.delegate = self;
                self.tab_ctrl_inner = ctrl;
                
                break;
            }
        }
    }
}

#pragma mark - select contact from AddressBook

- (void) btnContactClick:(id)sender
{
    ABPeoplePickerNavigationController *ctrl = [[ABPeoplePickerNavigationController alloc] init];
    ctrl.peoplePickerDelegate = self;
    [self presentModalViewController:ctrl animated:YES];
    [ctrl release];
}

#pragma mark ABPeoplePickerNavigationControllerDelegate

- (BOOL) peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    return YES;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    if (kABPersonPhoneProperty == property)
    {
        ABMutableMultiValueRef phones = ABRecordCopyValue(person, property);
        int idx = ABMultiValueGetIndexForIdentifier(phones, identifier);
        NSString *phone = (NSString *)ABMultiValueCopyValueAtIndex(phones, idx);
        tf_phone_no.text = phone;
        [phone release];
    }
    
    [peoplePicker dismissModalViewControllerAnimated:YES];
    
    return NO;
}

- (void) peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [peoplePicker dismissModalViewControllerAnimated:YES];
}

#pragma mark - TSHistoryPhoneDelegate

- (void) tsHistoryPhoneController:(TSHistoryPhoneController *)controller didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell *cell = [controller.tableView cellForRowAtIndexPath:indexPath];
    
    if (tf_phone_no)
    {
        tf_phone_no.text = cell.detailTextLabel.text;
    }
}



@end
