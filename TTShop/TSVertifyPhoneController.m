//
//  TSVertifyPhoneController.m
//  TTShop
//
//  Created by Steven Li on 12/11/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import "TSVertifyPhoneController.h"


@implementation TSVertifyPhoneController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)bundleName
{
    self = [super initWithNibName:nibNameOrNil bundle:bundleName];
    
    if (self)
    {
        UITableViewController *table_ctrl = [[UITableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        table_ctrl.title = @"验证手机号码";
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (0 == indexPath.row)
    {
        cell.textLabel.text = @"手机号码：";
        
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(90.0f, 12.0f, 198.0f, 26.0f)];
        tf.font = [UIFont systemFontOfSize:14.0f];
        tf.placeholder = @"请输入手机号码";
        tf.keyboardType = UIKeyboardTypeNumberPad;
        [cell addSubview:tf];
        [tf release];
        
        [tf becomeFirstResponder];
    }
    else if (1 == indexPath.row)
    {
        cell.textLabel.text = @"验证码：";
        
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(90.0f, 12.0f, 198.0f, 26.0f)];
        tf.font = [UIFont systemFontOfSize:14.0f];
        tf.placeholder = @"请输入验证码";
        tf.keyboardType = UIKeyboardTypeNumberPad;
        [cell addSubview:tf];
        [tf release];
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @"为了保证您的资料隐私，我们需要对您的手机进行验证！";
}

#pragma mark -

- (void) btnCloseClick:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
