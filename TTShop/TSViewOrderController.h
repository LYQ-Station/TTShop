//
//  TSViewOrderController.h
//  TTShop
//
//  Created by Steven Li on 11-12-15.
//  Copyright (c) 2011年 TTF Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSOrderPropertyController.h"

@interface TSViewOrderController : UITableViewController
{
    TSOrderPropertyController           *tab_ctrl_inner;
}

@property (nonatomic, retain) TSOrderPropertyController *tab_ctrl_inner;

@end
