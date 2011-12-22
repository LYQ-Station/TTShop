//
//  TSVertifyPhoneController.m
//  TTShop
//
//  Created by Steven Li on 12/11/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import "TSVertifyPhoneController.h"

@implementation TSVertifyPhoneController

@synthesize is_show_close_btn;
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
    [mask_btn release];
    mask_btn = nil;
    
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
    
    if (is_show_close_btn)
    {
        UIBarButtonItem *btn_close = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleBordered target:self action:@selector(btnCloseClick:)];
        self.navigationItem.leftBarButtonItem = btn_close;
        [btn_close release];
    }
    
    UIBarButtonItem *btn_submit = [[UIBarButtonItem alloc] initWithTitle:@"开始验证" style:UIBarButtonItemStyleDone target:self action:@selector(btnSubmitClick:)];
    self.navigationItem.rightBarButtonItem = btn_submit;
    [btn_submit release];
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
            
            UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(90.0f, 12.0f, 198.0f, 26.0f)];
            tf.font = [UIFont systemFontOfSize:14.0f];
            tf.placeholder = @"请输入手机号码";
            tf.keyboardType = UIKeyboardTypeNumberPad;
            tf.delegate = self;
            [cell addSubview:tf];
            [tf release];
            
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
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @"为了保证您的资料隐私，我们需要对您的手机进行验证！";
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

- (void) btnSubmitClick:(id)sender
{
    [self btnCloseKeyboardClick:nil];
    
    if (delegate && [delegate respondsToSelector:@selector(tsVertifyPhoneControllerCheckedOK:)])
    {
        [delegate performSelector:@selector(tsVertifyPhoneControllerCheckedOK:) withObject:self];
    }
}

@end
