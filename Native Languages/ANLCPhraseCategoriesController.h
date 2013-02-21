//
//  ANLCPhraseListController.h
//  Native Languages
//
//  Created by Rovolo on 2013-02-21.
//  Copyright (c) 2013 Rovolo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANLCPhraseCategoriesController : UITableViewController {
	NSArray * phrases;
}

-(id) initWithPhrases: (NSArray*) phrases;
@end
