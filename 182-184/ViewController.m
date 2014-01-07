//
//  ViewController.m
//  182-184
//
//  Created by SDT-1 on 2014. 1. 6..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *data;
}
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ViewController

-(BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *) alertView
{
    //입력 문자열 길이가 2보다 클 때만 추가 가능
    NSString *inputStr = [alertView textFieldAtIndex:0].text;
    return [inputStr length] >2;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == alertView.firstOtherButtonIndex) {
        UITextField *newStr = [alertView textFieldAtIndex:0];
        if(newStr.text.length > 0) {
            [data addObject:newStr.text];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([data count]-1) inSection:0];
            NSArray *row = [NSArray arrayWithObject:indexPath];
            [self.table insertRowsAtIndexPaths:row withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        
    }
    
}

- (IBAction)toggleEdit:(id)sender
{
    self.table.editing =! self.table.editing;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row %3 ==0) {
        return UITableViewCellEditingStyleNone;
    }
    else if (indexPath.row %3 ==1)
    {
        return UITableViewCellEditingStyleDelete;
    }
    else
        return UITableViewCellEditingStyleInsert;
}


//삭제/추가작업 - 로그로확인
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        //테이블 삭제
        [data removeObjectAtIndex:indexPath.row];
        // 테이블 셀삭제
        NSArray *rowList = [NSArray arrayWithObjects:indexPath];
        [tableView deleteRowsAtIndexPaths:rowList withRowAnimation:UITableViewRowAnimationAutomatic];
        //NSLog(@"%d 번째삭제", (int)indexPath.row);
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"추가" message:nil delegate:self cancelButtonTitle:@"취소" otherButtonTitles:@"확인", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];
        //NSLog(@"%d 번째추가", (int)indexPath.row);
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [data count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Dynamic Prototypes
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL_ID"];
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %d", (int)indexPath.row];
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	data = [[NSMutableArray alloc]initWithObjects:@"item1", @"item2", @"item3", @"item4", @"item5", @"item6", @"item7", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
