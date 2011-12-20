//
//  TSTradeRemindController.h
//  TTShop
//
//  Created by Steven Li on 12/3/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EGORefreshTableHeaderView;
@class TSTradeRemindModel;

@interface TSTradeRemindController : UITableViewController
{
    UISegmentedControl          *sg_switch;
    
    EGORefreshTableHeaderView	*refresh_view_h;
	EGORefreshTableHeaderView	*refresh_view_b;
    
    TSTradeRemindModel          *model;
}

@property (nonatomic, retain) UISegmentedControl *sg_switch;

- (IBAction) segmentedControlChange:(id)sender;

- (void) loadData;

@end
