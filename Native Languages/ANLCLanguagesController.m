//
//  ANLCFirstViewController.m
//  Native Languages
//
//  Created by Rovolo on 2013-01-31.
//  Copyright (c) 2013 Rovolo. All rights reserved.
//

#import "ANLCLanguagesController.h"
#import "ANLCPhraseCategoriesController.h"

@implementation ANLCLanguagesController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = @"Phrase Book";//NSLocalizedString(@"First", @"First");
		self.tabBarItem.image = [UIImage imageNamed:@"first"];
		[self.navigationController setNavigationBarHidden:NO animated:YES];
		
		NSURL *langURL = [[NSBundle mainBundle] URLForResource:@"languages" withExtension:@"plist" subdirectory:@"LanguageFiles"];
		languages = [[NSMutableDictionary alloc] initWithContentsOfURL:langURL];
		categories = [languages allKeys];
    }
    return self;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [categories count];
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
	if(!cell)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
	
	[[cell textLabel] setText:categories[indexPath.row]];
	return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	ANLCPhraseCategoriesController * cntrl = [[ANLCPhraseCategoriesController alloc]
											  initWithCategories:languages[categories[indexPath.row]]];
	cntrl.title = categories[indexPath.row];
	[self.navigationController pushViewController:cntrl animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
