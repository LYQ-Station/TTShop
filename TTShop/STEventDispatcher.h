//
//  TSEventDispatcher.h
//  TTShop
//
//  Created by zhangyj on 11-12-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface STEventDispatcher : NSObject
{

}


- (void) addEventListener:(NSString *)eventName target:(id)target action:(SEL)action;

- (void) removeEventListener:(NSString *)eventName target:(id)target;

- (void) destoryEventListeners:(id)obServer;


@end
