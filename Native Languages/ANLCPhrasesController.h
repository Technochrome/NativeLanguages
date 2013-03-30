//
//  ANLCPhrasesController.h
//  Native Languages
//
//  Created by Rovolo on 2/22/13.
//  Copyright (c) 2013 Rovolo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANLCPhrasesController : UITableViewController {
	NSArray * phrases;
}
-(id) initWithPhrases:(NSArray*) p;
@end
