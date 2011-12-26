//
//  TSGameChargeController.h
//  TTShop
//
//  Created by Steven Li on 11-12-15.
//  Copyright (c) 2011年 TTF Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "TSHistoryPhoneController.h"
#import "TSGameChargeModel.h"

@interface TSGameChargeController : UITableViewController <TSHistoryPhoneDelegate, UINavigationControllerDelegate, ABPeoplePickerNavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>
{
    UITextField                     *tf_phone_no;
    TSHistoryPhoneController        *tab_ctrl_inner;
    UIButton                        *mask_btn;
    UIView                          *curr_inputbox;
    
    UIToolbar                       *tb_for_picker;
    UIPickerView                    *pv_picker;
    
    TSGameChargeModel               *model;
}

@property (nonatomic, retain) TSHistoryPhoneController *tab_ctrl_inner;
@property (nonatomic, retain) UIToolbar *tb_for_picker;
@property (nonatomic, retain) UIPickerView *pv_picker;

- (void) btnContactClick:(id)sender;

- (void) btnNextStepClick:(id)sender;

- (void) btnClosePickerClick:(id)sender;

- (void) btnCloseKeyBoardClick:(id)sender;

- (void) btnSubmitClick:(id)sender;

#pragma mrak -

- (void) loadData;

@end
