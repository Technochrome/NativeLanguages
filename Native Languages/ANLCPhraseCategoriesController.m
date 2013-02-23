//
//  ANLCPhraseListController.m
//  Native Languages
//
//  Created by Rovolo on 2013-02-21.
//  Copyright (c) 2013 Rovolo. All rights reserved.
//

#import "ANLCPhraseCategoriesController.h"
#import "ANLCPhrasesController.h"

@implementation ANLCPhraseCategoriesController

-(id) initWithCategories: (NSDictionary*) c {
	if((self = [super init])) {
		NSArray * unsortedCategories = [c allKeys];
		tableData = [unsortedCategories sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
			return [c[obj1] compare: c[obj2]];
		}];
		categories = c;
	}
	return self;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [tableData count];
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
	if(!cell)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
	
	[[cell textLabel] setText:tableData[indexPath.row]];
	return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSURL *url = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"%@/%@" , self.title, categories[tableData[indexPath.row]]]
										 withExtension:@".plist"
										  subdirectory:@"LanguageFiles"];
	
	ANLCPhrasesController *cntrl = [[ANLCPhrasesController alloc] initWithPhrases:[NSDictionary dictionaryWithContentsOfURL:url]];
	cntrl.title = tableData[indexPath.row];
	[self.navigationController pushViewController:cntrl animated:YES];
}
@end
