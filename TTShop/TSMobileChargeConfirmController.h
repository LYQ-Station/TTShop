//
//  TSMobileChargeConfirmController.h
//  TTShop
//
//  Created by Steven Li on 11-12-15.
//  Copyright (c) 2011年 TTF Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSMobileChargeConfirmController : UITableViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    UIToolbar               *tb_for_picker;
    UIPickerView            *pv_picker;
    
    NSDictionary            *charge_types;
    NSDictionary            *phone_info;
}

@property (nonatomic, retain) UIToolbar *tb_for_picker;
@property (nonatomic, retain) UIPickerView *pv_picker;
@property (nonatomic, retain) NSDictionary *charge_types;
@property (nonatomic, retain) NSDictionary *phone_info;

- (void) btnNextStepClick:(id)sender;

- (void) btnCloseKeyBoardClick:(id)sender;

- (void) btnSubmitClick:(id)sender;

@end
