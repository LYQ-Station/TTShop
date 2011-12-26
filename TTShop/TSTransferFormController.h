//
//  TSTransferFormController.h
//  TTShop
//
//  Created by Steven Li on 11-12-26.
//  Copyright (c) 2011年 TTF Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSTransferContactNavController.h"

@interface TSTransferFormController : UITableViewController <TSTransferContactPickerDelegate>

- (void) btnNextStepClick:(id)sender;

- (void) btnContactClick:(id)sender;

@end
