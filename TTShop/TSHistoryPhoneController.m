//
//  TSHistoryPhoneController.m
//  TTShop
//
//  Created by Steven Li on 12/13/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import "TSHistoryPhoneController.h"

static NSString *cache_file_name = @"history_phone.cache";

@implementation TSHistoryPhoneController

@synthesize buffer;
@synthesize delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self)
    {
        [self loadDataFromCache];
    }
    
    return self;
}

- (void) dealloc
{
    [self saveDataToCache];
    
    [buffer release];

    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.allowsSelectionDuringEditing = YES;
    
    if (0 < [buffer count])
    {
        [self.tableView setEditing:YES animated:NO];
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
    if (0 == [buffer count])
    {
        return 1;
    }
    
    return [buffer count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == [buffer count])
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"empty"];
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"empty"] autorelease];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"暂无记录。";
        cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        
        return cell;
    }
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSDictionary *dic = [buffer objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [dic objectForKey:@"name"];
    cell.detailTextLabel.text = [dic objectForKey:@"phoneNO"];
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [buffer removeObjectAtIndex:indexPath.row];
        
        if (0 == [buffer count])
        {
            [self.tableView setEditing:NO animated:NO];
        }
        
        [tableView reloadData];
        
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return NO;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == [buffer count])
    {
        return;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (delegate)
    {
        [delegate performSelector:@selector(tsHistoryPhoneController:didSelectRowAtIndexPath:) withObject:self withObject:indexPath];
    }
}

#pragma mark -

- (void) loadDataFromCache
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
	NSString *document_directory = [paths objectAtIndex:0];
	NSString *data_file = [document_directory stringByAppendingPathComponent:cache_file_name];
        
    if (buffer)
    {
        [buffer release];
        buffer = nil;
    }
    
    buffer = [NSMutableArray arrayWithContentsOfFile:data_file];
    
    if (!buffer)
    {
        buffer = [[NSMutableArray alloc] init];
    }
    else
    {
        [buffer retain];
    }
}

- (void) saveDataToCache
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
	NSString *document_directory = [paths objectAtIndex:0];
	NSString *data_file = [document_directory stringByAppendingPathComponent:cache_file_name];
    
    [buffer writeToFile:data_file atomically:NO];
}

- (void) addAPhoneNO:(NSString *)phoneNO contact:(NSString *)name
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:phoneNO, @"phoneNO", name, @"name", nil];
    
    [buffer insertObject:dic atIndex:0];
    
    [self.tableView reloadData];
    
    [self.tableView setEditing:YES animated:NO];
}

@end
