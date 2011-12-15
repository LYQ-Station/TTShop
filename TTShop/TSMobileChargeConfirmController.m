//
//  TSMobileChargeConfirmController.m
//  TTShop
//
//  Created by Steven Li on 11-12-15.
//  Copyright (c) 2011年 TTF Inc. All rights reserved.
//

#import "TSMobileChargeConfirmController.h"
#import "TSViewOrderController.h"


@implementation TSMobileChargeConfirmController

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

    self.title = @"手机充值确认";
    
    UIBarButtonItem *btn_next_step = [[UIBarButtonItem alloc] initWithTitle:@"下一步"
                                                                      style:UIBarButtonItemStyleDone
                                                                     target:self
                                                                     action:@selector(btnNextStepClick:)];
    self.navigationItem.rightBarButtonItem = btn_next_step;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.navigationItem.rightBarButtonItem = nil;
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
        if (0 == indexPath.row)
        {
            
        }
        else
        {
            
        }
    }
}

#pragma mark - btn next step click

- (void) btnNextStepClick:(id)sender
{
    TSViewOrderController *ctrl = [[TSViewOrderController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:ctrl animated:YES];
    [ctrl release];
}

@end
