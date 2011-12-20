//
//  TSTradeRemindModel.m
//  TTShop
//
//  Created by Steven Li on 12/6/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import "TSTradeRemindModel.h"
#import "TSConfigs.h"
#import "STURLLoader.h"

@implementation TSTradeRemindModel

@synthesize buffer;
@synthesize is_loading;
@synthesize delegate;

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    [super dealloc];
}

- (TSTradeRemindModel *) initWithDelegate:(id)aDelegate;
{
    self = [super init];
    
    if (self)
    {
        delegate = aDelegate;
    }
    
    return self;
}

- (void) fetchNewData;
{
    if (is_loading)
    {
        return;
    }
    
    is_loading = YES;
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void) onFetchNewData:(NSNotification *)notify
{
    is_loading = NO;
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    STURLLoader *loader = (STURLLoader *)notify.object;
//    NSDictionary *json = [loader getJSONData];
    
    [loader removeEventListener:STLOADER_FAIL target:self];
	[loader removeEventListener:STLOADER_COMPLETE target:self];
	[loader release];
    
    [STURLLoader releaseBindedLoaderForDelegate:self];
    
    if (delegate && [delegate respondsToSelector:@selector(onModelFetchNew:)])
    {
        [delegate performSelector:@selector(onModelFetchNew:) withObject:self];
    }
}

- (void) fetchOldData
{
    if (is_loading)
    {
        return;
    }
    
    is_loading = YES;
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void) onFetchOldData:(NSNotification *)notify
{
    is_loading = NO;
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    STURLLoader *loader = (STURLLoader *)notify.object;
//    NSDictionary *json = [loader getJSONData];
    
    [loader removeEventListener:STLOADER_FAIL target:self];
	[loader removeEventListener:STLOADER_COMPLETE target:self];
	[loader release];
    
    [STURLLoader releaseBindedLoaderForDelegate:self];
    
    if (delegate && [delegate respondsToSelector:@selector(onModelFetchNew:)])
    {
        [delegate performSelector:@selector(onModelFetchNew:) withObject:self];
    }
}

- (void) onLoadDataFail:(NSNotification *)notify
{
    is_loading = NO;
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    STURLLoader *loader = (STURLLoader *)notify.object;
    
    [loader removeEventListener:STLOADER_FAIL target:self];
	[loader removeEventListener:STLOADER_COMPLETE target:self];
	[loader release];
}

@end
