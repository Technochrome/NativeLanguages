//
//  ANLCPhraseListController.m
//  Native Languages
//
//  Created by Rovolo on 2013-02-21.
//  Copyright (c) 2013 Rovolo. All rights reserved.
//

#import "ANLCPhraseCategoriesController.h"

@implementation ANLCPhraseCategoriesController

-(id) initWithPhrases: (NSArray*) p {
	if((self = [super init])) {
		phrases = p;
	}
	return self;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [phrases count];
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
	if(!cell)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
	
	[[cell textLabel] setText:phrases[indexPath.row]];
	return cell;
}
@end
