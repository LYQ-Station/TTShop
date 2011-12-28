//
//  TSSysNoticeModel.h
//  TTShop
//
//  Created by Steven Li on 11-12-28.
//  Copyright (c) 2011年 TTF Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSSysNoticeModel : NSObject
{
    BOOL					is_loading;
    NSMutableArray          *buffer;
    
    id                      delegate;
}

@property (nonatomic, readonly) BOOL is_loading;
@property (nonatomic, readonly) NSMutableArray *buffer;
@property (nonatomic, assign) id delegate;

- (id) initWithDelegate:(id)aDelegate;

- (void) loadNewData;

- (void) onLoadNewData:(NSNotification *)notify;

- (void) loadOldData;

- (void) onLoadOldData:(NSNotification *)notify;

@end
