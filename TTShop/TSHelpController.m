//
//  TSHelpController.m
//  TTShop
//
//  Created by Steven Li on 12/3/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import "TSHelpController.h"

@implementation TSHelpController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    UIView *v = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = v;
    [v release];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"帮助";
    
    UIWebView *web_view = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:web_view];
    [web_view release];
    
    NSString *help_html_path = [[NSBundle mainBundle] pathForResource:@"TSHelp" ofType:@"html"];
    NSData *html_data = [NSData dataWithContentsOfFile:help_html_path];
    [web_view loadData:html_data MIMEType:@"text/html" textEncodingName:@"utf-8" baseURL:nil];
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

@end
