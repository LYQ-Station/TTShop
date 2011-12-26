//
//  TSTransferFormController.m
//  TTShop
//
//  Created by Steven Li on 11-12-26.
//  Copyright (c) 2011年 TTF Inc. All rights reserved.
//

#import "TSTransferFormController.h"
#import "TSTransferConfirmContoller.h"
#import "TSTransferContactNavController.h"

@implementation TSTransferFormController

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
    
    self.title = @"汇款转帐";
    self.clearsSelectionOnViewWillAppear = YES;
    
    UIBarButtonItem *btn_next_step = [[UIBarButtonItem alloc] initWithTitle:@"下一步"
                                                                      style:UIBarButtonItemStyleDone
                                                                     target:self
                                                                     action:@selector(btnNextStepClick:)];
    self.navigationItem.rightBarButtonItem = btn_next_step;
    [btn_next_step release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
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
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger r = 0;
    
    switch (section)
    {
        case 0:
            r = 2;
            break;
            
        case 1:
            r = 4;
            break;
            
        case 2:
        case 3:
        case 4:
            r = 1;
            break;
    }
    
    return r;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (4 == indexPath.section)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"last_cell"];
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"last_cell"] autorelease];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.textLabel.text = @"立即执行";
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        
        return cell;
    }
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (0 == indexPath.section)
    {
        if (0 == indexPath.row)
        {
            cell.textLabel.text = @"收款方用户名";
            cell.textLabel.numberOfLines = 2;
            
            UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(88.0f, 10.0f, 183.0f, 26.0f)];
            tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            tf.font = [UIFont systemFontOfSize:14.0f];
            tf.placeholder = @"收款方用户名";
            [cell addSubview:tf];
            [tf release];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, 0, 54, 54);
            [btn setImage:[UIImage imageNamed:@"btn_conp"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnContactClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.accessoryView = btn;
        }
        else
        {
            cell.textLabel.text = @"添加为常用联系人";
            cell.textLabel.numberOfLines = 2;
            UISwitch *btn_switch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 70, 27)];
            cell.accessoryView = btn_switch;
            [btn_switch release];
        }
    }
    else if (1 == indexPath.section)
    {
        if (0 == indexPath.row)
        {
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            cell.textLabel.text = @"选择收款方开户银行";
            cell.textLabel.numberOfLines = 2;
            cell.detailTextLabel.text = @"招商银行";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (1 == indexPath.row)
        {
            cell.textLabel.text = @"收款方帐号";
            
            UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(88.0f, 10.0f, 183.0f, 26.0f)];
            tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            tf.font = [UIFont systemFontOfSize:14.0f];
            tf.placeholder = @"收款方帐号";
            [cell addSubview:tf];
            [tf release];
        }
        else if (2 == indexPath.row)
        {
            cell.textLabel.text = @"确认收款帐号";
            cell.textLabel.numberOfLines = 2;
            
            UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(88.0f, 10.0f, 183.0f, 26.0f)];
            tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            tf.font = [UIFont systemFontOfSize:14.0f];
            tf.placeholder = @"再输入一次收款帐号";
            [cell addSubview:tf];
            [tf release];
        }
        else if (3 == indexPath.row)
        {
            cell.textLabel.text = @"转帐金额";
            
            UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(88.0f, 10.0f, 183.0f, 26.0f)];
            tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            tf.font = [UIFont systemFontOfSize:14.0f];
            tf.placeholder = @"每比金额最多5000元";
            [cell addSubview:tf];
            [tf release];
        }
    }
    else if (2 == indexPath.section)
    {
        cell.textLabel.text = @"您的手机号码";
        cell.textLabel.numberOfLines = 2;
        
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(88.0f, 10.0f, 183.0f, 26.0f)];
        tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        tf.font = [UIFont systemFontOfSize:14.0f];
        tf.placeholder = @"您的手机号码";
        [cell addSubview:tf];
        [tf release];
    }
    else if (3 == indexPath.section)
    {
        cell.textLabel.text = @"收款方手机号";
        cell.textLabel.numberOfLines = 2;
        
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(88.0f, 10.0f, 183.0f, 26.0f)];
        tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        tf.font = [UIFont systemFontOfSize:14.0f];
        tf.placeholder = @"收款方手机号";
        [cell addSubview:tf];
        [tf release];
    }
    
    return cell;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (4 == indexPath.section)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
}

#pragma mark - 

#pragma mark - TSTransferContactPickerDelegate

- (void) tsTransferContactPickerDidCancel:(TSTransferContactNavController *)aController
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void) tsTransferContactPickerDidSelect:(TSTransferContactNavController *)aController withPerson:(NSDictionary *)personInfo
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void) btnNextStepClick:(id)sender
{
    TSTransferConfirmContoller *ctrl = [[TSTransferConfirmContoller alloc] initWithStyle:UITableViewStyleGrouped];
    ctrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ctrl animated:YES];
    [ctrl release];
}

- (void) btnContactClick:(id)sender
{
    TSTransferContactNavController *ctrl = [[TSTransferContactNavController alloc] initWithNibName:nil bundle:nil];
    ctrl.delegate = self;
    [self presentModalViewController:ctrl animated:YES];
    [ctrl release];
}

@end
