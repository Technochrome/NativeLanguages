//
//  ANLCFirstViewController.m
//  Native Languages
//
//  Created by Rovolo on 2013-01-31.
//  Copyright (c) 2013 Rovolo. All rights reserved.
//

#import "ANLCLanguagesController.h"
#import "ANLCPhraseCategoriesController.h"

static id shared;

@implementation ANLCLanguagesController

+(id) shared { return shared; }

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		shared = self;
		self.title = @"Phrase Book";//NSLocalizedString(@"First", @"First");
		self.tabBarItem.image = [UIImage imageNamed:@"first"];
		[self.navigationController setNavigationBarHidden:NO animated:YES];
		
		NSURL *langURL = [[NSBundle mainBundle] URLForResource:@"languages" withExtension:@"plist" subdirectory:@"LanguageFiles"];
		languages = [[NSArray alloc] initWithContentsOfURL:langURL];
    }
    return self;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [languages count];
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
	if(!cell)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
	
	[[cell textLabel] setText:languages[indexPath.row]];
	return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	ANLCPhraseCategoriesController * cntrl = [[ANLCPhraseCategoriesController alloc]
											  initWithLanguage:languages[indexPath.row]];
	
	[self.navigationController popToRootViewControllerAnimated:YES];
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
