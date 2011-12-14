//
//  TSMobileChargeController.m
//  TTShop
//
//  Created by Steven Li on 12/12/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "TSMobileChargeController.h"
#import "TSHistoryPhoneController.h"


@implementation TSMobileChargeController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"手机充值";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
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
    
    if (0 == indexPath.section)
    {
        cell.textLabel.text = @"充值号码：";
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(88.0f, 12.0f, 188.0f, 26.0f)];
        tf.font = [UIFont systemFontOfSize:14.0f];
        tf.placeholder = @"请输入手机号码";
        tf.keyboardType = UIKeyboardTypeNumberPad;
        [cell addSubview:tf];
        [tf release];
    }
    else if (1 == indexPath.section)
    {
//        for (id sv in cell.subviews)
//        {
//            if ([@"UITableViewCellContentView" isEqualToString:NSStringFromClass([sv class])])
//            {
//                UIView *v = [[UIView alloc] initWithFrame:cell.frame];
//                v.backgroundColor = [UIColor yellowColor];
//                [sv addSubview:v];
//                [v release];
//                break;
//            }
//        }
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (0 == section)
    {
        return nil;
    }
    else if (1 == section)
    {
        return @"历史充值号码";
    }
    
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (0 == section)
    {
        return @"可以为自己充值，也可为通讯录好友充值";
    }
    
    return nil;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (1 == indexPath.section)
    {
        return 278.0f;
    }
    
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if (1 == indexPath.section)
    {
        cell.clipsToBounds = YES;
        cell.backgroundColor = [UIColor blueColor];
        
        for (id sv in cell.subviews)
        {
//            NSLog(@"%@", sv);
            
            if ([@"UITableViewCellContentView" isEqualToString:NSStringFromClass([sv class])])
            {
                UIView *tmp_v = (UIView *)sv;
                tmp_v.clipsToBounds = YES;
                
//                UITableViewController *ctrl = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
//                ctrl.tableView.frame = cell.bounds;
//                [tmp_v addSubview:ctrl.tableView];
                
//                TSHistoryPhoneController *ctrl = [[TSHistoryPhoneController alloc] initWithStyle:UITableViewStylePlain];
//                ctrl.tableView.frame = cell.bounds;
//                [tmp_v addSubview:ctrl.tableView];
                
                CALayer *mask_layer = [CALayer layer];
                [tmp_v.layer addSublayer:mask_layer];
                mask_layer.backgroundColor = [[UIColor yellowColor] CGColor];
                mask_layer.frame = cell.bounds;
                mask_layer.cornerRadius = 15.0f;
                tmp_v.layer.mask = mask_layer;
                tmp_v.layer.masksToBounds = YES;
                
                break;
            }
        }
        
//        UIView *v = [[UIView alloc] initWithFrame:cell.frame];
//        v.backgroundColor = [UIColor blueColor];
//        [cell addSubview:v];
    }
}

@end
