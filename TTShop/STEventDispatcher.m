//
//  TSEventDispatcher.m
//  TTShop
//
//  Created by zhangyj on 11-12-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
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


@end
