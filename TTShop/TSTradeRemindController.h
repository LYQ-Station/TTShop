//
//  TSTradeRemindController.h
//  TTShop
//
//  Created by Steven Li on 12/3/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSTradeRemindController : UITableViewController
{
    UISegmentedControl          *sg_switch;
}

@property (nonatomic, retain) UISegmentedControl *sg_switch;

- (IBAction) segmentedControlChange:(id)sender;

@end
