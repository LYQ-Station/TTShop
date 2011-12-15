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

@interface TSGameChargeController : UITableViewController <TSHistoryPhoneDelegate, UINavigationControllerDelegate, ABPeoplePickerNavigationControllerDelegate>
{
    UITextField                        *tf_phone_no;
    TSHistoryPhoneController           *tab_ctrl_inner;
}

@property (nonatomic, retain) TSHistoryPhoneController *tab_ctrl_inner;

- (void) btnContactClick:(id)sender;

- (void) btnNextStepClick:(id)sender;

@end
