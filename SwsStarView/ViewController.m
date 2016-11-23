//
//  ViewController.m
//
//  Created by sws on 6/6/6.
//  Copyright © 666年 sws. All rights reserved.
//

#import "ViewController.h"
#import "SwsStarView.h"

@interface ViewController () <SwsStarViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UIView *view1;

@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UIView *view2;

@property (nonatomic, strong) SwsStarView *starView1;
@property (nonatomic, strong) SwsStarView *starView2;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [_view1 layoutIfNeeded];
    _starView1 = [[SwsStarView alloc] initWithFrame:_view1.bounds starNum:5 defaultImageName:@"star_default.png" selectedImageName:@"star_red.png" delegate:self isIntegral:YES isAnimation:YES];
//    _starView1.scorePercent = 0;
    [_view1 addSubview:_starView1];
    
    [_view2 layoutIfNeeded];
    _starView2 = [[SwsStarView alloc] initWithFrame:_view2.bounds starNum:10 defaultImageName:@"star_default.png" selectedImageName:@"star_blue.png" delegate:self isIntegral:NO isAnimation:NO];
    _starView2.scorePercent = 0.35;
//    _starView2.userInteractionEnabled = NO;
    [_view2 addSubview:_starView2];
}

#pragma mark - SwsStarViewDelegate
- (void)returnSwsStarViewScore:(CGFloat)score starView:(SwsStarView *)starView {
    
    if (starView == _starView1) {
        
        _label1.text = [NSString stringWithFormat:@"%.2f", score];
    } else {
        
        _label2.text = [NSString stringWithFormat:@"%.2f", score];
    }
}

@end
