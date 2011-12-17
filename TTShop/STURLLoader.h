//
//  STURLLoader.h
//  TTShop
//
//  Created by Steven Li on 12/1/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STEventDispatcher.h"
#import "STURLRequest.h"


#define STLOADER_STATUS_CHANGE		@"STLOADER_STATUS_CHANGE"
#define STLOADER_FAIL				@"STLOADER_FAIL"
#define STLOADER_COMPLETE			@"STLOADER_COMPLETE"
#define STLOADER_SEND_COMPLETE      @"STLOADER_SEND_COMPLETE"

typedef struct _st_bind_connection
{
	id		loader;
	id		obj;
} STBindConnection;

@interface STURLLoader : STEventDispatcher
{
	NSURLConnection			*connction;
	NSMutableData			*buffer;
	
	NSTimeInterval			timeout_interval;
}

@property (nonatomic, readonly) NSURLConnection *connction;
@property (nonatomic, readonly) NSMutableData *buffer;
@property (nonatomic, assign)	NSTimeInterval timeout_interval;

+ (void) bindLoader:(id)loader withDelegate:(id)delegate;

+ (void) releaseBindedLoaderForDelegate:(id)delegate;

- (id) initWithURLRequest:(STURLRequest *)request;

- (void) load;

- (void) loadWithTimeInterval:(NSTimeInterval)time_interval;

- (void) cancel;

- (NSString *) getStringData;

- (id) getJSONData;

@end
