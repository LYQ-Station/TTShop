//
//  TSTransferContactNavController.h
//  TTShop
//
//  Created by Steven Li on 12/26/11.
//  Copyright (c) 2011 TTF Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSTransferContactNavController : UINavigationController
{
    id              delegate;
}

@property (nonatomic, assign) id delegate;

@end

@protocol TSTransferContactPickerDelegate <NSObject>

@optional
- (void) tsTransferContactPickerDidCancel:(TSTransferContactNavController *)aController;

- (void) tsTransferContactPickerDidSelect:(TSTransferContactNavController *)aController withPerson:(NSDictionary *)personInfo;

@end