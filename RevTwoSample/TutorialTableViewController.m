//
//  TutorialTableViewController.m
//  RevTwoSample
//
//  Created by Ashley Calder on 9/1/15.
//  Copyright (c) 2015 RevTwo. All rights reserved.
//

#import "TutorialTableViewController.h"
#import "R2CommunityViewController.h"
#import "R2MyTicketViewController.h"


@interface TutorialTableViewController ()

@end

@implementation TutorialTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Tutorials";
    UIImage* logoImage = [UIImage imageNamed:@"logo_black_sm.png"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:logoImage];
    
    
    self.tutorials = [NSArray arrayWithObjects:
                      @"Logging",
                      @"File Browsing",
                      @"SQLite Database",
                      nil];
    self.pickedTutorial = NO;
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.pickedTutorial = NO;
    /*
     * notification permissions
     */
    UIUserNotificationSettings* notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source




/*
 * SECTIONS
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return [self.tutorials count];
        case 1:
            return 2;
        case 2:
            return 2;
        default:
            return 0;
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Tutorials";
        case 1:
            return @"Create Ticket";
        case 2:
            return @"Community Tickets";
        default:
            return nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60.0;
}
/*
 * CELL
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tutorialCell" forIndexPath:indexPath];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tutorialCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tutorialCell"];
    }
    //Tutorials
    if (indexPath.section == 0){
        cell.textLabel.text = [self.tutorials objectAtIndex:indexPath.row];
    }
    //Create Ticket
    else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"Push My Ticket View";
                break;
            case 1:
                cell.textLabel.text = @"Modal My Ticket View";
                break;
        }
    }
    //Community Ticket
    else if (indexPath.section == 2){
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"Push Community View";
                break;
            case 1:
                cell.textLabel.text = @"Modal Community View";
                break;
        }
    }
    
    return cell;
}

/*
 * SELECT CELL
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Tutorials
    if (indexPath.section == 0){
        NSString *tutorial = [self.tutorials objectAtIndex:indexPath.row];
        if (!self.pickedTutorial) {
            self.pickedTutorial = YES;
            //Logging
            if ([tutorial isEqualToString:@"Logging"]) {
                LoggingViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Logging"];
                [self.navigationController pushViewController:vc animated:YES];
            }
            //FileBrowser
            else if ([tutorial isEqualToString:@"File Browsing"]) {
                FileBrowserViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"FileBrowser"];
                [self.navigationController pushViewController:vc animated:YES];
            }
            
            //DatabaseBrowser
            else if ([tutorial isEqualToString:@"SQLite Database"]) {
                SQLiteBrowserViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DatabaseBrowser"];
                [self.navigationController pushViewController:vc animated:YES];
            }
            
            
        }
    }
    //Create Ticket
    else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
                {
                    //push my ticket
                    R2MyTicketViewController *vc = [[R2MyTicketViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                break;
            case 1:
                {
                    //modal my ticket
                    R2MyTicketViewController *vc = [[R2MyTicketViewController alloc]init];
                    vc.delegateModal = self;
                    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
                    [self presentViewController:nc animated:YES completion:nil];
                }
                break;
        }
    }
    //Community Ticket
    else if (indexPath.section == 2){
        switch (indexPath.row) {
            case 0:
                {
                    //push community
                    R2CommunityViewController *vc = [[R2CommunityViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                break;
            case 1:
                {
                    //modal community
                    R2CommunityViewController *vc = [[R2CommunityViewController alloc]init];
                    vc.delegateModal = self;
                    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
                    [self presentViewController:nc animated:YES completion:nil];
                }
                break;
        }
    }
    
    
    
    
    
}


- (void)didDismissR2ViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
