//
//  TSTradeRecordsNavController.h
//  TTShop
//
//  Created by Steven Li on 11-12-20.
//  Copyright (c) 2011年 TTF Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSVertifyPhoneController.h"

@interface TSTradeRecordsNavController : UINavigationController <TSVertifyPhoneControllerDelegate>
{
        //标志是否验证过手机
    BOOL                is_vertified;
}

@property (nonatomic, assign) BOOL is_vertified;

@end
