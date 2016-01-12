//
//  MyCollectionViewCell.m
//  zuimei
//
//  Created by Aries on 15/11/4.
//  Copyright © 2015年 youke. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _picture = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 90, 70)];
        _picture.image = [UIImage imageNamed:@"yema18"];
        [self.contentView addSubview:_picture];
        
        _catName = [[UILabel alloc]initWithFrame:CGRectMake(10, _picture.bottom+5, 90, 10)];
        _catName.text = @"软妹";
        _catName.font = [UIFont systemFontOfSize:11];
        _catName.textColor = [UIColor orangeColor];
        _catName.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_catName];
    }
    return self;
}

@end
