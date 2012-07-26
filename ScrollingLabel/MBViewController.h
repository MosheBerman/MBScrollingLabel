//
//  MBViewController.h
//  ScrollingLabel
//
//  Created by Moshe Berman on 7/19/12.
//  Copyright (c) 2012 Moshe Berman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBScrollingLabel.h"

@interface MBViewController : UIViewController
@property (weak, nonatomic) IBOutlet MBScrollingLabel *visuallyCreatedLabel;
@property (weak, nonatomic) IBOutlet MBScrollingLabel *visualVerticallyScrollingLabel;



@end
