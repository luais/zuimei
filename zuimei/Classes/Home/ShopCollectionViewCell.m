//
//  ShopCollectionViewCell.m
//  zuimei
//
//  Created by Aries on 15/11/5.
//  Copyright © 2015年 youke. All rights reserved.
//

#import "ShopCollectionViewCell.h"

@implementation ShopCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _pictureB = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10,(KScreenWidth-20)/2, self.width)];
        _pictureB.image = [UIImage imageNamed:@"yema18"];
        [self.contentView addSubview:_pictureB];
        
//        _pictureS = [[UIImageView alloc]initWithFrame:CGRectMake(_pictureB.left, _pictureB.bottom+5, KScreenWidth-10, self.width)];
//        _pictureS.image = [UIImage imageNamed:@"LaunchImage-700"];
//        [self.contentView addSubview:_pictureS];
        
        //价格
        _price = [[UILabel alloc]initWithFrame:CGRectMake(_pictureB.right-55, _pictureB.bottom-20, 50, 15)];
        _price.text = @"$100";
        _price.font = [UIFont systemFontOfSize:9];
        _price.textAlignment = NSTextAlignmentCenter;
        _price.backgroundColor = [UIColor orangeColor];
        _price.layer.cornerRadius = 9;
        _price.layer.masksToBounds =  YES;
        [self.contentView addSubview:_price];
        
        
    }
    
    
    return self;
}

@end
