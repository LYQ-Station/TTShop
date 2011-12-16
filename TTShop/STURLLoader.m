//
//  STURLLoader.m
//  TTShop
//
//  Created by Steven Li on 12/1/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import "STURLLoader.h"
#import "JSON.h"


@implementation STURLLoader

@synthesize connction;
@synthesize buffer;
@synthesize timeout_interval;


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
