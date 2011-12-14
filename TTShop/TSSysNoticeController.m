//
//  TSSysNoticeController.m
//  TTShop
//
//  Created by Steven Li on 12/3/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import "TSSysNoticeController.h"


@implementation TSSysNoticeController

@synthesize sg_switch;

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
    self.sg_switch = nil;
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
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    UIBarButtonItem *btn_back = [[UIBarButtonItem alloc] initWithCustomView:v];
    self.navigationItem.leftBarButtonItem = btn_back;
    [v release];
    [btn_back release];
 
    UISegmentedControl *sg_ctrl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"交易提醒", @"系统公告", nil]];
	sg_ctrl.segmentedControlStyle = UISegmentedControlStyleBar;
	[sg_ctrl addTarget:self action:@selector(segmentedControlChange:) forControlEvents:UIControlEventValueChanged];
	sg_ctrl.frame = CGRectMake(0, 0, 207, 30);
	sg_ctrl.selectedSegmentIndex = 1;
	self.navigationItem.titleView = sg_ctrl;
    [sg_ctrl release];
    self.sg_switch = sg_ctrl;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = @"神州行充值卡";
    cell.detailTextLabel.text = @"2011-12-07 18:11:22";
    
    
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

- (IBAction) segmentedControlChange:(id)sender
{
    UISegmentedControl *sg_ctrl = (UISegmentedControl *)sender;
    
    if (1 == sg_ctrl.selectedSegmentIndex)
    {
        return;
    }
    
    [self.navigationController popViewControllerAnimated:NO];
}

@end
