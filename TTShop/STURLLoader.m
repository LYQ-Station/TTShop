//
//  STURLLoader.m
//  TTShop
//
//  Created by Steven Li on 12/1/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import "STURLLoader.h"
#import "JSON.h"


static NSMutableSet			*bind_loaders = nil;

@implementation STURLLoader

@synthesize connction;
@synthesize buffer;
@synthesize timeout_interval;

#pragma mark -

+ (void) bindLoader:(id)loader withDelegate:(id)delegate
{
    [loader retain];
    
	STBindConnection *bc = (STBindConnection *)malloc(sizeof(STBindConnection));
	bc->loader = loader;
	bc->obj = delegate;
	
	NSValue *val = [NSValue valueWithPointer:bc];
	
	if (nil == bind_loaders)
	{
		bind_loaders = [[NSMutableSet alloc] init];
	}
	
	[bind_loaders addObject:val];
}

+ (void) releaseBindedLoaderForDelegate:(id)delegate
{
	STURLLoader *ld = nil;
	NSEnumerator *enumerator = [bind_loaders objectEnumerator];
	STBindConnection *bc = NULL;
	NSValue *val = nil;
	
	while ((val = (NSValue *)[enumerator nextObject]))
	{
		bc = [val pointerValue];
		if (delegate == bc->obj)
		{
			ld = (STURLLoader *)bc->loader;
			[ld cancel];
			
			[bind_loaders removeObject:val];
			free(bc);
			
			[ld release];
			
			break;
		}
	}
}

#pragma mark -

- (id) initWithURLRequest:(STURLRequest *)request
{
	self = [super init];
	
	if (self)
	{
		buffer = [[NSMutableData alloc] init];
		[request setupHTTPBody];
		connction = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
		[connction start];
	}
	
	return self;
}

- (void) dealloc
{
	[buffer release];
	//[connction release];
	
	[super dealloc];
}

#pragma mark -

- (void) load
{
	//NSLog(@"%@", connction);
	//[connction start];
}

- (void) loadWithTimeInterval:(NSTimeInterval)time_interval
{
	
}

- (void) cancel
{
	[connction cancel];
}

#pragma mark -

- (NSString *) getStringData
{
    return [[[NSString alloc] initWithData:buffer encoding:NSUTF8StringEncoding] autorelease];
}

- (id) getJSONData
{
    NSString *s = [[[NSString alloc] initWithData:buffer encoding:NSUTF8StringEncoding] autorelease];
	return [s JSONValue];
}

#pragma mark -

- (void)connection:(NSURLConnection *)aConn didReceiveData:(NSData *)data
{
	[buffer appendData:data];
}

- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
	[self dispatchEvent:STLOADER_SEND_COMPLETE];
}

- (void)connection:(NSURLConnection *)aConn didFailWithError:(NSError *)error
{
    [self dispatchEvent:STLOADER_FAIL];
//	NSLog(@"%@", error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)aConn
{
    [self dispatchEvent:STLOADER_COMPLETE];
//	NSString *str = [[NSString alloc] initWithData:buffer encoding:NSUTF8StringEncoding];
//	NSLog(@"%@", str);
}


@end
