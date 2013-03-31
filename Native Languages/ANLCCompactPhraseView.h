//
//  ANLCCompactPhraseView.h
//  Native Languages
//
//  Created by Rovolo on 3/31/13.
//  Copyright (c) 2013 Rovolo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANLCCompactPhraseView : UIView {
	IBOutlet UILabel * title, *subtitle;
}
@property (readonly) UILabel *title, *subtitle;
@property (readwrite) NSInteger section;

-(void) setPhrase:(NSDictionary *) phrase;

@end
