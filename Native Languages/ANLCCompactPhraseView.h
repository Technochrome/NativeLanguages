//
//  ANLCCompactPhraseView.h
//  Native Languages
//
//  Created by Rovolo on 3/31/13.
//  Copyright (c) 2013 Rovolo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ANLCCompactPhraseView,AVAudioPlayer;

@protocol ANLCCompactPhraseViewDelegate <NSObject>
-(void) expandSection:(ANLCCompactPhraseView*) phraseView;
@end


@interface ANLCCompactPhraseView : UIView {
	IBOutlet UILabel * title, *subtitle;
	IBOutlet UIButton * button;
	__weak id<ANLCCompactPhraseViewDelegate> delegate;
	BOOL isDownloading;
}
@property (readonly) UILabel *title, *subtitle;
@property (readwrite) NSInteger section;
@property (readwrite) NSString * audioID;
@property (readwrite, weak) id<ANLCCompactPhraseViewDelegate> delegate;

-(void) setPhrase:(NSDictionary *) phrase;
-(void) closeSection;
@end
