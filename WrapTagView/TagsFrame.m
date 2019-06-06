//
//  TagsFrame.m
//  TagsDemo
//
//  Created by Administrator on 16/1/21.
//  Copyright © 2016年 Administrator. All rights reserved.
//
//  计算多个标签的位置
//  标签根据文字自适应宽度
//  每行超过的宽度平均分配给每个标签
//  每行标签左右对其
/* 用法：
 -(void)resetProjectList:(NSArray *)arrProjects{
 
 //  arrProjects = @[@"全部",@"钢琴",@"吉他",@"电吉他电吉他",@"开",@"小提琴",@"架子鼓",@"口琴",@"贝斯",@"卡祖笛",@"古筝",@"翻弹",@"音乐",@"指弹",@"千本樱",@"民乐",@"初音MIKU",@"ANIMENZ",@"PENBEAT",@"木吉他",@"二胡",@"COVER",@"交响",@"权御天下",@"普通DISCO",@"OP",@"ILEM",@"原创",@"作业用BGM",@"串烧",@"东方",@"合奏",@"燃向",@"触手",@"试奏",@"ACG指弹",@"武士桑",@"触手猴",@"BGM",@"LAUNCHPAD",@"全部",@"钢琴",@"吉他",@"电吉他电吉他",@"开",@"小提琴",@"架子鼓",@"口琴",@"贝斯",@"卡祖笛",@"古筝",@"翻弹",@"音乐",@"指弹",@"千本樱",@"民乐",@"初音MIKU",@"ANIMENZ",@"PENBEAT",@"木吉他",@"二胡",@"COVER",@"交响",@"权御天下",@"普通DISCO",@"OP",@"ILEM",@"原创",@"作业用BGM",@"串烧",@"东方",@"合奏",@"燃向",@"触手",@"试奏",@"ACG指弹",@"武士桑",@"触手猴",@"BGM",@"LAUNCHPAD"];
 
 TagsFrame *frame = [[TagsFrame alloc] init];
 
 frame.tagsMinPadding = 20; //最小内边距
 frame.tagsMargin = 20;
 frame.tagsLineSpacing = 10; //行间距
 frame.tagViewWidth = SCREEN_WIDTH-fWidthCity;
 frame.shouldFill = NO; //是否按钮平铺
 
 NSInteger count = arrProjects.count;
 NSMutableArray *arrProjectsName = [NSMutableArray new];
 for (int i=0; i<count; i++) {
 ProjectModel *model = arrProjects[i];
 [arrProjectsName addObject:model.projectName];
 }
 frame.tagsArray = arrProjectsName;
 
 while (_scrollContent.subviews.count) {
 [_scrollContent.subviews.lastObject removeFromSuperview];
 }
 
 for (NSInteger i=0; i<count; i++) {
 ProjectModel *model = arrProjects[i];
 UIButton *tagsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
 [tagsBtn setTitle:model.projectName forState:UIControlStateNormal];
 [tagsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
 [tagsBtn setTitleColor:kWhiteColor forState:UIControlStateSelected];
 tagsBtn.titleLabel.font = TagsTitleFont;
 tagsBtn.layer.borderWidth = 1;
 tagsBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
 tagsBtn.layer.cornerRadius = 2;
 tagsBtn.layer.masksToBounds = YES;
 tagsBtn.frame = CGRectFromString(frame.tagsFrames[i]);
 [tagsBtn addTarget:self action:@selector(btnProjectSelected:) forControlEvents:UIControlEventTouchUpInside];
 tagsBtn.tag = i;
 [self.scrollContent addSubview:tagsBtn];
 //默认选中当前项目
 WorkUserModel *userModel = [WEWorkUserTool sharedWorkUserTool].userModel;
 // TODO: 判断-默认选中当前项目
 if ([userModel.currentProject.projectId isEqualToString:model.projectId]) {
 tagsBtn.selected = YES;
 tagsBtn.backgroundColor = kMainColor;
 tagsBtn.layer.borderColor = kMainColor.CGColor;
 }
 }
 
 CGFloat fLastYPoint = CGRectFromString(frame.tagsFrames.lastObject).origin.y;
 [self.scrollContent setContentSize:CGSizeMake(self.scrollContent.frame.size.width, fLastYPoint+80)];
 
 }
 */


#import "TagsFrame.h"

