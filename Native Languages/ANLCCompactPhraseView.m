//
//  ANLCCompactPhraseView.m
//  Native Languages
//
//  Created by Rovolo on 3/31/13.
//  Copyright (c) 2013 Rovolo. All rights reserved.
//

#import "ANLCCompactPhraseView.h"

@implementation ANLCCompactPhraseView
@synthesize title,subtitle,section,delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) setPhrase:(NSDictionary *)phrase  {
	[title setText:phrase[@"native"][0]];
	[subtitle setText:phrase[@"english"][0]];
	
	if([phrase[@"native"] count] > 1) {
		[button setImage:[UIImage imageNamed:@"ExpandTriangle.png"] forState:UIControlStateNormal];
		[button addTarget:self action:@selector(expandSection) forControlEvents:UIControlEventTouchUpInside];
	} else {
		[button addTarget:self action:@selector(playAudio) forControlEvents:UIControlEventTouchUpInside];
	}
}

-(void) playAudio {
	NSLog(@"play audio");
}

-(void) closeSection {
	[button setImage:[UIImage imageNamed:@"ExpandTriangle.png"] forState:UIControlStateNormal];
}
-(void) expandSection {
	NSLog(@"expand");
	[button setImage:[UIImage imageNamed:@"Loudspeaker.png"] forState:UIControlStateNormal];
	if(delegate) [delegate expandSection:self];
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
