//
//  TSHistoryPhoneController.h
//  TTShop
//
//  Created by Steven Li on 12/13/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSHistoryPhoneController : UITableViewController
{
    id                      delegate;
    
    NSMutableArray          *buffer;
}

@property (nonatomic, readonly) NSMutableArray *buffer;
@property (nonatomic, assign) id delegate;

- (void) loadDataFromCache;

- (void) saveDataToCache;

- (void) addAPhoneNO:(NSString *)phoneNO contact:(NSString *)name;

@end

@protocol TSHistoryPhoneDelegate <NSObject>

- (void) tsHistoryPhoneController:(TSHistoryPhoneController *)controller didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
