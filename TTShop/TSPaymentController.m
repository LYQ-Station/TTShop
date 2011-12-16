//
//  TSPaymentController.m
//  TTShop
//
//  Created by Steven Li on 11-12-16.
//  Copyright (c) 2011年 TTF Inc. All rights reserved.
//

#import "TSPaymentController.h"


@implementation TSPaymentController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        UITableViewController *table_ctrl = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
        table_ctrl.title = @"选择付款方式";
        table_ctrl.tableView.delegate = self;
        table_ctrl.tableView.dataSource = self;
        [self pushViewController:table_ctrl animated:NO];
        [table_ctrl release];
        
        UIBarButtonItem *btn_close = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleBordered target:self action:@selector(btnCloseClick:)];
        table_ctrl.navigationItem.leftBarButtonItem = btn_close;
        [btn_close release];
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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger num = 0;
    
    switch (section)
    {
        case 0:
        case 1:
            num = 1;
            break;
            
        case 2:
            num = 2;
            break;
    }
    
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (0 == indexPath.section && 0 == indexPath.row)
    {
        cell.textLabel.text = @"快捷支付";
    }
    else if (1 == indexPath.section)
    {
        cell.textLabel.text = @"语音支付";
    }
    else if (2 == indexPath.section)
    {
        switch (indexPath.row)
        {
            case 0:
                cell.textLabel.text = @"招商银行";
                break;
                
            case 1:
                cell.textLabel.text = @"建设银行";
                break;
        }
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *label = nil;
    
    switch (section)
    {
        case 0:
            label = @"快捷支付";
            break;
            
        case 1:
            label = @"语音支付";
            break;
            
        case 2:
            label = @"网银支付";
            break;
    }
    
    return label;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark -

- (void) btnCloseClick:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
