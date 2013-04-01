//
//  ANLCPhrasesController.h
//  Native Languages
//
//  Created by Rovolo on 2/22/13.
//  Copyright (c) 2013 Rovolo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANLCCompactPhraseView.h"

@interface ANLCPhrasesController : UITableViewController <ANLCCompactPhraseViewDelegate> {
	NSArray * phrases;
	IBOutlet ANLCCompactPhraseView * phraseView;
	
	ANLCCompactPhraseView * openSection;
}
-(id) initWithPhrases:(NSArray*) p;
@end
