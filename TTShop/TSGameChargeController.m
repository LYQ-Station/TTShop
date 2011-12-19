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
#import "TSViewOrderController.h"
#import "STAlertView.h"


static UITextView *tmp_text_view = nil;
static NSString *contact_name = nil;

@implementation TSGameChargeController

@synthesize tab_ctrl_inner;
@synthesize tb_for_picker;
@synthesize pv_picker;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) dealloc
{
    [tab_ctrl_inner release];
    [tb_for_picker release];
    [pv_picker release];
    
    [tmp_text_view release];
    
    [model release];
    
    [super dealloc];
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
    
    UIBarButtonItem *btn_next_step = [[UIBarButtonItem alloc] initWithTitle:@"下一步"
                                                                      style:UIBarButtonItemStyleDone
                                                                     target:self
                                                                     action:@selector(btnNextStepClick:)];
    self.navigationItem.rightBarButtonItem = btn_next_step;
    [btn_next_step release];
    
    CGRect tmp_frm = [UIScreen mainScreen].bounds;
    tmp_frm.size.height = 216.0f;
    pv_picker = [[UIPickerView alloc] initWithFrame:tmp_frm];
    pv_picker.showsSelectionIndicator = YES;
    
    tmp_frm.size.height = 44.0f;
    tb_for_picker = [[UIToolbar alloc] initWithFrame:tmp_frm];
    tb_for_picker.barStyle = UIBarStyleBlackTranslucent;
    
    UIBarButtonItem *btn_close = [[UIBarButtonItem alloc] initWithTitle:@"关闭键盘"
                                                                  style:UIBarButtonItemStyleBordered
                                                                 target:self
                                                                 action:@selector(btnCloseKeyBoardClick:)];
    
    UIBarButtonItem *btn_submit = [[UIBarButtonItem alloc] initWithTitle:@"选择"
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(btnSubmitClick:)];
    
    UIBarButtonItem *split = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    NSArray *items = [NSArray arrayWithObjects:btn_close, split, btn_submit, nil];
    
    [btn_close release];
    [btn_submit release];
    [split release];
    
    tb_for_picker.items = items;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.navigationItem.rightBarButtonItem  = nil;
    self.tb_for_picker = nil;
    self.pv_picker = nil;
    
    [tmp_text_view release];
    tmp_text_view = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self loadData];
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
            
            UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(88.0f, 10.0f, 183.0f, 26.0f)];
            tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            tf.font = [UIFont systemFontOfSize:14.0f];
            tf.placeholder = @"请输入手机号码";
            tf.keyboardType = UIKeyboardTypeNumberPad;
            [cell addSubview:tf];
            [tf release];
            
            tf_phone_no = tf;
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, 0, 54, 54);
            [btn setImage:[UIImage imageNamed:@"btn_conp"] forState:UIControlStateNormal];
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
        return @"手机号仅用于接收游戏点卡卡号和卡密";
    }
    
    return nil;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section)
    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
//        pv_picker.delegate = self;
//        pv_picker.dataSource = self;
        
        if (!pv_picker.delegate && !pv_picker.dataSource)
        {
            return;
        }
        
        if (!tmp_text_view)
        {
            tmp_text_view = [[UITextView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, 0.0f)];
            [cell addSubview:tmp_text_view];
            tmp_text_view.inputView = pv_picker;
            tmp_text_view.inputAccessoryView = tb_for_picker;
        }
        
        [tmp_text_view becomeFirstResponder];
    }
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
                
                CGRect mask_frm = tmp_v.frame;
                mask_frm.origin.x += 1;
                mask_frm.origin.y += 1;
                mask_frm.size.width -= 1;
                mask_frm.size.height -= 1;
                
                TSHistoryPhoneController *ctrl = [[TSHistoryPhoneController alloc] initWithStyle:UITableViewStylePlain];
                ctrl.tableView.frame = tmp_v.frame;
                ctrl.tableView.layer.cornerRadius = 14.0f;
                ctrl.tableView.layer.masksToBounds = YES;
                [cell addSubview:ctrl.tableView];
                
                ctrl.delegate = self;
                self.tab_ctrl_inner = ctrl;
                [ctrl release];
                
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
        
        if (contact_name)
        {
            [contact_name release];
            contact_name = nil;
        }
        
        contact_name = (NSString *)ABRecordCopyCompositeName(person);
        [contact_name retain];
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

#pragma mark - picker view dataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (0 == component)
    {
        return [model.buffer_games count];
//        return 30;
    }
    
    NSArray *arr = [model.buffer_values objectAtIndex:[pickerView selectedRowInComponent:0]];
    return [arr count];
//    return [model.buffer_values count];
//    return 5;
}


#pragma mark - picker view delegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    CGFloat w = ([UIScreen mainScreen].bounds.size.width - 20) / 3;
    
    if (0 == component)
    {
        return w * 2;
    }
    
    return w;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (0 == component)
    {
        return [model.buffer_games objectAtIndex:row];
//        return @"联众游戏";
    }
    else
    {
        NSArray *arr = [model.buffer_values objectAtIndex:[pickerView selectedRowInComponent:0]];
        
        return [arr objectAtIndex:row];
//        return @"100元卡";
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (0 == component)
    {
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
}

#pragma mark -

- (void) btnNextStepClick:(id)sender
{
    if (0 == tf_phone_no.text.length)
    {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:nil
                                                     message:@"请填写用于接收游戏点卡卡号和卡密手机号码"
                                                    delegate:nil
                                           cancelButtonTitle:@"取消"
                                           otherButtonTitles:nil, nil];
        [av show];
        [av release];
        
        return;
    }
    
    if (nil == contact_name)
    {
       [tab_ctrl_inner addAPhoneNO:tf_phone_no.text contact:@"未知"];
    }
    else
    {
        [tab_ctrl_inner addAPhoneNO:tf_phone_no.text contact:contact_name];
    }
    
    TSViewOrderController *ctrl = [[TSViewOrderController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:ctrl animated:YES];
    [ctrl release];
}

#pragma mark - event for toolbar buttons

- (void) btnCloseKeyBoardClick:(id)sender
{
    [tmp_text_view resignFirstResponder];
    
    tmp_text_view.inputView = nil;
    tmp_text_view.inputAccessoryView = nil;
    [tmp_text_view removeFromSuperview];
    tmp_text_view = nil;
    
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
}

- (void) btnSubmitClick:(id)sender
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.textLabel.text = [model.buffer_games objectAtIndex:[pv_picker selectedRowInComponent:0]];
    
    NSArray *arr = [model.buffer_values objectAtIndex:[pv_picker selectedRowInComponent:0]];
    cell.detailTextLabel.text = [arr objectAtIndex:[pv_picker selectedRowInComponent:1]];
    
    [self btnCloseKeyBoardClick:nil];
}

#pragma mark - data opearte

- (void) loadData
{
    if (!model)
    {
        model = [[TSGameChargeModel alloc] initWithDelegate:self];
    }
    
    [STAlertView showModalWithLoadingInView:self.view text:@"数据载入中⋯⋯"];
//    [STAlertView showModalInView:self.view text:@"数据载入完毕"];
    
    [model loadData];
}

#pragma mark -

- (void ) onModelLoaded:(TSGameChargeModel *)aModel
{
    [STAlertView close];
    
    pv_picker.dataSource = self;
    pv_picker.delegate = self;
}


@end
