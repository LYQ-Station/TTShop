//
//  TSTradeRemindController.h
//  TTShop
//
//  Created by Steven Li on 12/3/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSVertifyPhoneController.h"

@class EGORefreshTableHeaderView;
@class TSTradeRemindModel;

@interface TSTradeRemindController : UITableViewController<TSVertifyPhoneControllerDelegate>
{
    UISegmentedControl          *sg_switch;
    
    EGORefreshTableHeaderView	*refresh_view_h;
	EGORefreshTableHeaderView	*refresh_view_b;
    
    TSTradeRemindModel          *model;
    
    BOOL                        is_verified;
}

@property (nonatomic, retain) UISegmentedControl *sg_switch;
@property (nonatomic, assign) BOOL is_verified;

- (IBAction) segmentedControlChange:(id)sender;

- (void) loadData;

@end
