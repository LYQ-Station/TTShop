//
//  TSTradeRemindModel.h
//  TTShop
//
//  Created by Steven Li on 12/6/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STEventDispatcher.h"

@interface TSTradeRemindModel : STEventDispatcher
{
    NSMutableDictionary         *buffer;
    BOOL                        is_loading;
}

@property (nonatomic, readonly) NSMutableDictionary *buffer;
@property (nonatomic, assign) BOOL is_loading;

@end
