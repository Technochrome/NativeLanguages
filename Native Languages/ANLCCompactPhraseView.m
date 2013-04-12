//
//  ANLCCompactPhraseView.m
//  Native Languages
//
//  Created by Rovolo on 3/31/13.
//  Copyright (c) 2013 Rovolo. All rights reserved.
//

#import "ANLCCompactPhraseView.h"
#import <AVFoundation/AVAudioPlayer.h>

AVAudioPlayer * audioPlayer;

@implementation ANLCCompactPhraseView
@synthesize title,subtitle,section,delegate,audioID;

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
	self.audioID = phrase[@"ID"];
	
	if([phrase[@"native"] count] > 1) {
		[button setImage:[UIImage imageNamed:@"ExpandTriangle.png"] forState:UIControlStateNormal];
		[button addTarget:self action:@selector(expandSection) forControlEvents:UIControlEventTouchUpInside];
	} else {
		[button addTarget:self action:@selector(playAudio) forControlEvents:UIControlEventTouchUpInside];
	}
}

-(void) playAudio {
	NSError *error;
	NSURL *audioURL = [[NSBundle mainBundle] URLForResource:audioID withExtension:@"m4a" subdirectory:@"LanguageFiles/Audio"];
	NSData *audioData = [NSData dataWithContentsOfURL:audioURL];
	NSLog(@"%@ %d",audioPlayer, [audioPlayer isPlaying]);
	if([audioPlayer isPlaying]) {
		NSLog(@"stop");
		[audioPlayer stop];
	}
	audioPlayer = [[AVAudioPlayer alloc] initWithData:audioData error:&error];
	if(error) {
		NSLog(@"%@",error);
		return;
	}
	@try {
		[audioPlayer prepareToPlay];
		[audioPlayer play];
	} @catch (NSException *exception) {
		NSLog(@"%@",exception);
	}
}

-(void) closeSection {
	[button setImage:[UIImage imageNamed:@"ExpandTriangle.png"] forState:UIControlStateNormal];
}
-(void) expandSection {
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
