//
//  TSTradeRecordsController.m
//  TTShop
//
//  Created by Steven Li on 12/9/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "TSTradeRecordsController.h"
#import "TSTradeRemindCell.h"
#import "TSVertifyPhoneController.h"


static UITextView *tmp_text_view = nil;
static NSArray *b_types;
static NSArray *t_types;

@implementation TSTradeRecordsController

@synthesize tb_for_picker;
@synthesize tb_close;
@synthesize tb_submit;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [custom_title_view release];
    
    [sg_switch release];
    
    [tb_close release];
    [tb_submit release];
    [tb_for_picker release];
    [pv_picker release];
    
    [tmp_text_view release];
    tmp_text_view = nil;
    
    [b_types release];
    b_types = nil;
    
    [t_types release];
    b_types = nil;
    
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"交易记录";
    self.navigationItem.prompt = @" ";

    CGRect uv_frm = [UIScreen mainScreen].bounds;
    
    UISegmentedControl *sg_type_switch = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"业务类型", @"交易类型", nil]];
    sg_type_switch.frame = CGRectMake(10.0f, 38.0f, uv_frm.size.width - 20.0f, 30.0f);
    sg_type_switch.segmentedControlStyle = UISegmentedControlStyleBar;
    sg_type_switch.momentary = YES;
    [sg_type_switch addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = sg_type_switch;
    sg_switch = sg_type_switch;
    
//    self.tableView.delegate = nil;
//    self.tableView.dataSource = nil;
    
    UIView *empty_v = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, 0.0f)];
    UIBarButtonItem *empty_back_btn = [[UIBarButtonItem alloc] initWithCustomView:empty_v];
    self.navigationItem.leftBarButtonItem = empty_back_btn;
    [empty_v release];
    [empty_back_btn release];
    
    custom_title_view = [[UILabel alloc] initWithFrame:CGRectMake(119.0f, 5.0f, 82.0f, 27.0f)];
    custom_title_view.text = @"交易记录";
    custom_title_view.textColor = [UIColor whiteColor];
    custom_title_view.textAlignment = UITextAlignmentCenter;
    custom_title_view.backgroundColor = [UIColor clearColor];
    custom_title_view.font = [UIFont boldSystemFontOfSize:20.0f];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [custom_title_view release];
    custom_title_view = nil;
    
    self.navigationItem.titleView = nil;
    self.tb_close = nil;
    self.tb_submit = nil;
    self.tb_for_picker = nil;
    self.pv_picker = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar addSubview:custom_title_view];
    
    if (animated)
    {
        CABasicAnimation *anni = [CABasicAnimation animationWithKeyPath:@"position"];
        anni.duration = 0.31f;
        anni.fromValue = [NSValue valueWithCGPoint:CGPointMake(320.0f, 18.5f)];
        [custom_title_view.layer addAnimation:anni forKey:@"position"];
        
        CABasicAnimation *anni2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
        anni2.fromValue = [NSNumber numberWithFloat:0.0f];
        anni2.toValue = [NSNumber numberWithFloat:1.0f];
        [custom_title_view.layer addAnimation:anni2 forKey:@"opacity"];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
//    [sg_switch removeFromSuperview];
    [custom_title_view removeFromSuperview];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    TSTradeRemindCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[TSTradeRemindCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setContent:nil];
    
    return cell;
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

#pragma mark -

- (IBAction) segmentClick:(id)sender
{
    UISegmentedControl *sg = (UISegmentedControl *)sender;
    
    pv_picker.delegate = self;
    pv_picker.dataSource = self;
    pv_picker.tag = sg.selectedSegmentIndex;
    
    if (!tmp_text_view)
    {
        tmp_text_view = [[UITextView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, 0.0f)];
        [self.view.window addSubview:tmp_text_view];
        tmp_text_view.inputView = pv_picker;
        tmp_text_view.inputAccessoryView = tb_for_picker;
    }
    
    [tmp_text_view becomeFirstResponder];
}

- (IBAction) btnCloseKeyBoardClick:(id)sender
{
    [tmp_text_view resignFirstResponder];
    
    tmp_text_view.inputView = nil;
    tmp_text_view.inputAccessoryView = nil;
    [tmp_text_view removeFromSuperview];
    tmp_text_view = nil;
}

- (IBAction) btnSubmitClick:(id)sender
{
    int idx = [pv_picker selectedRowInComponent:0];
    
    if (0 == pv_picker.tag)
    {
        [sg_switch setTitle:[b_types objectAtIndex:idx] forSegmentAtIndex:0];
    }
    else
    {
        [sg_switch setTitle:[t_types objectAtIndex:idx] forSegmentAtIndex:1];
    }
    
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
        if (!b_types)
        {
            b_types = [[NSArray alloc] initWithObjects:@"游戏充值", @"手机充值", @"银行转账", nil];
        }
        
        return [b_types objectAtIndex:row];
    }
    
    if (!t_types)
    {
        t_types = [[NSArray alloc] initWithObjects:@"交易中", @"交易成功", nil];
    }
    
    return [t_types objectAtIndex:row];
}

@end
