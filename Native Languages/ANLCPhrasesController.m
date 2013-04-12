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
		openSection = nil;
	}
	return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return [phrases count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return (phraseHeaderHeight > 0 ? phraseHeaderHeight : 44);
}

// -1 because of header
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return (openSection && [openSection section] == section ?
			MAX([phrases[section][@"native"] count],[phrases[section][@"english"] count])-1
			: 0);
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
		[cell setDelegate:self];
		[cell setSection:section];
	}
	return cell;
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
	if(!cell)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
	
	NSDictionary * phrase = phrases[indexPath.section];
	
	// +1 because the header is part 0
	// FIXME, native and english aren't always the same length
	NSArray * native = phrase[@"native"], *english = phrase[@"english"];
	int idx = indexPath.row+1;
	if(idx < [native count]) {
		cell.textLabel.text = native[idx];
		if(idx < [english count]) cell.detailTextLabel.text = english[idx];
	} else {
		cell.textLabel.text = english[idx];
	}
	return cell;
}
-(NSArray*) indexPathsForSection:(ANLCCompactPhraseView*) sectionHeader {
	if(!sectionHeader) return nil;
	NSInteger section = [sectionHeader section];
	NSMutableArray * paths = [NSMutableArray array];
	
	NSArray * altPhrases = phrases[section][@"native"];
	// -1 because of header
	for(int i=0; i<[altPhrases count]-1; i++) {
		[paths addObject:[NSIndexPath indexPathForRow:i inSection:section]];
	}
	
	return paths;
}
-(void) expandSection:(ANLCCompactPhraseView*)newOpenSection {
	if(openSection == newOpenSection) return;
	
	[openSection closeSection];
	
	[self.tableView beginUpdates];
	[self.tableView insertRowsAtIndexPaths:[self indexPathsForSection:newOpenSection]
						  withRowAnimation:UITableViewRowAnimationAutomatic];
	[self.tableView deleteRowsAtIndexPaths:[self indexPathsForSection:openSection]
						  withRowAnimation:UITableViewRowAnimationAutomatic];
	openSection = newOpenSection;
	[self.tableView endUpdates];
}
@end
