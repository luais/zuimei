//
//  BigPicTableViewCell.h
//  zuimei
//
//  Created by Aries on 15/11/6.
//  Copyright © 2015年 youke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BigPicTableViewCell : UITableViewCell
@property (nonatomic,strong)NSArray *imgArr;
+ (instancetype)bigPicCell:(UITableView *)tableView;
@property(nonatomic,strong)UIImageView *bigPic; //bigpic
@property(nonatomic,strong)UILabel *price; //价格

@end
