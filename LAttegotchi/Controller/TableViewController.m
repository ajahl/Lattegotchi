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
#import "Player.h"



@interface TableViewController ()

@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        data = [[NSArray alloc] init];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (self.currentTableView) {
        case 0:
            //Wish
        {
            LAttegotchi *latte = [self getLAttegotchi];
            data = [latte getActiveWishes];
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
            data = [[NSArray alloc] init];
            break;
        }
    }
    return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    id <ListItem> listItem = [data objectAtIndex:[indexPath row]];
    
    switch (self.currentTableView) {
        case 0:
            //Wish
        {
            LAttegotchi *latte = [self getLAttegotchi];
            cell.tag = [latte.wishes indexOfObject:listItem];
            break;
        }
        case 1:
            //Backpack
        {
            Player *player = [self getPlayer];
            cell.tag = [player.items indexOfObject:listItem];
            break;
        }
        case 2:
            //Store
        {
            Player *player = [self getPlayer];
            cell.tag = [player.items indexOfObject:listItem];
            break;
        }
    }
    [[cell textLabel] setText:[listItem getName]];
    [[cell detailTextLabel] setText:[listItem getSubText:_currentTableView]];
    
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
    NSString *cellText = selectedCell.textLabel.text;
    
    switch (self.currentTableView) {
        case 0:
        //Whish
        {
            
            if ([cellText  isEqual: @"Wish 1"]) {

                _activeWish = [[GPSWish alloc] initViewController:self];
                [_activeWish setDistance:25];
                [_activeWish execute];
            }
            
            
            
            break;
        }
        
            
        case 1:
        //Backpack
        {
            
           
            
            break;
        }
        
            
        case 2:
        //Store
        {
            
            
            break;
        }
        
            
        default:
            // bloed
            break;
    }
    
    
    
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
