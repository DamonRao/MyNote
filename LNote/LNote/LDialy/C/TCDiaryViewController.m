//
//  TCDiaryViewController.m
//  SecurityNote
//


#import "TCDiaryViewController.h"
#import "TCAddDiaryViewController.h"
#import "TCDiary.h"
#import "TCDatePickerView.h"
#import "TCEditDiaryView.h"
#import "DHDeviceUtil.h"
#import "TCDiaryCell.h"
#import "ICLanguageTool.h"
@interface TCDiaryViewController ()<UITableViewDataSource,UITableViewDelegate>

//主表格
@property (nonatomic, weak) UITableView * diaryTable;

//全部数据库条数
@property (nonatomic, strong) NSMutableArray * diaryLists;

//一条TCDiary数据
@property (nonatomic, strong) TCDiary * diaryNote;

//增加按钮
@property (nonatomic, weak) UIButton * addBtn;


@end

@implementation TCDiaryViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=LocalString(@"LNote");
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    CGFloat topMargin=TopBarHeight;
    CGFloat tabbarMargin=TabbarHeight;
    if(IOS_VERSION<11.f)
    {
        topMargin=0;
        tabbarMargin=0;
    }
    
    UITableView * dairyTab = [[UITableView alloc]initWithFrame:CGRectMake(0, topMargin, self.view.frame.size.width,self.view.frame.size.height-topMargin-tabbarMargin) style:UITableViewStylePlain];
    dairyTab.separatorColor = [DHDeviceUtil colorWithHexString:@"#eeeeee"];
    dairyTab.rowHeight = 90;
    dairyTab.tableFooterView=[[UIView alloc] init];
    dairyTab.delegate = self;
    dairyTab.dataSource = self;
    self.diaryTable = dairyTab;
    [self.view addSubview:dairyTab];
    [dairyTab registerClass:[TCDiaryCell class] forCellReuseIdentifier:@"DairyTabCellID"];
    
    CGFloat top = (MACRO_IS_IPHONE_X ? 150 : 120);
    UIButton * add = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 55, self.view.frame.size.height - top,  48, 48)];
    [add setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [add addTarget:self action:@selector(addNew:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:add];
    self.addBtn = add;
  
    
    self.diaryLists = [self.diaryNote queryWithNote];
    
}


//懒加载
-(TCDiary *)diaryNote
{
    if (_diaryNote == nil)
    {
        _diaryNote = [[TCDiary alloc]init];
    }
    
    return _diaryNote;
}


//保存新建的简记后，重新刷新数据
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    //必须重新查询数据库更新数据
    self.diaryLists = [self.diaryNote queryWithNote];
    [self.diaryTable reloadData];
}

//点击增加按钮，进入添加简记
-(void)addNew:(UIImageView* )add
{
//    [UIImageView animateWithDuration:0.3 animations:^{
//
//        add.layer.transform = CATransform3DMakeScale(2, 2, 0);
//        add.alpha = 0;
//    }
//    completion:^(BOOL finished)
//     {
//
//
//     }];
    
    TCAddDiaryViewController *toAddController = [[TCAddDiaryViewController alloc]init];
    
    [self presentViewController:toAddController animated:YES completion:nil];
    
}


//列表数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.diaryLists count];
}


//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString * diaryID = @"DairyTabCellID";
    TCDiaryCell * cell  = [tableView dequeueReusableCellWithIdentifier:diaryID];
    
    if (cell == nil)
    {
        cell =[[TCDiaryCell alloc]initWithStyle:UITableViewCellStyleSubtitle
                                    reuseIdentifier:diaryID];
        
    }
    

    //cell被选中的颜色
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor =[UIColor colorWithRed:253/255.0 green:164/255.0 blue:42/255.0 alpha:1];
    //右侧的指示
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //当前分区的数据
    self.diaryNote = self.diaryLists[[indexPath row]];
    
    cell.titleLabel.text = self.diaryNote.title;
   
    
    //判断时间，如果是今年，那么只显示月日; 如果不是，显示年份
    NSString * times = [self.diaryNote.time substringToIndex:4];
    NSString * detailContent;
    if ([times isEqualToString:[TCDatePickerView getNowDateFormat:@"yyyy"]])
    {
         detailContent = [NSString stringWithFormat:@"%@    %@    %@", [self.diaryNote.time substringFromIndex:5], self.diaryNote.weather, self.diaryNote.mood];
    }
    else
    {
        detailContent = [NSString stringWithFormat:@"%@    %@    %@",self.diaryNote.time, self.diaryNote.weather, self.diaryNote.mood];
    }
    

    cell.contentLabel.text = detailContent;

        
    return cell;
    
}



//编辑状态
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        self.diaryNote = [self.diaryLists objectAtIndex:[indexPath row]];
        
        [self.diaryNote deleteNote:self.diaryNote.ids];
        
        [self.diaryLists removeObjectAtIndex:[indexPath row]];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
    
}



//选择的列表
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
     TCEditDiaryView * editController = [[TCEditDiaryView alloc]init];
    
     self.diaryNote = self.diaryLists[[indexPath row]];
    
     editController.ids = self.diaryNote.ids;

    
    self.hidesBottomBarWhenPushed = YES;
    
     [self.navigationController pushViewController:editController animated:YES];
    
    self.hidesBottomBarWhenPushed = NO;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{

    self.addBtn.hidden = YES;
    return LocalString(@"delete");
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.addBtn.hidden = NO;
    
    return YES;
}


@end
