%% Clear everything 
clear all; close all; clc;
%ngpu = gpuDeviceCount();
%for i=1:ngpu
%    reset(gpuDevice(i));
%end


%% Load and label data
dataFolder = '/media/data2/Tr0SF';
trainTestProp = 0.3;

[imageDStores] = createPWbaseline(dataFolder, trainTestProp, @readFunctionGray_n);

