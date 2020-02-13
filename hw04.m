addpath('clean_digits');
addpath('E:\University\Digital_Speech_Recognition\sap-voicebox\voicebox');

files = dir('clean_digits');

s = size(files);
test = cell(44, 1);
FCA = cell(22, 1);
MCB = cell(22, 1);
train = cell(88, 1);

test_index = 0;
FCA_index = 0;
MCB_index = 0;
train_index = 0;
for i=1:size(files)
    file = files(i);
    if (~isempty(regexp(file.name, 'FCA')))
        test_index = test_index + 1;
        test{test_index} = file.name;
        FCA_index = FCA_index + 1;
        FCA{FCA_index} = file.name;
    elseif (~isempty(regexp(file.name, 'MCB')))
        test_index = test_index + 1;
        test{test_index} = file.name;
        MCB_index = MCB_index + 1;
        MCB{MCB_index} = file.name;
    elseif (~isempty(regexp(file.name, 'w')))
        train_index = train_index + 1;
        train{train_index} = file.name;
    end
end

FCA_train = zeros(22, 88);
FCA_train_max_val = zeros(22, 88);
FCA_train_max_idx = zeros(22, 88);
for i=1:22
    for j=1:88
        FCA_train(i, j) = dtw_score(FCA{i}, train{j});
    end
    [FCA_train_max_val(i, :) FCA_train_max_idx(i, :)] = sort(FCA_train(i, :), 'descend');
end


MCB_train = zeros(22, 88);
MCB_train_max_val = zeros(22, 88);
MCB_train_max_idx = zeros(22, 88);
for i=1:22
    for j=1:88
        MCB_train(i, j) = dtw_score(MCB{i}, train{j});
    end
    
    [MCB_train_max_val(i, :) MCB_train_max_idx(i, :)] = sort(MCB_train(i, :), 'descend');
end



test_train = zeros(44, 88);
test_train_max_val = zeros(44, 88);
test_train_max_idx = zeros(44, 88);
for i=1:44
    for j=1:88
        test_train(i, j) = dtw_score(test{i}, train{j});
    end
    
    [test_train_max_val(i, :) test_train_max_idx(i, :)] = sort(test_train(i, :), 'descend');
end