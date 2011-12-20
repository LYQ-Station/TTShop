//
//  TSVertifyPhoneController.h
//  TTShop
//
//  Created by Steven Li on 12/11/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSVertifyPhoneController : UITableViewController <UITextFieldDelegate>
{
    BOOL                is_show_close_btn;
    
    UITextField         *tf_curr_inputbox;
    
    id                  delegate;
}

@property (nonatomic, assign) BOOL is_show_close_btn;
@property (nonatomic, readonly) UITextField *tf_curr_inputbox;
@property (nonatomic, assign) id delegate;

- (void) btnCloseKeyboardClick:(id)sender;

- (void) btnCloseClick:(id)sender;

- (void) btnSubmitClick:(id)sender;

@end

@protocol TSVertifyPhoneControllerDelegate <NSObject>

@optional
- (void) tsVertifyPhoneControllerDidCancel:(TSVertifyPhoneController *)controller;

- (void) tsVertifyPhoneControllerCheckedOK:(TSVertifyPhoneController *)controller;

@end