//
//  SwsStarView.m
//
//  Created by sws on 6/6/6.
//  Copyright © 666年 sws. All rights reserved.
//

#import "SwsStarView.h"

#define Width   self.bounds.size.width
#define Height  self.bounds.size.height

#define ImageOfFile(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

#define Animation_Duration 0.2

@interface SwsStarView ()

@property (nonatomic, strong) UIView *frontStarView;
@property (nonatomic, strong) UIView *backStarView;

@property (nonatomic, assign) NSInteger starNum;
@property (nonatomic, copy) NSString *defaultImageName;
@property (nonatomic, copy) NSString *selectedImageName;

@property (nonatomic, assign) BOOL isIntegral;
@property (nonatomic, assign) BOOL isAnimation;

@property (nonatomic, assign) BOOL isTouch;

@end

@implementation SwsStarView

- (SwsStarView *)initWithFrame:(CGRect)frame
                       starNum:(NSInteger)starNum
              defaultImageName:(NSString *)defaultImageName
             selectedImageName:(NSString *)selectedImageName
                      delegate:(id)delegate
                    isIntegral:(BOOL)isIntegral
                   isAnimation:(BOOL)isAnimation {
    self = [super initWithFrame:frame];
    if (self) {
        
        _starNum = starNum;
        _defaultImageName = defaultImageName;
        _selectedImageName = selectedImageName;
        _delegate = delegate;
        _isIntegral = isIntegral;
        _isAnimation = isAnimation;
        [self initUI];
    }
    return self;
}

#pragma mark - 初始化
- (void)initUI {
    
    self.backStarView = [self createStarViewWithImage:_defaultImageName];
    [self addSubview:self.backStarView];
    
    self.frontStarView = [self createStarViewWithImage:_selectedImageName];
    [self addSubview:self.frontStarView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchStarView:)];
    tapGesture.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGesture];
}

#pragma mark - 创建星星视图
- (UIView *)createStarViewWithImage:(NSString *)imageName {
    
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    
    for (NSInteger i = 0; i < self.starNum; i ++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:ImageOfFile(imageName)];
        imageView.frame = CGRectMake(i * Width / self.starNum, 0, Width / self.starNum, Height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.clipsToBounds = YES;
        [view addSubview:imageView];
    }
    return view;
}

#pragma mark - 点击事件
- (void)touchStarView:(UITapGestureRecognizer *)gesture {
    
    _isTouch = YES;
    CGPoint tapPoint = [gesture locationInView:self];
    CGFloat offset = tapPoint.x;
    CGFloat realStarScore = offset / (Width / self.starNum);
    CGFloat starScore = self.isIntegral ? ceilf(realStarScore) : realStarScore;
    self.scorePercent = starScore / self.starNum;
}

#pragma mark - SetScorePercent
- (void)setScorePercent:(CGFloat)scroePercent {
    
    if (scroePercent < 0) {
        
        _scorePercent = 0;
    } else if (scroePercent > 1) {
        
        _scorePercent = 1;
    } else {
        
        if (!_isTouch && !_isIntegral) {
            
            _scorePercent = floorf(scroePercent * 10) / 10;
        }
        _scorePercent = scroePercent;
    }
    
    if ([self.delegate respondsToSelector:@selector(returnSwsStarViewScore:starView:)]) {
        
        [self.delegate returnSwsStarViewScore: scroePercent * _starNum starView:self];
    }
    [self setNeedsLayout];
}

#pragma mark - Layout
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    __weak SwsStarView *view = self;
    CGFloat animationDurantionTime = self.isAnimation ? Animation_Duration : 0;
    
    if (0 == _scorePercent) {
        
        animationDurantionTime = 0;
    }
    
    [UIView animateWithDuration:animationDurantionTime animations:^{
            
        view.frontStarView.frame = CGRectMake(0, 0, view.bounds.size.width * view.scorePercent, view.bounds.size.height);
    }];
}

@end
