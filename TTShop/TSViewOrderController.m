//
//  TSViewOrderController.m
//  TTShop
//
//  Created by Steven Li on 11-12-15.
//  Copyright (c) 2011年 TTF Inc. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "TSViewOrderController.h"
#import "TSOrderPropertyController.h"


@implementation TSViewOrderController

@synthesize tab_ctrl_inner;

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

    self.title = @"确认支付";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.tab_ctrl_inner = nil;
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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (1 == indexPath.section)
    {
        cell.textLabel.text = @"立即充值";
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (0 == section)
    {
        return @"确认订单明细";
    }
    
    return nil;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (1 == indexPath.section)
    {
        NSLog(@"ffff");
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section)
    {
        return 278.0f;
    }
    
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if (0 == indexPath.section)
    {
        cell.clipsToBounds = YES;
        
        for (id sv in cell.subviews)
        {
            if ([@"UITableViewCellContentView" isEqualToString:NSStringFromClass([sv class])])
            {
                UIView *tmp_v = (UIView *)sv;
                tmp_v.clipsToBounds = YES;
                
                TSOrderPropertyController *ctrl = [[TSOrderPropertyController alloc] initWithStyle:UITableViewStylePlain];
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
                
                self.tab_ctrl_inner = ctrl;
                
                break;
            }
        }
    }
    else
    {
        if (1 == indexPath.section)
        {
            cell.textLabel.frame = cell.frame;
            cell.textLabel.textAlignment = UITextAlignmentCenter;
        }
    }
}

@end
