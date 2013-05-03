//
//  ANLCFirstViewController.h
//  Native Languages
//
//  Created by Rovolo on 2013-01-31.
//  Copyright (c) 2013 Rovolo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANLCLanguagesController : UITableViewController {
	NSArray *categories;
	NSArray * languages;
}
+(id) shared;
@end
