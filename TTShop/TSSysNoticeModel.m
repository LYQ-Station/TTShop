//
//  TSSysNoticeModel.m
//  TTShop
//
//  Created by Steven Li on 11-12-28.
//  Copyright (c) 2011年 TTF Inc. All rights reserved.
//

#import "TSSysNoticeModel.h"
#import "TSConfigs.h"
#import "STURLLoader.h"

@implementation TSSysNoticeModel

@synthesize is_loading;
@synthesize buffer;
@synthesize delegate;

#pragma mark - init

- (id) initWithDelegate:(id)aDelegate
{
    self = [super init];
    
    if (self)
    {
        is_loading = NO;
        delegate = aDelegate;
        
        buffer = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    [STURLLoader releaseBindedLoaderForDelegate:self];
    
    [buffer release];
    
    [super dealloc];
}

#pragma mark - network

- (void) loadNewData
{
    if (is_loading)
	{
		return;
	}
    
    is_loading = YES;
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString *full_url = [NSString stringWithFormat:@"http://www.baidu.com", BASE_URL, nil];
    
    STURLRequest *req = [[STURLRequest alloc] initWithURLString:full_url];
    STURLLoader *loader = [[STURLLoader alloc] initWithURLRequest:req];
    [loader addEventListener:STLOADER_COMPLETE target:self action:@selector(onLoadNewData:)];
    
    [req release];
    [STURLLoader bindLoader:loader withDelegate:self];
    
    [loader load];
}

- (void) onLoadNewData:(NSNotification *)notify
{
    NSLog(@"+++++++++ on model loaded new");
    
    is_loading = NO;
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    STURLLoader *loader = (STURLLoader *)notify.object;
//    NSDictionary *json = [loader getJSONData];
    
	[loader removeEventListener:STLOADER_COMPLETE target:self];
	[loader release];
    
    [STURLLoader releaseBindedLoaderForDelegate:self];
    
    if (delegate && [delegate respondsToSelector:@selector(onModelLoadNewData:)])
    {
        [delegate performSelector:@selector(onModelLoadNewData:) withObject:self];
    }
}

- (void) loadOldData
{
    if (is_loading)
	{
		return;
	}
    
    is_loading = YES;
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString *full_url = [NSString stringWithFormat:@"http://www.baidu.com", BASE_URL, nil];
    
    STURLRequest *req = [[STURLRequest alloc] initWithURLString:full_url];
    STURLLoader *loader = [[STURLLoader alloc] initWithURLRequest:req];
    [loader addEventListener:STLOADER_COMPLETE target:self action:@selector(onLoadOldData:)];
    
    [req release];
    [STURLLoader bindLoader:loader withDelegate:self];
    
    [loader load];
}

- (void) onLoadOldData:(NSNotification *)notify
{
    NSLog(@"+++++++++ on model loaded old");
    
    is_loading = NO;
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    STURLLoader *loader = (STURLLoader *)notify.object;
//    NSDictionary *json = [loader getJSONData];
    
	[loader removeEventListener:STLOADER_COMPLETE target:self];
	[loader release];
    
    [STURLLoader releaseBindedLoaderForDelegate:self];
    
    if (delegate && [delegate respondsToSelector:@selector(onModelLoadOldData:)])
    {
        [delegate performSelector:@selector(onModelLoadOldData:) withObject:self];
    }
}

@end
