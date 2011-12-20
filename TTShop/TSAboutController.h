//
//  TSAboutController.h
//  TTShop
//
//  Created by Steven Li on 12/4/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSAboutController : UIViewController <UIActionSheetDelegate>
{
    UIButton            *btn_email;
    UIButton            *btn_phone;
}

@property (nonatomic, retain) IBOutlet UIButton *btn_email;
@property (nonatomic, retain) IBOutlet UIButton *btn_phone;

- (IBAction) btnSendMailClick:(id)sender;

- (IBAction) btnDialClick:(id)sender;

@end
