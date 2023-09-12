function dataget()
 validFileNames = {'dataA1', 'dataA2', 'dataA3', 'dataA4'};
 prompt = '请输入需要切割的数据集 (dataA1, dataA2, dataA3, dataA4): ';
 while true
    fileName = input(prompt, 's'); % 's'表示返回字符串
        if ismember(fileName, validFileNames)
            break; % 如果输入是有效的，跳出循环
        else
            disp('无效的输入。请重新输入。');
        end
    end
 data1 = readtable([fileName,'已处理.xlsx']);
 [square,x] = extraction(data1);%行或列次数最多的排在前面，对应的列或行小到大排序
 Length = 2440;
 Height = 1220;
 save data
end