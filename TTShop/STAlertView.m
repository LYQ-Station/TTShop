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

+ (void) showModalInView:(UIView *)view text:(NSString *)text
{
    if (_instance)
    {
        [_instance removeFromSuperview];
        _instance = nil;
    }
    
    CGSize view_size = view.bounds.size;
    
    UIView *v = [[UIView alloc] initWithFrame:view.frame];
    v.backgroundColor = [UIColor clearColor];
    
    UIView *v_bg = [[UIView alloc] initWithFrame:view.frame];
    v_bg.backgroundColor = [UIColor blackColor];
    v_bg.alpha = 0.0f;
    [v addSubview:v_bg];
    [v_bg release];
    
    UIView *v_box = [[UIView alloc] initWithFrame:CGRectMake((view_size.width - 160.0f) / 2,
                                                             (view_size.height - 80.0f) / 2,
                                                             160.0f,
                                                             80.0f)];
    v_box.backgroundColor = [UIColor blackColor];
    v_box.alpha = 0.7f;
    v_box.layer.cornerRadius = 15.0f;
    v_box.layer.masksToBounds = YES;
    [v addSubview:v_box];
    [v_box release];
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(v_box.frame.origin.x,
                                                            v_box.frame.origin.y + 15.0f,
                                                            160.0f,
                                                            50.0f)];
    lb.textAlignment = UITextAlignmentCenter;
    lb.numberOfLines = 0;
    lb.backgroundColor = [UIColor clearColor];
    lb.textColor = [UIColor whiteColor];
    lb.layer.shadowColor = [[UIColor blackColor] CGColor];
    lb.layer.shadowOpacity = 1.0f;
    lb.layer.shadowRadius = 0.0f;
    lb.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    lb.text = text;
    [v addSubview:lb];
    [lb release];
    
    [view addSubview:v];
    
    _instance = v;
}

+ (void) showModalWithLoadingInView:(UIView *)view text:(NSString *)text
{
    if (_instance)
    {
        [_instance removeFromSuperview];
        _instance = nil;
    }
    
    CGSize view_size = view.bounds.size;
    
    UIView *v = [[UIView alloc] initWithFrame:view.frame];
    v.backgroundColor = [UIColor clearColor];
    
    UIView *v_bg = [[UIView alloc] initWithFrame:view.frame];
    v_bg.backgroundColor = [UIColor blackColor];
    v_bg.alpha = 0.0f;
    [v addSubview:v_bg];
    [v_bg release];
    
    UIView *v_box = [[UIView alloc] initWithFrame:CGRectMake((view_size.width - 140.0f) / 2,
                                                             (view_size.height - 140.0f) / 2,
                                                             140.0f,
                                                             140.0f)];
    v_box.backgroundColor = [UIColor blackColor];
    v_box.alpha = 0.7f;
    v_box.layer.cornerRadius = 15.0f;
    v_box.layer.masksToBounds = YES;
    [v addSubview:v_box];
    [v_box release];
    
    UIActivityIndicatorView *av = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    av.frame = CGRectMake((view_size.width - 30.0f) / 2,
                          (view_size.height - 30.0f) / 2 - 20.0f,
                          30.0f,
                          30.0f);
    [av startAnimating];
    [v addSubview:av];
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(v_box.frame.origin.x,
                                                            v_box.frame.origin.y + v_box.frame.size.height - 60.0f,
                                                            140.0f,
                                                            50.0f)];
    lb.textAlignment = UITextAlignmentCenter;
    lb.numberOfLines = 0;
    lb.backgroundColor = [UIColor clearColor];
    lb.textColor = [UIColor whiteColor];
    lb.layer.shadowColor = [[UIColor blackColor] CGColor];
    lb.layer.shadowOpacity = 1.0f;
    lb.layer.shadowRadius = 0.0f;
    lb.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    lb.text = text;
    [v addSubview:lb];
    [lb release];
    
    [view addSubview:v];
    
    _instance = v;
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
