//
//  TSAboutController.m
//  TTShop
//
//  Created by Steven Li on 12/4/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import "TSAboutController.h"

@implementation TSAboutController

@synthesize btn_email;
@synthesize btn_phone;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) dealloc
{
    [btn_email release];
    [btn_phone release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

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
    
    self.title = @"关于";
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -

- (IBAction) btnSendMailClick:(id)sender
{
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:nil
                                                    delegate:self
                                           cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:@"用邮件程序向天天付发送邮件"
                                           otherButtonTitles:nil, nil];
    
    as.tag = 101;
    [as showInView:self.view];
}

- (IBAction) btnDialClick:(id)sender
{
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:nil
                                                    delegate:self
                                           cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:@"拨打天天付客服电话"
                                           otherButtonTitles:nil, nil];
    
    as.tag = 102;
    [as showInView:self.view];
}

#pragma mark -

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (101 == actionSheet.tag)
    {
        NSURL *mail_url = [NSURL URLWithString:@"mailto://dailypay@163.com"];
        [[UIApplication sharedApplication] openURL:mail_url]; 
    }
    else if (102 == actionSheet.tag)
    {
        NSURL *phone_url = [NSURL URLWithString:@"tel://4001813800"];
        [[UIApplication sharedApplication] openURL:phone_url];    
    }
}


@end
