//
//  TSMoreController.m
//  TTShop
//
//  Created by Steven Li on 12/2/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import "TSMoreController.h"
#import "TSSettingController.h"
#import "TSFeedbackController.h"
#import "TSHelpController.h"
#import "TSAboutController.h"


@implementation TSMoreController

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

    self.clearsSelectionOnViewWillAppear = YES;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section)
    {
        return 3;
    }
    else if (1 == section)
    {
        return 2;
    }
    else if (2 == section)
    {
        return 1;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.imageView.image = [UIImage imageNamed:@"second"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (0 == indexPath.section)
    {
        switch (indexPath.row)
        {
            case 0:
                cell.textLabel.text = @"设置";
                break;
                
            case 1:
                cell.textLabel.text = @"分享";
                break;
                
            case 2:
                cell.textLabel.text = @"反馈";
                break;
        }
    }
    else if (1 == indexPath.section)
    {
        switch (indexPath.row)
        {
            case 0:
                cell.textLabel.text = @"帮助";
                break;
                
            case 1:
                cell.textLabel.text = @"关于";
                break;
        }
    }
    else if (2 == indexPath.section)
    {
        cell.textLabel.text = @"检测更新";
        cell.imageView.image = [UIImage imageNamed:@"more_cell_update"];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section)
    {
        if (0 == indexPath.row)
        {
            TSSettingController *ctrl = [[TSSettingController alloc] initWithStyle:UITableViewStyleGrouped];
            ctrl.hidesBottomBarWhenPushed = YES;
            ctrl.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [self.navigationController pushViewController:ctrl animated:YES];
            [ctrl release];
            
            return;
        }
        
        if (2 == indexPath.row)
        {
            TSFeedbackController *ctrl = [[TSFeedbackController alloc] initWithStyle:UITableViewStyleGrouped];
            ctrl.hidesBottomBarWhenPushed = YES;
            ctrl.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [self.navigationController pushViewController:ctrl animated:YES];
            [ctrl release];
            
            return;
        }
    }
    
    if (1 == indexPath.section)
    {
        if (0 == indexPath.row)
        {
            TSHelpController *ctrl = [[TSHelpController alloc] initWithNibName:nil bundle:nil];
            ctrl.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ctrl animated:YES];
            [ctrl release];
            
            return;
        }
        
        if (1 == indexPath.row)
        {
            TSAboutController *ctrl = [[TSAboutController alloc] initWithNibName:@"TSAbout" bundle:nil];
            ctrl.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ctrl animated:YES];
            [ctrl release];
            
            return;
        }
    }
}

@end
