function [pwImages] = createPWbaseline(dataFolder, prop, readFcn)


dfCont = dir(dataFolder);
folderCont = dfCont(string({dfCont.name}) ~= '.' & string({dfCont.name}) ~= '..' & cell2mat({dfCont.isdir}) == 1);

[n, ~] = size(folderCont);

%Create pairwise Datastores
%% Create a vector of the makeup iamges Datastores with top folder lables

pwImages = cell(nchoosek(n,2), 2);

t = 1;
for i=1:n-1
    for j=i+1:n
        pwPathes = {fullfile(folderCont(i).folder, folderCont(i).name); fullfile(folderCont(j).folder, folderCont(j).name)};        
        pwImage = imageDatastore(pwPathes,... 
            'LabelSource', 'foldernames');
        pwImage.ReadFcn = readFcn;
        
        %pwImage1 = imageDatastore(fullfile(folderCont(i).folder, folderCont(i).name),... 
        %    'LabelSource', 'foldernames');
        %pwImage1.ReadFcn = readFcn;
        %pwImage2 = imageDatastore(fullfile(folderCont(j).folder, folderCont(j).name),...
        %    'LabelSource', 'foldernames');
        %pwImage2.ReadFcn = readFcn;
        
        %pwImage = combine(pwImage1, pwImage2);
        [pwImageTrain, pwImageTest] = splitEachLabel(pwImage, prop, 'randomize');
        pwImages{t, 1} = pwImageTrain;
        pwImages{t, 2} = pwImageTest;
        t = t + 1;
    end
end

end
