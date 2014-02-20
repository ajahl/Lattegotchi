//
//  TableViewController.m
//  LAttegotchi
//
//  Created by Alex Jahl on 17.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "TableViewController.h"
#import "AppDelegate.h"
#import "ListItem.h"
#import "WishViewController.h"
#import "LAttegotchi.h"
#import "PushWish.h"
#import "GPSWish.h"
#import "MysteryLetterWish.h"
#import "MysteryMathWish.h"
#import "Item.h"
#import "Player.h"
#import "PushWish.h"
#import "GPSWish.h"
#import "ShakeWish.h"
#import "Item.h"



@interface TableViewController ()

@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        data = [[NSDictionary alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [data count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (_currentTableView == 0) {
        return [super tableView:tableView titleForHeaderInSection:section];
    }
    return [[self getDataKeys] objectAtIndex:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (_currentTableView == 0) {
        return [super tableView:tableView heightForHeaderInSection:section];
    }
    return 22.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (_currentTableView == 0) {
        return [super tableView:tableView viewForHeaderInSection:section];
    }
    
    CGFloat headerHeight = [self tableView:tableView heightForHeaderInSection:section];
    
    UIView* customView = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, tableView.bounds.size.width, headerHeight)];
//    customView.backgroundColor = [UIColor colorWithRed:0 green:232.0f/255.0f blue:1.0f/255.0f alpha:1];
    customView.backgroundColor = [UIColor lightGrayColor];
    
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, headerHeight)];
    headerLabel.textColor = [UIColor blackColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:16];
    
    headerLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    
    [customView addSubview:headerLabel];
    return customView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSArray *keys = [self getDataKeys];
    NSArray *listItems = [data objectForKey:[keys objectAtIndex:section]];
    return [listItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSString *text = @"";
    NSString *detailText = @"";
    switch (self.currentTableView) {
        case 0:
            //Wish
        {
            Wish *wish = [self getItem:indexPath];
            
            text = [wish getName];
            detailText = [wish getSubText];
            
//            LAttegotchi *latte = [self getLAttegotchi];
//            cell.tag = [latte.wishes indexOfObject:wish];
            break;
        }
        case 1:
            //Backpack
        {
            // fall through
        }
        case 2:
            //Store
        {
            Item *item =  [self getItem:indexPath];
            
            text = [item getName];
            detailText = [item getSubText:_currentTableView];
            
//            Player *player = [self getPlayer];
//            NSArray* keys = [player.items allKeys];
            
//            cell.tag = [player.items indexOfObject:item];
            break;
        }
    }
    
    [[cell textLabel] setText:text];
    [[cell detailTextLabel] setText:detailText];
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}





- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    Player *player = [app getPlayer];
    LAttegotchi *latte = [player.lattegotchies objectAtIndex:0];
    
    NSString* key = [[self getDataKeys] objectAtIndex:indexPath.section];
    NSArray* currentArray = [data objectForKey:key];
    
    switch (self.currentTableView) {
        case 0:
        //Whish
        {
            Wish *wish =  [currentArray objectAtIndex:indexPath.row];
            if ([wish isKindOfClass:[GPSWish class]]) {
                
                GPSWish *wish = [latte.wishes objectAtIndex:selectedCell.tag];
                [wish initWithViewController:app.window.rootViewController];
                [wish execute];
            
            } else if ([wish isKindOfClass:[PushWish class]]) {
                PushWish *wish = [latte.wishes objectAtIndex:selectedCell.tag];
                [wish initWithViewController:app.window.rootViewController];
                [wish execute];
                
            
            } else if ([wish isKindOfClass:[MysteryMathWish class]]) {
                MysteryMathWish *wish = [latte.wishes objectAtIndex:selectedCell.tag];
                [wish initWithViewController:app.window.rootViewController];
                [wish execute];
                
            } else if ([wish isKindOfClass:[MysteryLetterWish class]]) {
                MysteryLetterWish *wish = [latte.wishes objectAtIndex:selectedCell.tag];
                [wish initWithViewController:app.window.rootViewController];
                [wish execute];
                
            } else if ([wish isKindOfClass:[ShakeWish class]]) {
                ShakeWish *wish = [latte.wishes objectAtIndex:selectedCell.tag];
                [wish initWithViewController:app.window.rootViewController];
                [wish execute];
                
            }else if ([wish isKindOfClass:[Wish class]]){
                [wish execute];
            }
            
            
            
            break;
        }
        
            
        case 1:
        //Backpack
        {
            Item * item  = [currentArray objectAtIndex:indexPath.row];
            
            if (![latte useItem:item]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ahhhhh"
                                                                message:@"this should not happen"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
            
            break;
        }
        
            
        case 2:
        //Store
        {
            Item * item  = [currentArray objectAtIndex:indexPath.row];
            
            if (![player buyItem:item]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Out of Money"
                                                                message:@"shit happens"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
            break;
        }
        
            
        default:
            // bloed
            break;
    }
    
    
    
}

- (void) reload {
    switch (self.currentTableView) {
        case 0:
            //Wish
        {
            LAttegotchi *latte = [self getLAttegotchi];
            NSMutableDictionary *tmpData = [[NSMutableDictionary alloc] init];
            if (latte != nil) {
                [tmpData setObject:[latte getActiveWishes] forKey:@"asd"];
            } else {
                [tmpData setObject:[[NSArray alloc] init] forKey:@"asd"];
            }
            data = tmpData;
            break;
        }
        case 1:
            //Backpack
        {
            Player *player = [self getPlayer];
            data = [player getOwnedItems];
            break;
        }
        case 2:
            //Store
        {
            Player *player = [self getPlayer];
            data = player.items;
            break;
        }
        default:
        {
            data = [[NSDictionary alloc] init];
            break;
        }
    }
}

- (NSArray*) getDataKeys {
    return [data allKeys];
}

- (id) getItem:(NSIndexPath*)indexPath {
    NSArray *keys = [self getDataKeys];
    NSArray *dataArray = [data objectForKey:[keys objectAtIndex:indexPath.section]];
    return [dataArray objectAtIndex:indexPath.row];
}

- (Player*) getPlayer {
    AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    return [app getPlayer];
}

- (LAttegotchi*) getLAttegotchi {
    Player *player = [self getPlayer];
    return [player.lattegotchies objectAtIndex:0];
}


/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
      *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];

    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
 
 */

@end
