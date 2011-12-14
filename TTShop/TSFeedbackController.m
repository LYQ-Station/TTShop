//
//  TSFeedbackController.m
//  TTShop
//
//  Created by Steven Li on 12/3/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import "TSFeedbackController.h"


@implementation TSFeedbackController

@synthesize txt_feedback;

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
    self.txt_feedback = nil;
    
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

    UIBarButtonItem *btn_send = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(btnSendClick:)];
    self.navigationItem.rightBarButtonItem = btn_send;
    [btn_send release];
    
    UITextView *tmp_txt_feedback = [[UITextView alloc] init];
    self.txt_feedback = tmp_txt_feedback;
    [tmp_txt_feedback release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.txt_feedback = nil;
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
        UITextView *tv = [[UITextView alloc] initWithFrame:CGRectMake(17.0f, 5.0f, 285.0f, 90.0f)];
        tv.font = [UIFont systemFontOfSize:14.0f];
        [cell addSubview:tv];
        [tv release];
    }
    
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (0 == section)
//    {
//        return @"感谢您的支持，您的意见是我们前进的动力。";
//    }
//    
//    return nil;
//}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (0 == section)
    {
        return @"感谢您的支持，您的意见是我们前进的动力。";
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

- (CGFloat)tableView: (UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (1 == indexPath.row)
    {
        return 100.0f;
    }
    
    return 44.0f;
}

#pragma mark - events

- (void) btnSendClick:(id)sender
{
    
}

@end
