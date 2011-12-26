//
//  TSVertifyPhoneController.m
//  TTShop
//
//  Created by Steven Li on 12/11/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "TSVertifyPhoneController.h"
#import "TSConfigs.h"
#import "STURLLoader.h"
#import "STAlertView.h"

@implementation TSVertifyPhoneController

@synthesize show_close_btn;
@synthesize tf_curr_inputbox;
@synthesize delegate;

- (id) initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self)
    {
        self.title = @"验证手机号码";
    }
    
    return self;
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    [STURLLoader releaseBindedLoaderForDelegate:self];
    
    [mask_btn release];
    
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
    
    if (show_close_btn)
    {
        UIBarButtonItem *btn_close = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleBordered target:self action:@selector(btnCloseClick:)];
        self.navigationItem.leftBarButtonItem = btn_close;
        [btn_close release];
    }
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
    
    [tf_curr_inputbox becomeFirstResponder];
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
    if (0 == section)
    {
        return 2;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = nil;
    
    if (0 == indexPath.section)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (0 == indexPath.row)
        {
            cell.textLabel.text = @"手机号码：";
            
            UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(90.0f, 12.0f, 150.0f, 26.0f)];
            tf.font = [UIFont systemFontOfSize:14.0f];
            tf.placeholder = @"请输入手机号码";
            tf.keyboardType = UIKeyboardTypeNumberPad;
            tf.delegate = self;
            [cell addSubview:tf];
            [tf release];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn.titleLabel.textColor = [UIColor darkTextColor];
            btn.titleLabel.font = [UIFont systemFontOfSize:11.0f];
            btn.frame = CGRectMake(0, 0, 60, 30);
            [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(getCode:) forControlEvents:UIControlEventTouchUpInside];
            cell.accessoryView = btn;
            
            tf_curr_inputbox = tf;
        }
        else if (1 == indexPath.row)
        {
            cell.textLabel.text = @"验证码：";
            
            UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(90.0f, 12.0f, 198.0f, 26.0f)];
            tf.font = [UIFont systemFontOfSize:14.0f];
            tf.placeholder = @"请输入验证码";
            tf.keyboardType = UIKeyboardTypeNumberPad;
            tf.delegate = self;
            [cell addSubview:tf];
            [tf release];
        }
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        
//        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.text = @"开始验证";
        cell.textLabel.textAlignment = UITextAlignmentCenter;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (1 == section)
    {
        return @"为了保证您的资料隐私，我们需要对您的手机进行验证！";
    }
    
    return nil;
}

#pragma mark - uitableview deleagate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (1 == indexPath.section)
    {
        if (is_loading)
        {
            return;
        }
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        [self doVerify];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (!mask_btn)
    {
        mask_btn = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
        mask_btn.backgroundColor = [UIColor whiteColor];
        mask_btn.alpha = 0.1f;
        [mask_btn addTarget:self action:@selector(btnCloseKeyboardClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.tableView addSubview:mask_btn];
    
    tf_curr_inputbox = textField;
    
    return YES;
}

#pragma mark close keyboard

- (void) btnCloseKeyboardClick:(id)sender
{
    [tf_curr_inputbox resignFirstResponder];
    [mask_btn removeFromSuperview];
}

#pragma mark -

- (void) btnCloseClick:(id)sender
{
    [self btnCloseKeyboardClick:nil];
    
    if (delegate && [delegate respondsToSelector:@selector(tsVertifyPhoneControllerDidCancel:)])
    {
        [delegate performSelector:@selector(tsVertifyPhoneControllerDidCancel:) withObject:self];
    }
}

#pragma mark - model

- (void) getCode:(id)sender
{
    if (is_loading)
    {
        return;
    }
    
    is_loading = YES;
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [STAlertView showModalWithLoadingInView:self.view text:@"正在发送验证码..."];
    
    NSString *full_url = [NSString stringWithFormat:@"http://www.baidu.com", BASE_URL, nil];
    
    STURLRequest *req = [[STURLRequest alloc] initWithURLString:full_url];
    STURLLoader *loader = [[STURLLoader alloc] initWithURLRequest:req];
    [loader addEventListener:STLOADER_COMPLETE target:self action:@selector(onGetCode:)];
    
    [req release];
    
    [loader load];
    
    UIButton *btn = (UIButton *)sender;
    btn.enabled = NO;
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f
                                     target:self
                                   selector:@selector(onCodeTimer:)
                                   userInfo:sender
                                    repeats:YES];
}

- (void) onCodeTimer:(NSTimer*)theTimer
{
    static char counter = 5;
    
    UIButton *btn = (UIButton *)theTimer.userInfo;
    
    if (0 > counter)
    {
        [theTimer invalidate];
        counter = 0;
        
        btn.enabled = YES;
        
        return;
    }
    
    [btn setTitle:[NSString stringWithFormat:@"(%d)", counter] forState:UIControlStateDisabled];
    
    counter--;
}

- (void) onGetCode:(NSNotification *)notify
{
    is_loading = NO;
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    STURLLoader *loader = (STURLLoader *)notify.object;
    [loader removeEventListener:STLOADER_COMPLETE target:self];
	[loader release];
    
    [STAlertView close];
}

- (void) doVerify
{
    if (is_loading)
    {
        return;
    }
    
    is_loading = YES;
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    UITableViewCell *btn_cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    btn_cell.textLabel.text = @"正在验证...";
    
    UIActivityIndicatorView *av = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [av startAnimating];
    btn_cell.accessoryView = av;
    [av release];
    
    NSString *full_url = [NSString stringWithFormat:@"http://www.baidu.com", BASE_URL, nil];
    
    STURLRequest *req = [[STURLRequest alloc] initWithURLString:full_url];
    STURLLoader *loader = [[STURLLoader alloc] initWithURLRequest:req];
    [loader addEventListener:STLOADER_COMPLETE target:self action:@selector(onVerfiy:)];
    
    [req release];
    [STURLLoader bindLoader:loader withDelegate:self];
    
    [loader load];
}

- (void) onVerfiy:(NSNotification *)notify
{
    is_loading = NO;
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    UITableViewCell *btn_cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    btn_cell.textLabel.text = @"开始验证";
    btn_cell.accessoryView = nil;
    
    STURLLoader *loader = (STURLLoader *)notify.object;
    [loader removeEventListener:STLOADER_COMPLETE target:self];
	[loader release];
    
    if (delegate && [delegate respondsToSelector:@selector(tsVertifyPhoneControllerCheckedOK:)])
    {
        [delegate performSelector:@selector(tsVertifyPhoneControllerCheckedOK:) withObject:self];
    }
}

@end
