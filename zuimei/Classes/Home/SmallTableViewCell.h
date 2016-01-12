//
//  SmallTableViewCell.h
//  zuimei
//
//  Created by Aries on 15/11/6.
//  Copyright © 2015年 youke. All rights reserved.
//
typedef void(^block)(void);
#import <UIKit/UIKit.h>

@interface SmallTableViewCell : UITableViewCell
@property(nonatomic,strong)UIButton *pictureB;//xiao图片
@property(nonatomic,strong)UIButton *pictureS; //xiaotu

@property(nonatomic,strong)UILabel *price; //价格
@property(nonatomic,strong)UILabel *price1; //价格

@property(nonatomic,strong)NSArray *imgArr;
@property (nonatomic,copy)block blockb;
@property (nonatomic,copy)block blocks;
-(void)clickbofBlock:(block)newblock;
-(void)clicksofBlock:(block)newblock;
+(instancetype)smallCell:(UITableView *)tableView;

@end
