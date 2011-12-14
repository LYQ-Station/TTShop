//
//  STURLRequest.h
//  TTShop
//
//  Created by zhangyj on 11-12-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface STURLRequest : NSMutableURLRequest
{
	NSMutableDictionary			*form_fields;
	NSMutableDictionary			*form_datas;
}


@property (nonatomic, readonly) NSMutableDictionary *form_fields;
@property (nonatomic, readonly) NSMutableDictionary *form_datas;


- (id) initWithURLString:(NSString *)url;

- (void) setFormValue:(NSString *)value forField:(NSString *)field;

- (void) unsetFormValueForField:(NSString *)field;

- (void) clearFormFields;

- (void) setFormData:(NSData *)data forField:(NSString *)field;

- (void) unsetFormData:(NSString *)field;

- (void) clearFormDatas;

- (void) setupHTTPBody;


@end
