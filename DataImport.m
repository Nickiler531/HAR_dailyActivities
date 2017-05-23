%%import data and separate them by classes.

%% List the files in HMP_DATASET, only the ones that are directories 
database = dir('HMP_Dataset');
k=1;
for i=3 : size(database,1)
    if database(i).isdir
        HAR{k,2} = dir(strcat('HMP_Dataset/',database(i).name));
        HAR{k,1} = database(i).name;
        k=k+1;
    end
end
numberOfFiles = k-1;


%% Extract data and assign a number to the class

%transformation info. Y=mx + b
m=3/63;
b=-1.5;
g = 9.8;

classes=cell(1);
classes{1,1} = strtok(HAR{1,2}(3).name(34:end),'-');
Data = cell(1,2);
for i=1 : numberOfFiles
    for k = 1 : size(HAR{i,2},1)
        if HAR{i,2}(k).isdir == 0
            %strcat('HMP_Dataset/',HAR{i,1},'/',HAR{i,2}(k).name)
            [Ax,Ay,Az]=importfile(strcat('HMP_Dataset/',HAR{i,1},'/',HAR{i,2}(k).name));
            Data{end+1,1}=([Ax Ay Az]*m+b)*g;
            %%identify class
            class = strtok(HAR{i,2}(k).name(34:end),'-');
            index = find(strcmp(classes,class));
            if isempty(index)
                classes{end+1,1} = class;
                Data{end,2} = size(classes,1); 
            else
                Data{end,2} = index;
            end
        end
    end
end
Data = Data(2:end,:); % Delete the first item of the list that is empty 
for i=1 : size(classes,1)
    classes{i,2} = i; % Put the number corresponding to the class
end
%% Analize data (plot and statistics)
Data_analisis=classes
for i = 1:size(classes,1)
    Data_analisis{i,3} = sum(cell2mat(Data(:,2))==i)
end

histogram(cell2mat(Data(:,end)))


%% Now go to Data Processing

