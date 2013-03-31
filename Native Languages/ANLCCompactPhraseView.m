//
//  ANLCCompactPhraseView.m
//  Native Languages
//
//  Created by Rovolo on 3/31/13.
//  Copyright (c) 2013 Rovolo. All rights reserved.
//

#import "ANLCCompactPhraseView.h"


@implementation ANLCCompactPhraseView
@synthesize title,subtitle,section;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) setPhrase:(NSDictionary *)phrase {
	[title setText:phrase[@"native"][0]];
	[subtitle setText:phrase[@"english"][0]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
