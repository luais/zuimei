//
//  ShopHeaderCollectionReusableView.m
//  zuimei
//
//  Created by Aries on 15/11/5.
//  Copyright © 2015年 youke. All rights reserved.
//

#import "ShopHeaderCollectionReusableView.h"

@implementation ShopHeaderCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //背景
        UIImageView *backGround = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10, KScreenWidth-10, 80)];
        backGround.image = [UIImage imageNamed:@"xzzm_Subject_cellTopBg"];
        [self addSubview:backGround];
        //店铺图标
        _photo = [[UIImageView alloc]initWithFrame:CGRectMake(40, backGround.top+20, 45, 45)];
        _photo.image = [UIImage imageNamed:@"yema18"];
        [self addSubview:_photo];
        //NAME
        _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(_photo.right+10, _photo.top, 200, 30)];
        _nameLab.font = [UIFont systemFontOfSize:15];
        _nameLab.text = @"好人没错 就是我";
        [self addSubview:_nameLab];
        
        
        
    }
    return self;
}

@end
