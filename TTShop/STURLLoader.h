//
//  STURLLoader.h
//  TTShop
//
//  Created by zhangyj on 11-12-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STEventDispatcher.h"
#import "STURLRequest.h"


@interface STURLLoader : STEventDispatcher
{
	NSURLConnection			*connction;
	NSMutableData			*buffer;
	
	NSTimeInterval			timeout_interval;
}


@property (nonatomic, readonly) NSURLConnection *connction;
@property (nonatomic, readonly) NSMutableData *buffer;
@property (nonatomic, assign)	NSTimeInterval timeout_interval;


- (id) initWithURLRequest:(STURLRequest *)request;

- (void) load;

- (void) loadWithTimeInterval:(NSTimeInterval)time_interval;

- (void) cancel;


@end