@implementation TagsFrame

- (id)init
{
    self = [super init];
    if (self) {
        _tagsFrames = [NSMutableArray array];
        _tagsMinPadding = 10;
        _tagsMargin = 10;
        _tagsLineSpacing = 10;
    }
    return self;
}

- (void)setTagsArray:(NSArray *)tagsArray
{
    _tagsArray = tagsArray;
    
    CGFloat btnX = _tagsMargin;
    CGFloat btnW = 0;
    
    CGFloat nextWidth = 0;  // 下一个标签的宽度
    CGFloat moreWidth = 0;  // 每一行多出来的宽度
    
    /**
     *  每一行的最后一个tag的索引的数组和每一行多出来的宽度的数组
     */
    NSMutableArray *lastIndexs = [NSMutableArray array];
    NSMutableArray *moreWidths = [NSMutableArray array];
    //全视图总宽度
    CGFloat viewWidth = _tagViewWidth ? _tagViewWidth : WIDTH;
    
    for (NSInteger i=0; i<tagsArray.count; i++) {
        //第i个标签宽度原本
        btnW = [self sizeWithText:tagsArray[i] font:TagsTitleFont].width + _tagsMinPadding * 2;
        //下一个标签原本宽度
        if (i < tagsArray.count-1) {
            nextWidth = [self sizeWithText:tagsArray[i+1] font:TagsTitleFont].width + _tagsMinPadding * 2;
        }
        //
        CGFloat nextBtnX = btnX + btnW + _tagsMargin;
        // 如果下一个按钮，标签最右边则换行
        if ((nextBtnX + nextWidth) > (viewWidth - _tagsMargin)) {
            // 计算超过的宽度
            moreWidth = viewWidth - nextBtnX;
            
            [lastIndexs addObject:[NSNumber numberWithInteger:i]];
            [moreWidths addObject:[NSNumber numberWithFloat:moreWidth]];
            
            btnX = _tagsMargin;
        }else{
            btnX += (btnW + _tagsMargin);
        }
        // 如果是最后一个且数组中没有，则把最后一个加入数组
        if (i == tagsArray.count -1) {
            if (![lastIndexs containsObject:[NSNumber numberWithInteger:i]]) {
                [lastIndexs addObject:[NSNumber numberWithInteger:i]];
                [moreWidths addObject:[NSNumber numberWithFloat:0]];
            }
        }
    }
    
    NSInteger location = 0;  // 截取的位置
    NSInteger length = 0;    // 截取的长度
    CGFloat averageW = 0;    // 多出来的平均的宽度
    
    CGFloat tagW = 0;
    CGFloat tagH = 34;
    
    for (NSInteger i=0; i<lastIndexs.count; i++) {
        
        NSInteger lastIndex = [lastIndexs[i] integerValue];
        if (i == 0) {
            length = lastIndex + 1;
        }else{
            length = [lastIndexs[i] integerValue]-[lastIndexs[i-1] integerValue];
        }
        
        // 从数组中截取每一行的数组
        NSArray *newArr = [tagsArray subarrayWithRange:NSMakeRange(location, length)];
        location = lastIndex + 1;
        
        averageW = [moreWidths[i] floatValue]/newArr.count;
        
        CGFloat tagX = _tagsMargin;
        CGFloat tagY = _tagsLineSpacing + (_tagsLineSpacing + tagH) * i;
    
        for (NSInteger j=0; j<newArr.count; j++) {
            
            if (_shouldFill) {
                tagW = [self sizeWithText:newArr[j] font:TagsTitleFont].width + _tagsMinPadding * 2 + averageW;
            }else{
                tagW = [self sizeWithText:newArr[j] font:TagsTitleFont].width + _tagsMinPadding * 2 ;
            }
            
            CGRect btnF = CGRectMake(tagX, tagY, tagW, tagH);
            
            [_tagsFrames addObject:NSStringFromCGRect(btnF)];
            
            tagX += (tagW+_tagsMargin);
            
        }
    }
    
    _tagsHeight = (tagH + _tagsLineSpacing) * lastIndexs.count + _tagsLineSpacing;
    
}

/**
 *  单行文本数据获取宽高
 *
 *  @param text 文本
 *  @param font 字体
 *
 *  @return 宽高
 */
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text sizeWithAttributes:attrs];
}

@end
