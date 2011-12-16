//
//  TSAppsGridViewController.m
//  TTShop
//
//  Created by Steven Li on 12/3/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "TSAppsGridViewController.h"
#import "TSGameChargeController.h"
#import "TSMobileChargeController.h"

@implementation TSAppsGridViewController

@synthesize sg_switch;

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

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    CGRect main_bounds = [[UIScreen mainScreen] bounds];
	
	UIView *v = [[UIView alloc] initWithFrame:main_bounds];
	v.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
	self.view = v;
	[v release];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"生活应用";
    
    UISegmentedControl *sg_ctrl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"list", @"grid", nil]];
	sg_ctrl.segmentedControlStyle = UISegmentedControlStyleBar;
    sg_ctrl.frame = CGRectMake(0, 0, 70, 30);
	sg_ctrl.selectedSegmentIndex = 1;
    [sg_ctrl setImage:[UIImage imageNamed:@"app_list"] forSegmentAtIndex:0];
    [sg_ctrl setImage:[UIImage imageNamed:@"app_grid"] forSegmentAtIndex:1];
    [sg_ctrl addTarget:self action:@selector(segmentedControlChange:) forControlEvents:UIControlEventValueChanged];
    sg_ctrl.frame = CGRectMake(0, 0, 70, 30);
	sg_ctrl.selectedSegmentIndex = 1;    self.sg_switch = sg_ctrl;
    [sg_ctrl release];
    
    UIBarButtonItem *btn_view_switch = [[UIBarButtonItem alloc] initWithCustomView:sg_ctrl];
    self.navigationItem.leftBarButtonItem = btn_view_switch;
    
    CGRect main_bounds = [[UIScreen mainScreen] bounds];
	
	CGRect sv_frm = main_bounds;
	sv_frm.size.height = 416.0f;
	page_scrollview = [[UIScrollView alloc] initWithFrame:sv_frm];
	page_scrollview.delegate = self;
	page_scrollview.pagingEnabled = YES;
	page_scrollview.showsVerticalScrollIndicator = NO;
	page_scrollview.showsHorizontalScrollIndicator = YES;
	[self.view addSubview:page_scrollview];
	[page_scrollview release];
	
	CGRect pc_frm = CGRectMake(main_bounds.origin.x,
							   sv_frm.size.height - 50.0f - 36.0f,
							   main_bounds.size.width,
							   36.0f);
	page_control = [[UIPageControl alloc] initWithFrame:pc_frm];
	page_control.userInteractionEnabled = NO;
	page_control.hidesForSinglePage = YES;
	[self.view addSubview:page_control];
	[page_control release];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
	btn.titleLabel.text = @"游戏充值";
	[btn setImage:[UIImage imageNamed:@"app_gamem"] forState:UIControlStateNormal];
	[btn addTarget:self action:@selector(btnGameChargeClick:) forControlEvents:UIControlEventTouchUpInside];
	[self addButton:btn];
	[btn release];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
	btn.titleLabel.text = @"手机充值";
	[btn setImage:[UIImage imageNamed:@"app_phonem"] forState:UIControlStateNormal];
	[btn addTarget:self action:@selector(btnMobileChargeClick:) forControlEvents:UIControlEventTouchUpInside];
	[self addButton:btn];
	[btn release];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
	btn.titleLabel.text = @"转帐汇款";
	[btn setImage:[UIImage imageNamed:@"app_bank_service"] forState:UIControlStateNormal];
	[btn addTarget:self action:@selector(btnBankServiceClick:) forControlEvents:UIControlEventTouchUpInside];
	[self addButton:btn];
	[btn release];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
	btn.titleLabel.text = @"我的测试";
	[btn setImage:[UIImage imageNamed:@"app_firem"] forState:UIControlStateNormal];
	[self addButton:btn];
	[btn release];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
	btn.titleLabel.text = @"我的测试";
	[btn setImage:[UIImage imageNamed:@"app_waterm"] forState:UIControlStateNormal];
	[self addButton:btn];
	[btn release];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
	btn.titleLabel.text = @"我的测试";
	[btn setImage:[UIImage imageNamed:@"app_elem"] forState:UIControlStateNormal];
	[self addButton:btn];
	[btn release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.sg_switch = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -

- (void) segmentedControlChange:(id)sender
{
    UISegmentedControl *sg_ctrl = (UISegmentedControl *)sender;
    
    if (0 == sg_ctrl.selectedSegmentIndex)
    {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}

- (void) addButton:(UIButton *)btn
{
    if (!buttons)
	{
		buttons = [[NSMutableSet alloc] init];
	}
	
	int btn_idx = [buttons count];
	int btn_page_idx = (btn_idx + 9) % 9;
	int page_idx = floorf([buttons count] / 9);
	UIView *v = [page_scrollview viewWithTag:(100 + page_idx)];
	
	if (!v)
	{
		CGRect frm = [[UIScreen mainScreen] bounds];
		frm.origin.x = page_idx * frm.size.width;
		frm.size.height = 416.0f;
		
		v = [[UIView alloc] initWithFrame:frm];
		v.tag = 100 + page_idx;
		
		[page_scrollview addSubview:v];
		[v release];
		
		page_scrollview.contentSize = CGSizeMake(frm.size.width * (page_idx + 1), 416.0f);
		page_control.numberOfPages = 1 + page_idx;
		
		[page_control setNeedsDisplay];
	}
	
	btn.tag = btn_idx;
	btn.frame = CGRectMake((27.0f + 70.0f) * ((btn_page_idx + 3 ) % 3) + 27.0f,
						   (20.0f + 90.0f) * ceilf(btn_page_idx / 3) + 20.0f,
						   70.0f,
						   70.0f);
	
    //	btn.layer.shadowColor = [[UIColor darkGrayColor] CGColor];
    //	btn.layer.shadowOffset = CGSizeMake(1.3f, 1.3f);
    //	btn.layer.shadowRadius = 1.0f;
    //	btn.layer.shadowOpacity = 0.6f;
	
	[v addSubview:btn];
	
	CGRect frm_lb = btn.frame;
	frm_lb.origin.x -= 8.0f;
	frm_lb.origin.y += 70.0f; 
	frm_lb.size.width += 16.0f;
	frm_lb.size.height = 19.0f;
	
	if (btn.titleLabel.text)
	{
		UILabel *lb_for_btn = [[UILabel alloc] initWithFrame:frm_lb];
		lb_for_btn.backgroundColor = [UIColor clearColor];
		lb_for_btn.font = [UIFont systemFontOfSize:14.0f];
		lb_for_btn.textAlignment = UITextAlignmentCenter;
		lb_for_btn.textColor = [UIColor darkTextColor];
		lb_for_btn.text = btn.titleLabel.text;
		lb_for_btn.layer.shadowColor = [[UIColor whiteColor] CGColor];
		lb_for_btn.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
		lb_for_btn.layer.shadowRadius = 0.0f;
		lb_for_btn.layer.shadowOpacity = 0.7f;
		[v addSubview:lb_for_btn];
		[lb_for_btn release];
	}
	
	[buttons addObject:btn];
}

- (void) btnGameChargeClick:(id)sender
{
    UIViewController *ctrl = [[TSGameChargeController alloc] initWithStyle:UITableViewStyleGrouped];
    ctrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ctrl animated:YES];
    [ctrl release];
}

- (void) btnMobileChargeClick:(id)sender
{
    UIViewController *ctrl = [[TSMobileChargeController alloc] initWithStyle:UITableViewStyleGrouped];
    ctrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ctrl animated:YES];
    [ctrl release];
}

- (void) btnBankServiceClick:(id)sender
{
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:nil
                                                 message:@"暂时未开通撒！"
                                                delegate:nil
                                       cancelButtonTitle:@"晓得了"
                                       otherButtonTitles:nil, nil];
    
    [av show];
    [av release];
}

@end
