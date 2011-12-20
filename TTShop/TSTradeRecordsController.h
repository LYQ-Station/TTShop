//
//  TSTradeRecordsController.h
//  TTShop
//
//  Created by Steven Li on 12/9/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSTradeRecordsController : UITableViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    UIToolbar           *tb_for_picker;
    UIBarButtonItem     *tb_close;
    UIBarButtonItem     *tb_submit;
    UIPickerView        *pv_picker;
    UISegmentedControl  *sg_switch;
    
        //标志是否验证过手机
    BOOL                is_vertified;
}

@property (nonatomic, retain) IBOutlet UIToolbar *tb_for_picker;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *tb_close;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *tb_submit;
@property (nonatomic, retain) IBOutlet UIPickerView *pv_picker;
@property (nonatomic, assign) BOOL is_vertified;

- (void) segmentClick:(id)sender;

- (IBAction) btnCloseKeyBoardClick:(id)sender;

- (IBAction) btnSubmitClick:(id)sender;

@end
