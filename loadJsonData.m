%--------------------------------------------------------------------------
%loadJsonData    Load the data of json format by using loadjson function
%
%   Program type: Script
%
%   @input:
%   @output:
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% @author: Ting Zhou
% @date:   3.27.2016
% @copyright: Team Sherlock
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

%------------------ system initialization ---------------------------------
MRS_startup
warning off
dbstop if error

%------------------ read configuration file -------------------------------
configFile = './preamble/configuration.ini';
[homePath, dataRootPath, outputPath, ~] = loadGlobalPathSetting(configFile);

%---------------------------- read data -----------------------------------
dataList = dir(dataRootPath);
jsonDataset = loadjson([dataRootPath 'originDataset.json']);
usernames = fieldnames(jsonDataset);
jsonDataset = struct2cell(jsonDataset);


save([dataRootPath 'jsonDataset.mat'], 'jsonDataset');
save([dataRootPath 'usernames.mat'],'usernames');
