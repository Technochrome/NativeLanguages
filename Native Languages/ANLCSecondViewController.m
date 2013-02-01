//
//  ANLCSecondViewController.m
//  Native Languages
//
//  Created by Rovolo on 2013-01-31.
//  Copyright (c) 2013 Rovolo. All rights reserved.
//

#import "ANLCSecondViewController.h"

@interface ANLCSecondViewController ()

@end

@implementation ANLCSecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = NSLocalizedString(@"Second", @"Second");
		self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
