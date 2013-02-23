//
//  ANLCPhrasesController.m
//  Native Languages
//
//  Created by Rovolo on 2/22/13.
//  Copyright (c) 2013 Rovolo. All rights reserved.
//

#import "ANLCPhrasesController.h"

@implementation ANLCPhrasesController
-(id) initWithPhrases:(NSDictionary*) p {
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
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
	
	NSDictionary * phrase = phrases[[@(indexPath.row+1) stringValue]];
	[[cell textLabel] setText:phrase[@"native"]];
	[[cell detailTextLabel] setText:phrase[@"english"]];
	return cell;
}
@end
