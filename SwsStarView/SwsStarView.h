//
//  SwsStarView.h
//
//  Created by sws on 6/6/6.
//  Copyright © 666年 sws. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SwsStarView;

@protocol SwsStarViewDelegate <NSObject>

@optional

/** 返回分数*/
- (void)returnSwsStarViewScore:(CGFloat)score starView:(SwsStarView *)starView;

@end

@interface SwsStarView : UIView

@property (nonatomic, weak) id <SwsStarViewDelegate> delegate;

@property (nonatomic, assign) CGFloat scorePercent; // 0 ～ 1;

/** SwsStarView */
- (SwsStarView *)initWithFrame:(CGRect)frame
                       starNum:(NSInteger)starNum
              defaultImageName:(NSString *)defaultImageName
             selectedImageName:(NSString *)selectedImageName
                      delegate:(id)delegate
                    isIntegral:(BOOL)isIntegral
                   isAnimation:(BOOL)isAnimation;
@end
