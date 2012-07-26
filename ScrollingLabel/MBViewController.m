//
//  MBViewController.m
//  ScrollingLabel
//
//  Created by Moshe Berman on 7/19/12.
//  Copyright (c) 2012 Moshe Berman. All rights reserved.
//

#import "MBViewController.h"

@interface MBViewController ()
@property (nonatomic,strong) MBScrollingLabel *label;
@end

@implementation MBViewController
@synthesize visuallyCreatedLabel;
@synthesize visualVerticallyScrollingLabel;

@synthesize label;

- (void)viewDidLoad
{
    [super viewDidLoad];

    //
    //  Create a scrolling label
    //
    
    MBScrollingLabel *l = [[MBScrollingLabel alloc] initWithFrame:CGRectMake(0, 51, self.view.frame.size.width, 21)];
    l.text = @"This is a scrolling label object made with code.";
    self.label = l;
    
    //
    //  Display the scrolling label
    //
    
    [self.view addSubview:l];
}

- (IBAction)scrollLabels:(id)sender {
        [label scrollHorizontallyAtSpeed:8.0];
        [self.visuallyCreatedLabel scrollHorizontallyAtSpeed:10.0];
    [self.visualVerticallyScrollingLabel scrollVerticallyAtSpeed:3.0];
}

- (void)viewDidUnload
{
    [self setVisuallyCreatedLabel:nil];
    [self setVisualVerticallyScrollingLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
