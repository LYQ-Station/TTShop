//
//  STAlertView.m
//  TTShop
//
//  Created by Steven Li on 11-12-16.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "STAlertView.h"


static UIView *_instance;

@implementation STAlertView

+ (void) showAtBottom:(NSString *)text
{
    static NSTimer *_timer;
    if (_timer)
    {
        [_timer invalidate];
        _timer = nil;
    }
    
    if (_instance)
    {
        [_instance removeFromSuperview];
        _instance = nil;
    }
    
    CGRect src_bounds = [UIScreen mainScreen].bounds;
    
    UIFont *fnt = [UIFont systemFontOfSize:13.5f];
	CGSize text_frm_size = [text sizeWithFont:fnt
							constrainedToSize:CGSizeMake(210.0f, 50.0f)
								lineBreakMode:UILineBreakModeWordWrap];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(src_bounds.origin.x + (src_bounds.size.width-220.0f) * 0.5f,
                                                      src_bounds.origin.y + (src_bounds.size.height - 44.0f - text_frm_size.height - 18.0f - 10.0f),
                                                      220.0f,
                                                      text_frm_size.height + 18.0f)];
    
    label.layer.cornerRadius = 5.0f;
	label.backgroundColor = [UIColor blackColor];
	label.alpha = 0.8f;
	label.numberOfLines = 0;
	label.font = [UIFont systemFontOfSize:13.5f];
	label.textColor = [UIColor whiteColor];
	label.textAlignment = UITextAlignmentCenter;
	label.text = text;
    
    UIWindow *w = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
	[w addSubview:label];
    [label release];
    
    _instance = label;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.5f
                                              target:[STAlertView class]
                                            selector:@selector(close)
                                            userInfo:nil
                                             repeats:NO];
}

+ (void) showModal:(NSString *)text
{
    
}

+ (void) showModalWithLoading:(NSString *)text
{
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }
    return self;
}

+ (void) close
{
    [_instance removeFromSuperview];
    _instance = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
