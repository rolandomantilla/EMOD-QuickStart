% SUMMARY: Plot CD4 progression over time
% INPUT: output\ReportHIVInfection.csv
% OUTPUT: Figure displayed on screen

clear;clc;
colormap('pink')
%% options
actually_run_the_executable = false;
scenario_name = 'HIV_progression_cohort_2e';
config_filename = ['config_',scenario_name,'.json'];
exe_filename = 'Eradication';
output_dir = ['output\'];

%% choose baseline scenario directory and run baseline executable locally

scenario_directory = '.';
command_line_text = ...
    ['..\..\..\..\..\Eradication\x64\Release\'...
    exe_filename,...
    '.exe -C ',...
    config_filename,...
    ' -I ..\inputs -O ',output_dir];% -D local_plugins\'];


% add path to helper functions
addpath ../helper_functions_for_Matlab_plots/

if actually_run_the_executable
    run_executable_locally(scenario_directory,command_line_text);
end

%% process and plot output

infection_table  =  readtable([output_dir,'\ReportHIVInfection.csv']);

%% CD4
CD4_long = infection_table(:,{'Year','Id','CD4count'});
[CD4_pivot,Years,Ids,Settings] = Pivot(table2cell(CD4_long));
CD4_pivot = CD4_pivot(2:end,2:end); % drop column and row headings

figure(1);clf;set(gcf,'color','w');hold on;
% customize colors

set(gca, 'ColorOrder', jet(100));
plot(Years, CD4_pivot','linewidth',2);
ylim([0 1000])
xlabel('Year')
ylabel('CD4 count')

%% remove path to helper functions

rmpath ../helper_functions_for_Matlab_plots/

