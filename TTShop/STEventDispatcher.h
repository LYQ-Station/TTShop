//
//  TSEventDispatcher.h
//  TTShop
//
//  Created by Steven Li on 12/1/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface STEventDispatcher : NSObject
{

}


- (void) addEventListener:(NSString *)eventName target:(id)target action:(SEL)action;

- (void) removeEventListener:(NSString *)eventName target:(id)target;

- (void) destoryEventListeners:(id)obServer;

- (void) dispatchEvent:(NSString *)eventString;


@end
