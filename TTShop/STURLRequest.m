//
//  STURLRequest.m
//  TTShop
//
//  Created by Steven Li on 12/1/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import "STURLRequest.h"


@implementation STURLRequest

@synthesize form_fields;
@synthesize form_datas;


#pragma mark -

- (id) initWithURLString:(NSString *)url
{
	NSString *f_url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSURL *URL = [NSURL URLWithString:f_url];
	
	self = [super initWithURL:URL];
	
	return self;
}


#pragma mark -

- (void) setFormValue:(NSString *)value forField:(NSString *)field
{
	if (nil == form_fields)
	{
		form_fields = [[NSMutableDictionary alloc] init];
	}
	
	[form_fields setObject:value forKey:field];
}

- (void) unsetFormValueForField:(NSString *)field
{
	[form_fields removeObjectForKey:field];
}

- (void) clearFormFields
{
	[form_fields removeAllObjects];
}

#pragma mark -

- (void) setFormData:(NSData *)data forField:(NSString *)field
{
	if (nil == form_datas)
	{
		form_datas = [[NSMutableDictionary alloc] init];
	}
	
	[form_datas setObject:data forKey:field];
}

- (void) unsetFormData:(NSString *)field
{
	[form_datas removeObjectForKey:field];
}

- (void) clearFormDatas
{
	[form_datas removeAllObjects];
}

#pragma mark -

- (void) setupHTTPBody
{
	if (0 < [form_datas count] || [@"POST" isEqualToString:[self HTTPMethod]])
	{
		[self setHTTPMethod:@"POST"];
		[self setValue:@"multipart/form-data; boundary=0xKhTmLbOuNdArY" forHTTPHeaderField:@"Content-Type"];
		
		NSMutableData *post_data = [[NSMutableData alloc] init];
		
		for (id p in form_fields)
		{
			[post_data appendData:[@"--0xKhTmLbOuNdArY\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
			[post_data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", p] dataUsingEncoding:NSUTF8StringEncoding]];
			NSString *d = [NSString stringWithFormat:@"%@", [form_fields objectForKey:p]];
			[post_data appendData:[d dataUsingEncoding:NSUTF8StringEncoding]];
			[post_data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
		}
		
		for (id p in form_datas)
		{
			[post_data appendData:[@"--0xKhTmLbOuNdArY\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
			[post_data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n\r\n", p, p] dataUsingEncoding:NSUTF8StringEncoding]];
			[post_data appendData:[form_datas objectForKey:p]];
			
		}
		[post_data appendData:[@"\r\n--0xKhTmLbOuNdArY--\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
		
		[self setHTTPBody:post_data];
		[post_data release];
	}
	else
	{
		NSMutableString *str = [[NSMutableString alloc] init];
		
		for (id p in form_fields)
		{
			[str appendFormat:@"&%@=%@", p, [form_fields objectForKey:p]];
		}
		
		NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
		
		[self setHTTPBody:data];
		
		[str release];
	}
}


@end
