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

-(id) initWithLanguage: (NSString*) language {
	if((self = [super init])) {
		[self setTitle:language];
		
		NSURL *langURL = [[NSBundle mainBundle] URLForResource:language withExtension:@"plist" subdirectory:@"LanguageFiles"];
		categories = [[NSDictionary alloc] initWithContentsOfURL:langURL];
		tableData = [categories objectForKey:@"sections"];
	}
	return self;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [tableData count];
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
	if(!cell)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
	
	[[cell textLabel] setText:tableData[indexPath.row][@"title"]];
	[[cell detailTextLabel] setText:tableData[indexPath.row][@"subtitle"]];
	return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	ANLCPhrasesController *cntrl = [[ANLCPhrasesController alloc] initWithPhrases:tableData[indexPath.row][@"phrases"]];
	cntrl.title = tableData[indexPath.row][@"title"];
	[self.navigationController pushViewController:cntrl animated:YES];
}
@end
