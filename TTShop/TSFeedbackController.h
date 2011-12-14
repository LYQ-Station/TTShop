//
//  TSFeedbackController.h
//  TTShop
//
//  Created by Steven Li on 12/3/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSFeedbackController : UITableViewController
{
    UITextView          *txt_feedback;
}

@property (nonatomic, retain) UITextView *txt_feedback;

- (void) btnSendClick:(id)sender;

@end
