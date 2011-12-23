//
//  TSFeedbackController.h
//  TTShop
//
//  Created by Steven Li on 12/3/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSFeedbackController : UITableViewController <UITextFieldDelegate, UITextViewDelegate, UIAlertViewDelegate>
{
    UITextView          *txt_feedback;
    UIView              *curr_input_field;
    
    BOOL                is_loading;
}

@property (nonatomic, retain) UITextView *txt_feedback;

- (void) btnSendClick:(id)sender;

- (void) send;

- (void) onSended:(NSNotification *)notify;

@end
