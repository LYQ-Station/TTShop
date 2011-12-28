//
//  TSGameChargeModel.m
//  TTShop
//
//  Created by Steven Li on 12/17/11.
//  Copyright (c) 2011 TTF Inc. All rights reserved.
//

#import "TSGameChargeModel.h"
#import "TSConfigs.h"
#import "STURLLoader.h"

@implementation TSGameChargeModel

@synthesize is_loading;
@synthesize buffer_games;
@synthesize buffer_values;
@synthesize delegate;

#pragma mark - init

- (id) initWithDelegate:(id)aDelegate
{
    self = [super init];
    
    if (self)
    {
        is_loading = NO;
        delegate = aDelegate;
    }
    
    return self;
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    [STURLLoader releaseBindedLoaderForDelegate:self];
    
    [buffer_games release];
    [buffer_values release];
    
    [super dealloc];
}

#pragma mark - network

- (void) loadData
{
    if (is_loading)
	{
		return;
	}
    
    is_loading = YES;
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString *full_url = [NSString stringWithFormat:@"%@/txt.txt", BASE_URL, nil];
    
    STURLRequest *req = [[STURLRequest alloc] initWithURLString:full_url];
    STURLLoader *loader = [[STURLLoader alloc] initWithURLRequest:req];
    [loader addEventListener:STLOADER_COMPLETE target:self action:@selector(onLoadData:)];
    
    [req release];
    [STURLLoader bindLoader:loader withDelegate:self];
    
    [loader load];
}

- (void) onLoadData:(NSNotification *)notify
{
    is_loading = NO;
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    STURLLoader *loader = (STURLLoader *)notify.object;
//    NSDictionary *json = [loader getJSONData];
    
	[loader removeEventListener:STLOADER_COMPLETE target:self];
	[loader release];
    
    [STURLLoader releaseBindedLoaderForDelegate:self];
    
    if (buffer_games)
    {
        [buffer_games release];
        buffer_games = nil;
    }
    
    buffer_games = [[NSArray arrayWithObjects:@"联众游戏", @"QQ游戏", @"GT赛车", nil] retain];
    
    if (buffer_values)
    {
        [buffer_values release];
        buffer_values = nil;
    }
    
    buffer_values = [[NSArray arrayWithObjects:
                     [NSArray arrayWithObjects:@"10元", @"100元", nil],
                     [NSArray arrayWithObjects:@"5点", @"99点", @"123点", nil],
                     [NSArray arrayWithObjects:@"100Kala", @"200kala", @"300kala", nil],
                     nil] retain];
    
    
        //call delegate method
    if (delegate && [delegate respondsToSelector:@selector(onModelLoaded:)])
    {
        [delegate performSelector:@selector(onModelLoaded:) withObject:self];
    }
}

@end
