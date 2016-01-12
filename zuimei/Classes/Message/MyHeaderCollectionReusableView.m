//
//  MyHeaderCollectionReusableView.m
//  zuimei
//
//  Created by Aries on 15/11/4.
//  Copyright © 2015年 youke. All rights reserved.
//

#import "MyHeaderCollectionReusableView.h"

@interface MyHeaderCollectionReusableView ()
//@property(nonatomic,retain) UILabel

@end

@implementation MyHeaderCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 10*KScreenWidth/320, 15*KScreenWidth/320)];
        img.image = [UIImage imageNamed:@"xzzm_ShopCategory_catTitleBgLeft"];
        [self addSubview:img];
        UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(img.right, 10, 30*KScreenWidth/320, 15*KScreenWidth/320)];
        //NSString *labelStr = [dataDic objectForKey:@"catname"];
        lbl.text = @"标签";
        lbl.textColor = [UIColor whiteColor];
        lbl.font = [UIFont systemFontOfSize:11];
        lbl.backgroundColor = [UIColor colorWithRed:229/255.0 green:0/255.0 blue:97/255.0 alpha:1.0];
        lbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lbl];
        self.textLabel = lbl;

        UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(lbl.right, 10, 10*KScreenWidth/320, 15*KScreenWidth/320)];
        img1.image = [UIImage imageNamed:@"xzzm_ShopCategory_catTitleBgRight"];
        [self addSubview:img1];
    }
    return self;
}

@end
