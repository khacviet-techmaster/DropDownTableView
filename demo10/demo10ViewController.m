//
//  demo10ViewController.m
//  demo10
//
//  Created by DinhKhacViet on 4/14/17.
//  Copyright © 2017 DinhKhacViet. All rights reserved.
//

#import "demo10ViewController.h"

#define kNumberOfSections 1

enum {
    kSection1 = 0,
    kSection2
};


// including the dropdown cell !!
/* set to 3 if you want to see how it behaves
 when having more cells in the same section
 */
#define kNumberOfRowsInSection1 3

enum {
    kRowDropDownSelection = 0,
    kRowDropDownDisclosure,
    kRow1
};


/* set to 2 if you want to see how it behaves
 when having more cells in the same section
 */

#define kNumberOfRowsInSection2 1
enum {
    kRowDropDownCustom = 0,
    kS2Row1
};


@interface demo10ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation demo10ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    UINib *cellNib = [UINib nibWithNibName:@"demo10TableViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"demo10TableViewCell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (id)initWithStyle:(UITableViewStyle)style
{
//    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        _dropDownSelection = [[VPPDropDown alloc] initSelectionWithTitle:@"Selection Combo"
                                                               tableView:self.tableView
                                                               indexPath:[NSIndexPath indexPathForRow:kRowDropDownSelection inSection:kSection1]
                                                                delegate:self
                                                           selectedIndex:1
                                                           elementTitles:@"Option 1", @"Option 2", @"Option 3", nil];
        
        _dropDownDisclosure = [[VPPDropDown alloc] initDisclosureWithTitle:@"Disclosure Combo"
                                                                 tableView:self.tableView
                                                                 indexPath:[NSIndexPath indexPathForRow:kRowDropDownDisclosure inSection:kSection1]
                                                                  delegate:self
                                                             elementTitles:@"Disclosure 1", @"Disclosure 2", @"Disclosure 3", @"Disclosure 4", @"Disclosure 5", nil];
        
        
        NSMutableArray *elts = [NSMutableArray array];
        for (int i = 1; i <= 4; i++) {
            // just some mock elements
            VPPDropDownElement *e = [[VPPDropDownElement alloc] initWithTitle:[NSString stringWithFormat:@"Element %d",i] andObject:[NSNumber numberWithInt:i]];
            [elts addObject:e];
        }
        
        _dropDownCustom = [[VPPDropDown alloc] initWithTitle:@"Custom Combo"
                                                        type:VPPDropDownTypeCustom
                                                   tableView:self.tableView
                                                   indexPath:[NSIndexPath indexPathForRow:kRowDropDownCustom inSection:kSection2]
                                                    elements:elts
                                                    delegate:self];
    }
    return self;
}

- (void) dealloc {
    
    if (_dropDownSelection != nil) {
        _dropDownSelection = nil;
    }
    if (_dropDownDisclosure != nil) {
        _dropDownDisclosure = nil;
    }
    if (_ipToDeselect != nil) {
        _ipToDeselect  = nil;
    }
    if (_dropDownCustom != nil) {
        _dropDownCustom = nil;
    }
    
}

#pragma mark - View lifecycle


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case kSection2:
            if (indexPath.row > 0) {
                return [VPPDropDown tableView:tableView heightForRowAtIndexPath:indexPath];
            }
            
        default:
            break;
    }
    
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return kNumberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    int rows = [VPPDropDown tableView:tableView numberOfExpandedRowsInSection:section];
    switch (section) {
        case kSection1:
            rows += kNumberOfRowsInSection1;
            break;
        case kSection2:
            rows += kNumberOfRowsInSection2;
            break;
            
    }
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"demo10TableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    // Configure the cell...
//    cell.textLabel.text = nil;
    
    cell.textLabel.text = @"AAAAAAAA";

    
    if ([VPPDropDown tableView:tableView dropdownsContainIndexPath:indexPath]) {
        return [VPPDropDown tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
    // first check if any dropdown contains the requested cell
    int row = indexPath.row - [VPPDropDown tableView:tableView numberOfExpandedRowsInSection:indexPath.section];
    switch (indexPath.section) {
        case kSection1:
            switch (row) {
                case kRow1:
                    cell.textLabel.text = @"This is an independent cell";
                    break;
            }
            break;
        case kSection2:
            switch (row) {
                case kS2Row1:
                    cell.textLabel.text = @"This is an independent cell";
                    break;
            }
            break;
    }
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    
    
    // first check if any dropdown contains the requested cell
    if ([VPPDropDown tableView:tableView dropdownsContainIndexPath:indexPath]) {
        [VPPDropDown tableView:tableView didSelectRowAtIndexPath:indexPath];
        return;
    }
    
    int row = indexPath.row - [VPPDropDown tableView:tableView numberOfExpandedRowsInSection:indexPath.section];
    UIAlertView *av;
    switch (indexPath.section) {
        case kSection1:
            switch (row) {
                case kRow1:
                    av = [[UIAlertView alloc] initWithTitle:@"Cell selected" message:@"The independent cell 1 has been selected" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [av show];
                    [tableView deselectRowAtIndexPath:indexPath animated:YES];
                    break;
                    
                default:
                    break;
            }
            
            
            break;
            
        case kSection2:
            switch (row) {
                case kS2Row1:
                    av = [[UIAlertView alloc] initWithTitle:@"Cell selected" message:@"The independent cell 2 has been selected" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [av show];
                    [tableView deselectRowAtIndexPath:indexPath animated:YES];
                    break;
                    
                default:
                    break;
            }
            
            break;
    }
    
}


#pragma mark - VPPDropDownDelegate

- (void) dropDown:(VPPDropDown *)dropDown elementSelected:(VPPDropDownElement *)element atGlobalIndexPath:(NSIndexPath *)indexPath {
    if (dropDown == _dropDownDisclosure) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Disclosure pressed" message:[NSString stringWithFormat:@"%@ has been pressed!",element.title] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [av show];
    }
    
    if (dropDown == _dropDownCustom) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}
- (UITableViewCell *) dropDown:(VPPDropDown *)dropDown rootCellAtGlobalIndexPath:(NSIndexPath *)globalIndexPath {
    
    return nil;
}
- (UITableViewCell *) dropDown:(VPPDropDown *)dropDown cellForElement:(VPPDropDownElement *)element atGlobalIndexPath:(NSIndexPath *)globalIndexPath {
    static NSString *cellIdentifier = @"CustomDropDownCell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = @"Custom cell";
    cell.detailTextLabel.text = [NSString stringWithFormat:@"row %ld",(long)globalIndexPath.row];
    
    return cell;
}


- (CGFloat) dropDown:(VPPDropDown *)dropDown heightForElement:(VPPDropDownElement *)element atIndexPath:(NSIndexPath *)indexPath {
    float height = dropDown.tableView.rowHeight;
    
    return height + indexPath.row * 10;
}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (_ipToDeselect != nil) {
        [self.tableView deselectRowAtIndexPath:_ipToDeselect animated:YES];
        _ipToDeselect = nil;
    }
}

@end
