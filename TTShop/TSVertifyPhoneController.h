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
    BOOL                show_close_btn;
    BOOL                is_loading;
    
    UITextField         *tf_curr_inputbox;
    UIButton            *mask_btn;
    
    id                  delegate;
}

@property (nonatomic, assign) BOOL show_close_btn;
@property (nonatomic, readonly) UITextField *tf_curr_inputbox;
@property (nonatomic, assign) id delegate;

- (void) btnCloseKeyboardClick:(id)sender;

- (void) btnCloseClick:(id)sender;

- (void) btnSubmitClick:(id)sender;

- (void) doVerify;

- (void) onVerfiy:(NSNotification *)notify;

@end

@protocol TSVertifyPhoneControllerDelegate <NSObject>

@optional
- (void) tsVertifyPhoneControllerDidCancel:(TSVertifyPhoneController *)controller;

- (void) tsVertifyPhoneControllerCheckedOK:(TSVertifyPhoneController *)controller;

@end