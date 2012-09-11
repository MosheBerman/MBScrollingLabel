//
//  MBScrollLabel.h
//  ScrollingLabel
//
//  Created by Moshe Berman on 7/19/12.
//  Copyright (c) 2012 Moshe Berman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBScrollingLabel : UILabel

@property (nonatomic) BOOL shouldRepeat;

//
//  The speed value gets passed directly to the UIView animation
//

- (void)scrollHorizontallyAtSpeed:(NSTimeInterval)duration;
- (void)scrollVerticallyAtSpeed:(NSTimeInterval)duration;

@end
