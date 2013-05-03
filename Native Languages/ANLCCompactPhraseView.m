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

NSURL* audioServerURL=nil;

@implementation ANLCCompactPhraseView
@synthesize title,subtitle,section,delegate,audioID;

+(void) initialize {
	audioServerURL = [NSURL URLWithString:@"http://rovrcomp.local/audio/"];
}

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

-(void) getAudio:(NSArray*)obj {
	isDownloading = YES;
	NSData * audioData = [NSData dataWithContentsOfURL:obj[0]];
	[audioData writeToFile:obj[1] atomically:YES];
	isDownloading = NO;
	if(audioData) {
		[self performSelector:@selector(playAudio)
					 onThread:[NSThread mainThread]
				   withObject:nil
				waitUntilDone:NO];
	} else {
		UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error Downloading"
														 message:@"The audio file could not be accessed."
														delegate:nil
											   cancelButtonTitle:@"Okay"
											   otherButtonTitles: nil];
		[alert performSelector:@selector(show)
					  onThread:[NSThread mainThread]
					withObject:nil
				 waitUntilDone:YES];
	}
}

-(void) playAudio {
	if(isDownloading) return;
	NSError *error;
	NSData *audioData;
	
	NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
	NSString *audioDocPath = [documentsPath stringByAppendingFormat:@"/audio%@.m4a",audioID];
	
	if(![[NSFileManager defaultManager] fileExistsAtPath:audioDocPath]) {
		NSURL *audioURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@.m4a",audioID] relativeToURL:audioServerURL];
		[NSThread detachNewThreadSelector:@selector(getAudio:) toTarget:self withObject:@[audioURL,audioDocPath]];
		return;
	} else {
		audioData = [NSData dataWithContentsOfFile:audioDocPath];
	}
	
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
