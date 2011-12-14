//
//  STURLLoader.m
//  TTShop
//
//  Created by zhangyj on 11-12-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "STURLLoader.h"


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

- (void)connection:(NSURLConnection *)aConn didReceiveData:(NSData *)data
{
	[buffer appendData:data];
}

- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
	
}

- (void)connection:(NSURLConnection *)aConn didFailWithError:(NSError *)error
{
	NSLog(@"%@", error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)aConn
{
	NSString *str = [[NSString alloc] initWithData:buffer encoding:NSUTF8StringEncoding];
	NSLog(@"%@", str);
}


@end
