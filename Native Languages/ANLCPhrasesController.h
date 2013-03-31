//
//  ANLCPhrasesController.h
//  Native Languages
//
//  Created by Rovolo on 2/22/13.
//  Copyright (c) 2013 Rovolo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ANLCCompactPhraseView;

@interface ANLCPhrasesController : UITableViewController {
	NSArray * phrases;
	IBOutlet ANLCCompactPhraseView * phraseView;
}
-(id) initWithPhrases:(NSArray*) p;
@end
