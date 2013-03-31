//
//  ANLCPhrasesController.m
//  Native Languages
//
//  Created by Rovolo on 2/22/13.
//  Copyright (c) 2013 Rovolo. All rights reserved.
//

#import "ANLCPhrasesController.h"
#import "ANLCCompactPhraseView.h"

CGFloat phraseHeaderHeight;

@implementation ANLCPhrasesController
-(id) initWithPhrases:(NSArray*) p {
	if((self = [super init])) {
		phrases = p;
	}
	return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return [phrases count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return (phraseHeaderHeight > 0 ? phraseHeaderHeight : 44);
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 0;
}
-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	ANLCCompactPhraseView *cell = nil;// = [tableView dequeueReusableCellWithIdentifier:@"ANLCCompactPhraseView"];
	if(!cell) {
		UINib * nib = [UINib nibWithNibName:@"PhraseView" bundle:nil];
		[nib instantiateWithOwner:self options:nil];
		cell = phraseView;
		
		CGSize maxSize = CGSizeMake(320.0f, CGFLOAT_MAX);
		phraseHeaderHeight = [cell sizeThatFits:maxSize].height;
		[cell setPhrase:phrases[section]];
	}
	return cell;
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"Whups");
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
	if(!cell)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
	
	NSDictionary * phrase = phrases[indexPath.section];
	[[cell textLabel] setText:phrase[@"native"][0]];
	[[cell detailTextLabel] setText:phrase[@"english"][0]];
	return cell;
}
@end
