function dataget()
    % 保持请求用户输入，直到输入的字符串符合预期格式
    while true
        % 请求用户输入
        folder_path = input('请输入数据名（dataB1到dataB5）: ', 's');  % 's' 参数表示返回一个字符串
        
        % 检查输入是否符合预期
        if ~isempty(regexp(folder_path, '^dataB[1-5]$', 'once'))
            % 如果输入符合预期，退出循环
            break;
        else
            % 如果输入不符合预期，给出错误信息并继续循环
            disp('输入不正确，请输入dataB1到dataB5中的一个');
        end
    end
    data = readtable([folder_path,'已处理.csv']);
    data1 = data{:,2};%材料数
    data2 = data{:,6};%订单数
    Materials = tabulate(data1);
    order = tabulate(data2);
    max_item_area = 2.5e+8;
    save data
end