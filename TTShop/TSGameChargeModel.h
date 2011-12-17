//
//  TSGameChargeModel.h
//  TTShop
//
//  Created by Steven Li on 12/17/11.
//  Copyright (c) 2011 TTF Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TSGameChargeModel : NSObject
{
    BOOL					is_loading;
    NSArray                 *buffer_games;
    NSArray                 *buffer_values;
    
    id                      delegate;
}

@property (nonatomic, readonly) BOOL is_loading;
@property (nonatomic, readonly) NSArray *buffer_games;
@property (nonatomic, readonly) NSArray *buffer_values;
@property (nonatomic, assign) id delegate;

- (TSGameChargeModel *) initWithDelegate:(id)aDelegate;

- (void) loadData;

- (void) onLoadData:(NSNotification *)notify;

@end
