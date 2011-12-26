//
//  TSTransferContactController.h
//  TTShop
//
//  Created by Steven Li on 12/26/11.
//  Copyright (c) 2011 TTF Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSTransferContactController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>
{
    id                      delegate;
}

@property (nonatomic, assign) id delegate;

- (void) btnCancelClick:(id)sender;

- (void) btnAddClick:(id)sender;

@end
