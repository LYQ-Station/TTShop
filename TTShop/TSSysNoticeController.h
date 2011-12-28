//
//  TSSysNoticeController.h
//  TTShop
//
//  Created by Steven Li on 12/3/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EGORefreshTableHeaderView;

@class TSSysNoticeModel;

@interface TSSysNoticeController : UITableViewController
{
    UISegmentedControl          *sg_switch;
    
    EGORefreshTableHeaderView	*refresh_view_h;
	EGORefreshTableHeaderView	*refresh_view_b;
    
    NSInteger                   last_cell_row_num;
    
    TSSysNoticeModel            *model;
}

@property (nonatomic, retain) UISegmentedControl *sg_switch;

- (void) segmentedControlChange:(id)sender;

- (void) loadData;

- (void) onModelLoadNewData:(id)aModel;

@end
