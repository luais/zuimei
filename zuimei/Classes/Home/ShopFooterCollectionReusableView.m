//
//  ShopFooterCollectionReusableView.m
//  zuimei
//
//  Created by Aries on 15/11/5.
//  Copyright © 2015年 youke. All rights reserved.
//

#import "ShopFooterCollectionReusableView.h"

@implementation ShopFooterCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _buyBtn.frame = CGRectMake((KScreenWidth/2)-56, 10, 112, 25);
        [_buyBtn setImage:[UIImage imageNamed:@"xzzm_Subject_more"] forState:UIControlStateNormal];
        [self addSubview:_buyBtn];
    }
    return self;
}

@end
