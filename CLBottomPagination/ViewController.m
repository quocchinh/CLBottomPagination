//
//  ViewController.m
//  CLBottomPagination
//
//  Created by Chinh Le on 11/22/13.
//  Copyright (c) 2013 Chinh Le. All rights reserved.
//

#import "ViewController.h"
#import "CLBottomPagination.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet CLBottomPagination *bottomPagination;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	NSArray *pages = @[@"First", @"Second", @"Third", @"Fourth", @"Fifth"];
    [self.bottomPagination registerPages:pages withCircleSize:25 withSpaceBetweenCircles:5];
    [self.bottomPagination display];
}



@end
