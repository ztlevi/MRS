function [Home_Path, Data_Path, Output_Path, Desktop_Path] = ...
                                        loadGlobalPathSetting(configFile)
%--------------------------------------------------------------------------
%LOADGLOBALPATHSETTING
% function LOADGLOBALPATHSETTING
%
% Program type: Function
%
% Function Signature:
% [Home_Path, Data_Path, Output_Path] = ...
%                                        loadGlobalPathSetting(configFile)
% @input:
%   configFile      : the configuration file stored in 'premeable' folder.
% @output:
%   Home_Path       : the path where the programs are placed.
%   Data_Path       : the path where the dataset is placed.
%   Output_Path     : the path where user want to store the output result.
%   Desktop_Path    : the path of user's desktop
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% @author: Yuan Ma
% @date:   Oct.18.2015
% @copyright: Intelligent System Laboratory University of Michigan-Dearborn
%--------------------------------------------------------------------------

ini = IniConfig();
ini.ReadFile(configFile);

Home_Path = ini.GetValues('Global Path Setting', 'HOME_PATH');
Data_Path = strcat(ini.GetValues('Global Path Setting', 'DATA_PATH'), ...
'/', ini.GetValues('Driver Dataset Path', 'DATA_PATH'));

Output_Path = strcat(ini.GetValues('Global Path Setting', 'OUTPUT_PATH'), ...
'/', ini.GetValues('Driver Dataset Path', 'DATA_PATH'));

Desktop_Path = ini.GetValues('Global Path Setting', 'DESKTOP_PATH');

end