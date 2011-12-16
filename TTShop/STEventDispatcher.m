//
//  TSEventDispatcher.m
//  TTShop
//
//  Created by Steven Li on 12/1/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import "STEventDispatcher.h"


@implementation STEventDispatcher


- (void) dealloc
{
	[super dealloc];
}

- (void) addEventListener:(NSString *)eventName target:(id)target action:(SEL)action
{
	[[NSNotificationCenter defaultCenter] addObserver:target selector:action name:eventName object:self];
}

- (void) removeEventListener:(NSString *)eventName target:(id)target
{
	[[NSNotificationCenter defaultCenter] removeObserver:target name:eventName object:self];
}

- (void) destoryEventListeners:(id)obServer
{
	[[NSNotificationCenter defaultCenter] removeObserver:obServer];
}

- (void) dispatchEvent:(NSString *)eventString
{
	[[NSNotificationCenter defaultCenter] postNotificationName:eventString object:self];
}


@end
