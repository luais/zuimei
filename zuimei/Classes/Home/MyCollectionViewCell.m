//
//  MyCollectionViewCell.m
//  zuimei
//
//  Created by Aries on 15/11/2.
//  Copyright © 2015年 youke. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        _img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth/2-30, 100*KScreenWidth/320)];
        _img.image = [UIImage imageNamed:@"yema18"];
        _img.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_img];
        
//        self.img = _img;
        
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 80*KScreenWidth/320, KScreenWidth/2-30, 20*KScreenWidth/320)];
        _textLabel.text = @"软妹";
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont systemFontOfSize:16];
        _textLabel.backgroundColor = [UIColor clearColor];
        [self.img addSubview:_textLabel];

       
    }
    return self;
    
}

@end
