//
//  TSFeedbackController.m
//  TTShop
//
//  Created by Steven Li on 12/3/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import "TSFeedbackController.h"
#import "TSConfigs.h"
#import "STURLLoader.h"
#import "STAlertView.h"

@implementation TSFeedbackController

@synthesize txt_feedback;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    [STURLLoader releaseBindedLoaderForDelegate:self];
    
    [txt_feedback release];
    
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

    UIBarButtonItem *btn_send = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(btnSendClick:)];
    self.navigationItem.rightBarButtonItem = btn_send;
    [btn_send release];
    
    UITextView *tmp_txt_feedback = [[UITextView alloc] init];
    self.txt_feedback = tmp_txt_feedback;
    [tmp_txt_feedback release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.navigationItem.rightBarButtonItem = nil;
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
        tf.delegate = self;
        [cell addSubview:tf];
        [tf release];
        
        [tf becomeFirstResponder];
    }
    else if (1 == indexPath.row)
    {
        UITextView *tv = [[UITextView alloc] initWithFrame:CGRectMake(17.0f, 5.0f, 285.0f, 90.0f)];
        tv.font = [UIFont systemFontOfSize:14.0f];
        tv.backgroundColor = [UIColor clearColor];
        tv.delegate = self;
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
        return @"感谢您的支持，您的意见是我们前进的动力";
    }
    
    return nil;
}


#pragma mark - Table view delegate

- (CGFloat)tableView: (UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (1 == indexPath.row)
    {
        return 100.0f;
    }
    
    return 44.0f;
}

#pragma mark - input field delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    curr_input_field = textField;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    curr_input_field = textView;
}

#pragma mark - events

- (void) btnSendClick:(id)sender
{
    [curr_input_field resignFirstResponder];
    [self send];
}

#pragma mark - send contents

- (void) send
{
    if (is_loading)
    {
        return;
    }
    
    is_loading = YES;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [STAlertView showModalWithLoadingInView:self.view text:@"正在提交反馈..."];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    NSString *full_url = [NSString stringWithFormat:@"http://www.baidu.com", BASE_URL, nil];
    
    STURLRequest *req = [[STURLRequest alloc] initWithURLString:full_url];
    STURLLoader *loader = [[STURLLoader alloc] initWithURLRequest:req];
    [loader addEventListener:STLOADER_COMPLETE target:self action:@selector(onSended:)];
    
    [req release];
    [STURLLoader bindLoader:loader withDelegate:self];
    
    [loader load];
}

- (void) onSended:(NSNotification *)notify
{
    is_loading = NO;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [STAlertView close];
    
    STURLLoader *loader = (STURLLoader *)notify.object;
    
    [loader removeEventListener:STLOADER_COMPLETE target:self];
	[loader release];
    
    [STURLLoader releaseBindedLoaderForDelegate:self];
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:nil
                                                 message:@"谢谢您的回馈意见！"
                                                delegate:self
                                       cancelButtonTitle:@"关闭"
                                       otherButtonTitles:nil, nil];
    [av show];
    [av release];
}

#pragma mark - UIAlertViewDelegate

- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
