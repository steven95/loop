//
//  button.m
//  转盘
//
//  Created by Jusive on 15/11/29.
//  Copyright © 2015年 Jusive. All rights reserved.
//

#import "Button.h"

@implementation Button

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = 40;
    CGFloat imageH = 47;
    CGFloat imageX = (contentRect.size.width - imageW) * 0.5;
    CGFloat imageY = 20;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

@end
