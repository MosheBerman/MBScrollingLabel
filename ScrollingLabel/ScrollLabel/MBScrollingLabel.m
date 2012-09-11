//
//  MBScrollLabel.m
//  ScrollingLabel
//
//  Created by Moshe Berman on 7/19/12.
//  Copyright (c) 2012 Moshe Berman. All rights reserved.
//

#import "MBScrollingLabel.h"

@interface MBScrollingLabel ()
@property (strong, nonatomic) UILabel *innerLabel;
@property (assign) BOOL isAnimating;
@end

@implementation MBScrollingLabel

@synthesize innerLabel = _innerLabel;

/*
 
 Implementing awakeFromNib allows us to
 use MBScrollingLabel with IB. Simply,
 any property that we want to apply to
 the inner label should have a custom
 setter as well as a line here that looks
 like this:
 
 self.{property} = super.{property};
 
 Then, implement the setter which will
 take appropriate action on the inner
 and outer labels.
 
 */

- (void)awakeFromNib{
    self.text = super.text;
    self.textColor = super.textColor;
    self.innerLabel.textAlignment = super.textAlignment;
    _isAnimating = NO;
    _shouldRepeat = NO;
}

- (void)drawRect:(CGRect)rect{
    [self addSubview:self.innerLabel];
}

#pragma mark - Create an inner label
- (UILabel *)innerLabel{
    
    if (!_innerLabel) {
        CGRect frame = self.frame;
        frame.origin.x = 0;
        frame.origin.y = 0;
        _innerLabel = [[UILabel alloc] initWithFrame:frame];
        _innerLabel.opaque = YES;
        _innerLabel.backgroundColor = [UIColor clearColor];
    }
    
    return _innerLabel;
}

-(void)setInnerLabel:(UILabel *)innerLabel{
    _innerLabel = innerLabel;
}

#pragma mark - Text & Color

- (void)setText:(NSString *)text{
    super.text = text;
    self.innerLabel.text = text;
    [self.innerLabel sizeToFit];
    
    /*
     
     For a proper scrolling effect,
     we must ensure that the inner
     label isn't smaller than the
     outer one.
     
     */
    
    if (self.innerLabel.frame.size.width < self.frame.size.width) {
        
        CGRect frame = self.innerLabel.frame;
        frame.size.width = self.frame.size.width;
        
        self.innerLabel.frame = frame;
    }
    
}

- (void)setTextColor:(UIColor *)textColor{
    super.textColor = textColor;
    self.innerLabel.textColor = textColor;
}

#pragma mark - Scroll Methods

//
//  TODO: Support different scroll directions
//          keeping different rtl and top-down
//          writing systems in mind
//

- (void)scrollHorizontallyAtSpeed:(NSTimeInterval)duration{
    
    if ([self isAnimating]) {
        return;
    }
    
    CGRect selfFrame = [self frame];
    CGRect innerFrame = [[self innerLabel] frame];
    
    CGFloat start = selfFrame.size.width;
    CGFloat middle = [self center].x;
    CGFloat end = -innerFrame.size.width;

    innerFrame.origin.x = start;
    [[self innerLabel] setFrame:innerFrame];
    
    [self setIsAnimating:YES];
    
    CGFloat durationPerPart = duration/11;
    CGFloat inOutDuration = durationPerPart * 5;
    CGFloat pauseDuration = durationPerPart * 1;
    
    [UIView animateWithDuration:inOutDuration
                          delay:0.0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         CGPoint center = [self innerLabel].center;
                         center.x = middle;
                         [[self innerLabel] setCenter:center];
                     }
    
     
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:inOutDuration
                                               delay:pauseDuration
                                             options: UIViewAnimationCurveEaseIn
                                          animations:^{
                                              CGRect newFrame = innerFrame;
                                              newFrame.origin.x = end;
                                              [[self innerLabel] setFrame:newFrame];
                                          }
                                          completion:^(BOOL finished) {
                                              CGRect newFrame = innerFrame;
                                              newFrame.origin.x = start;
                                              [[self innerLabel] setFrame:newFrame];
                                              
                                              [self setIsAnimating:NO];
                                              
                                              if ([self shouldRepeat]) {
                                                  [self scrollHorizontallyAtSpeed:duration];
                                              }
                                          }];
                     }];
}


- (void)scrollVerticallyAtSpeed:(NSTimeInterval)duration{
    
    if ([self isAnimating]) {
        return;
    }
    
    CGRect selfFrame = [self frame];
    CGRect innerFrame = [[self innerLabel] frame];
    
    CGFloat start = selfFrame.size.height;
    CGFloat middle = [self center].y;
    CGFloat end = -innerFrame.size.height;
    
    innerFrame.origin.y = start;
    [[self innerLabel] setFrame:innerFrame];
    
    [self setIsAnimating:YES];
    
    [UIView animateWithDuration:duration/2
                          delay:0.0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         CGPoint center = [self innerLabel].center;
                         center.y = middle;
                         [[self innerLabel] setCenter:center];
                     }
     
     
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:duration/2
                                               delay:0.0
                                             options: UIViewAnimationCurveEaseIn
                                          animations:^{
                                              CGRect newFrame = innerFrame;
                                              newFrame.origin.y = end;
                                              [[self innerLabel] setFrame:newFrame];
                                          }
                                          completion:^(BOOL finished) {
                                              CGRect newFrame = innerFrame;
                                              newFrame.origin.y = start;
                                              [[self innerLabel] setFrame:newFrame];
                                              
                                              [self setIsAnimating:NO];
                                              
                                              if ([self shouldRepeat]) {
                                                  [self scrollVerticallyAtSpeed:duration];
                                              }
                                          }];
                     }];

}


@end
