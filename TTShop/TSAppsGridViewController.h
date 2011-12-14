//
//  TSAppsGridViewController.h
//  TTShop
//
//  Created by Steven Li on 12/3/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSAppsGridViewController : UIViewController <UIScrollViewDelegate>
{
    UISegmentedControl          *sg_switch;
    NSMutableSet                *buttons;
	UIScrollView                *page_scrollview;
	UIPageControl               *page_control;
}

@property (nonatomic, retain) UISegmentedControl *sg_switch;

- (void) segmentedControlChange:(id)sender;

- (void) addButton:(UIButton *)btn;

- (void) btnGameCard:(id)sender;

@end
