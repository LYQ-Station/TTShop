//
//  TSMobileChargeConfirmController.m
//  TTShop
//
//  Created by Steven Li on 11-12-15.
//  Copyright (c) 2011年 TTF Inc. All rights reserved.
//

#import "TSMobileChargeConfirmController.h"
#import "TSViewOrderController.h"


static UITextView *tmp_text_view = nil;
static NSArray *values = nil;
static NSArray *types = nil;

@implementation TSMobileChargeConfirmController

@synthesize tb_for_picker;
@synthesize pv_picker;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [tb_for_picker release];
    [pv_picker release];
    
    [tmp_text_view release];
    [values release];
    [types release];
    
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

    self.title = @"手机充值确认";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    
    UIBarButtonItem *btn_next_step = [[UIBarButtonItem alloc] initWithTitle:@"下一步"
                                                                      style:UIBarButtonItemStyleDone
                                                                     target:self
                                                                     action:@selector(btnNextStepClick:)];
    self.navigationItem.rightBarButtonItem = btn_next_step;
    [btn_next_step release];
    
        //create data picker
    CGRect tmp_frm = [UIScreen mainScreen].bounds;
    tmp_frm.size.height = 216.0f;
    pv_picker = [[UIPickerView alloc] initWithFrame:tmp_frm];
    pv_picker.showsSelectionIndicator = YES;
    
    tmp_frm.size.height = 44.0f;
    tb_for_picker = [[UIToolbar alloc] initWithFrame:tmp_frm];
    tb_for_picker.barStyle = UIBarStyleBlackTranslucent;
    
        //create tool bar for data picker
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
    
    self.navigationItem.rightBarButtonItem = nil;
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (0 == indexPath.section)
    {
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        }
        
        if (0 == indexPath.row)
        {
            cell.textLabel.text = @"手机号码";
            cell.detailTextLabel.text = @"13410260771";
        }
        else
        {
            cell.textLabel.text = @"广东";
            cell.detailTextLabel.text = @"中国移动";
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else
    {
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        
        if (0 == indexPath.row)
        {
            cell.textLabel.text = @"30元";;
        }
        else
        {
            cell.textLabel.text = @"快速充值";
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
        return @"请选择充值面额和时间";
    }
    
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return nil;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (1 == indexPath.section)
    {
        pv_picker.tag = indexPath.row;
        pv_picker.delegate = self;
        pv_picker.dataSource = self;
        
        if (!tmp_text_view)
        {
            tmp_text_view = [[UITextView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, 0.0f)];
            [self.tableView addSubview:tmp_text_view];
            tmp_text_view.inputView = pv_picker;
            tmp_text_view.inputAccessoryView = tb_for_picker;
        }
        
        [tmp_text_view becomeFirstResponder];
    }
}

#pragma mark - btn next step click

- (void) btnNextStepClick:(id)sender
{
    TSViewOrderController *ctrl = [[TSViewOrderController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:ctrl animated:YES];
    [ctrl release];
}

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
    [self btnCloseKeyBoardClick:nil];
}

#pragma mark - picker view dataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (0 == pickerView.tag)
    {
        return 3;
    }
    
    return 2;
}


#pragma mark - picker view delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (0 == pickerView.tag)
    {
        if (!values)
        {
            values = [[NSArray alloc] initWithObjects:@"30元(售价29.7元)", @"50元(售价49.5元)", @"100元(售价99.0元)", nil];
        }
        
        return [values objectAtIndex:row];
    }
    
    if (!types)
    {
        types = [[NSArray alloc] initWithObjects:@"快速充值", @"普通充值", nil];
    }
    
    return [types objectAtIndex:row];
}

@end
