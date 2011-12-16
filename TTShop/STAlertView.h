//
//  STAlertView.h
//  TTShop
//
//  Created by Steven Li on 11-12-16.
//  Copyright (c) 2011年 TTF Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STAlertView : UIView

+ (void) showAtBottom:(NSString *)text;

+ (void) showModal:(NSString *)text;

+ (void) showModalWithLoading:(NSString *)text;

+ (void) close;

@end
