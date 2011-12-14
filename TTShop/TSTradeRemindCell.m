//
//  TSSysNoticeCell.m
//  TTShop
//
//  Created by Steven Li on 12/8/11.
//  Copyright (c) 2011 PlayStation. All rights reserved.
//

#import "TSTradeRemindCell.h"

@implementation TSTradeRemindCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setContent:(NSDictionary *)data
{
    self.textLabel.text = @"手机充值";;
    self.detailTextLabel.text = @"2011-12-02 16:20:30";
    
    UILabel *lb_value = [[UILabel alloc] initWithFrame:CGRectMake(320.0f-80.0f, 0.0f, 80.0f-10.0f, 20.0f)];
    lb_value.textAlignment = UITextAlignmentRight;
    lb_value.font = [UIFont systemFontOfSize:13.0f];
    lb_value.text = @"999.0元";
    [self addSubview:lb_value];
    [lb_value release];
    
    lb_value = [[UILabel alloc] initWithFrame:CGRectMake(320.0f-80.0f, 22.0f, 80.0f-10.0f, 20.0f)];
    lb_value.textAlignment = UITextAlignmentRight;
    lb_value.font = [UIFont systemFontOfSize:13.0f];
    lb_value.textColor = [UIColor darkGrayColor];
    lb_value.text = @"交易成功";
    [self addSubview:lb_value];
    [lb_value release];
}

@end
