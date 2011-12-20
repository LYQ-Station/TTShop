//
//  TSTradeRecordsNavController.m
//  TTShop
//
//  Created by Steven Li on 11-12-20.
//  Copyright (c) 2011年 TTF Inc. All rights reserved.
//

#import "TSTradeRecordsNavController.h"
#import "TSVertifyPhoneController.h"
#import "TSTradeRecordsController.h"

@implementation TSTradeRecordsNavController

@synthesize is_vertified;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!is_vertified)
    {
        TSVertifyPhoneController *ctrl = [[TSVertifyPhoneController alloc] initWithStyle:UITableViewStyleGrouped];
        ctrl.title = @"交易记录";
        ctrl.delegate = self;
        [self pushViewController:ctrl animated:YES];
        ctrl.navigationItem.prompt = @"验证手机号码";
        [ctrl release];
    }
}

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

#pragma mark - TSVertifyPhoneController delegate

- (void) tsVertifyPhoneControllerCheckedOK:(TSVertifyPhoneController *)controller
{
    TSTradeRecordsController *ctrl = [[TSTradeRecordsController alloc] initWithStyle:UITableViewStylePlain];
    [self pushViewController:ctrl animated:YES];
    [ctrl release];
}

@end
