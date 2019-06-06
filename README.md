# ios-Little
iOS 标签自动换行 神助攻 用法示例：

-(void)resetProjectList:(NSArray *)arrProjects{
    
  arrProjects = @[@"全部",@"钢琴",@"吉他",@"电吉他电吉他上一个要充满一行啦注意观察哦",@"开",@"小提琴",@"架子鼓",@"口琴",@"贝斯",@"卡祖笛",@"古筝",@"翻弹",@"音乐",@"指弹",@"千本樱",@"民乐",@"初音MIKU",@"ANIMENZ",@"PENBEAT",@"木吉他",@"二胡",@"COVER",@"交响",@"权御天下",@"普通DISCO",@"OP",@"ILEM",@"原创",@"作业用BGM",@"串烧",@"东方",@"合奏",@"燃向",@"触手",@"试奏",@"ACG指弹",@"武士桑",@"触手猴",@"BGM",@"LAUNCHPAD",@"全部",@"钢琴",@"吉他",@"电吉他电吉他",@"开",@"小提琴",@"架子鼓",@"口琴",@"贝斯",@"卡祖笛",@"古筝",@"翻弹",@"音乐",@"指弹",@"千本樱",@"民乐",@"初音MIKU",@"ANIMENZ",@"PENBEAT",@"木吉他",@"二胡",@"COVER",@"交响",@"权御天下",@"普通DISCO",@"OP",@"ILEM",@"原创",@"作业用BGM",@"串烧",@"东方",@"合奏",@"燃向",@"触手",@"试奏",@"ACG指弹",@"武士桑",@"触手猴",@"BGM",@"LAUNCHPAD"];
    
    TagsFrame *frame = [[TagsFrame alloc] init];
    
    frame.tagsMinPadding = 20; //最小内边距
    frame.tagsMargin = 20;
    frame.tagsLineSpacing = 10; //行间距
    frame.tagViewWidth = SCREEN_WIDTH-fWidthCity;
    frame.shouldFill = YES; //是否按钮平铺
    
    NSInteger count = arrProjects.count;
    frame.tagsArray = arrProjects; //arrProjectsName;
    
    while (_scrollContent.subviews.count) {
        [_scrollContent.subviews.lastObject removeFromSuperview];
    }
    
    for (NSInteger i=0; i<count; i++) {
        NSString *projectName = arrProjects[i];
        UIButton *tagsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [tagsBtn setTitle:projectName forState:UIControlStateNormal];
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
        
    }
    
    CGFloat fLastYPoint = CGRectFromString(frame.tagsFrames.lastObject).origin.y;
    [self.scrollContent setContentSize:CGSizeMake(self.scrollContent.frame.size.width, fLastYPoint+80)];
    
}
