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
    
    //
    //  Jump to the offscreen position
    //
    
    CGRect frame = self.innerLabel.frame;
    frame.origin.x = frame.size.width;
    self.innerLabel.frame = frame;
    
    //
    //  animate
    //
    
    [UIView animateWithDuration:duration delay:0.0 options: UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionRepeat animations:^{
        
        //  This assumes left to right text
        //  and scrolling from right to left.
        
        CGRect frame = self.innerLabel.frame;
        frame.origin.x = -self.innerLabel.frame.size.width;
        self.innerLabel.frame = frame;
        
    } completion:^(BOOL finished) {
        
    }];
}


- (void)scrollVerticallyAtSpeed:(NSTimeInterval)duration{
    
    //
    //  Jump to the offscreen position
    //
    
    CGRect frame = self.innerLabel.frame;
    frame.origin.y = frame.size.height;
    self.innerLabel.frame = frame;
    
    //
    //  animate
    //
    
    [UIView animateWithDuration:duration delay:0.0 options: UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionRepeat animations:^{
        
        //  This assumes left to right text
        //  and scrolling from top to bottom.
        
        CGRect frame = self.innerLabel.frame;
        frame.origin.y = -self.innerLabel.frame.size.height;
        self.innerLabel.frame = frame;
        
    } completion:^(BOOL finished) {
        
    }];
}

 
@end
