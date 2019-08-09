//
//  TCMeMoViewController.m
//  SecurityNote
//


#import "TCMeMoViewController.h"
#import "TCAddMemoViewController.h"
#import "TCMemo.h"
#import "TCDatePickerView.h"
#import "TCEditMemoViewController.h"
#import "DHDeviceUtil.h"
#import "TCDiaryCell.h"
#import "ICLanguageTool.h"

@interface TCMeMoViewController ()<UITableViewDelegate,UITableViewDataSource>

//主表格
@property (nonatomic, weak) UITableView * memoTable;

//全部数据库条数
@property (nonatomic, strong) NSMutableArray * memoLists;

//一条TCDiary数据
@property (nonatomic, strong) TCMemo * memoNote;

@property (nonatomic, weak) UIButton * addBtn;

@end

@implementation TCMeMoViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=LocalString(@"Memo");
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    CGFloat topMargin=TopBarHeight;
    CGFloat tabbarMargin=TabbarHeight;
    if(IOS_VERSION<11.f)
    {
        topMargin=0;
        tabbarMargin=0;
    }
    UITableView * memoTable = [[UITableView alloc]initWithFrame:CGRectMake(0, topMargin, self.view.frame.size.width, self.view.frame.size.height-topMargin-tabbarMargin) style:UITableViewStylePlain];
    memoTable.separatorColor = [DHDeviceUtil colorWithHexString:@"#eeeeee"];
    memoTable.rowHeight = 90;
    memoTable.tableFooterView=[[UIView alloc] init];
    memoTable.delegate = self;
    memoTable.dataSource = self;
    
    self.memoTable = memoTable;
    [self.view addSubview:memoTable];
    [memoTable registerClass:[TCDiaryCell class] forCellReuseIdentifier:@"MemoTableCellID"];
    
    CGFloat top = (MACRO_IS_IPHONE_X ? 150 : 120);
    UIButton * add = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 55, self.view.frame.size.height - top,  48, 48)];
    [add setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [add addTarget:self action:@selector(addNew:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:add];
    
    self.addBtn = add;

 
    self.memoLists = [self.memoNote queryWithNote];
    
}

//懒加载
-(TCMemo *)memoNote
{
    if (_memoNote == nil)
    {
        _memoNote = [[TCMemo alloc]init];
    }
    
    return _memoNote;
}


//保存新建的简记后，重新刷新数据
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    //必须重新查询数据库更新数据
    self.memoLists = [self.memoNote queryWithNote];
    [self.memoTable reloadData];
}


//点击增加按钮，进入添加简记
-(void)addNew:(UIImageView* )add
{
    TCAddMemoViewController *toAddController = [[TCAddMemoViewController alloc]init];
    
    [self presentViewController:toAddController animated:YES completion:nil];
    
}


//列表数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.memoLists count];
}


//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString * diaryID = @"MemoTableCellID";
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
    self.memoNote = self.memoLists[[indexPath row]];
    
    cell.titleLabel.text = self.memoNote.title;
  
    cell.contentLabel.text = [NSString stringWithFormat:@"%@%@    %@",self.memoNote.year, self.memoNote.time, self.memoNote.memotype];
    
    return cell;
    
}



//编辑状态
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        self.memoNote = [self.memoLists objectAtIndex:[indexPath row]];
        
        [self.memoNote deleteNote:self.memoNote.ids];
        
        [self.memoLists removeObjectAtIndex:[indexPath row]];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
    
}



//选择的列表
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TCEditMemoViewController * editController = [[TCEditMemoViewController alloc]init];
    
    self.memoNote = self.memoLists[[indexPath row]];
    
    editController.ids = self.memoNote.ids;
    
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
