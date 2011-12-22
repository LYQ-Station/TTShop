//
//  TSMobileChargeController.h
//  TTShop
//
//  Created by Steven Li on 12/12/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "TSHistoryPhoneController.h"

@interface TSMobileChargeController : UITableViewController <TSHistoryPhoneDelegate, UINavigationControllerDelegate, ABPeoplePickerNavigationControllerDelegate, UITextFieldDelegate>
{
    UITextField                         *tf_phone_no;
    TSHistoryPhoneController            *tab_ctrl_inner;
    
    UIButton                            *mask_btn;
}

@property (nonatomic, retain) TSHistoryPhoneController *tab_ctrl_inner;

- (void) btnCloseKeyboardClick:(id)sender;

- (void) btnContactClick:(id)sender;

- (void) btnNextStepClick:(id)sender;

- (void) submitPhone;

- (void) onSubmitPhone:(NSNotification *)notify;

@end
