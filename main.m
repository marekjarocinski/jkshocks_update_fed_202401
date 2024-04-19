% This script updates the shocks from Jarocinski, Karadi (2020) AEJ:Macro
clear all, close all

% Interest rate surprises to extract pc from, stock index
irnames = ["MP1","FF4","ED2","ED3","ED4"];
stockname = "SP500";

% Load the high-frequency surprises dataset, 
tab = readtable("fomc_surprises_jk.csv", Delimiter=",");

% Select the sample
isample = year(tab.start) > 1989; % until 1989 there are many missing obs
tab = tab(isample,:);
fprintf('Data from %s to %s, T=%d\n', tab{1,'start'}, tab{end,'start'}, size(tab,1))

% Compute the 1st principal component
pc1 = mypc(tab, irnames, "ED4");
tab.pc1 = round(pc1,8);

% keep only the variables we need
tab = tab(:,["start","pc1",stockname]); 

% Compute the poor man and median shocks
M = tab{:,["pc1",stockname]};
% poor man's shocks
U_pm = [M(:,1).*(prod(M,2)<0) M(:,1).*(prod(M,2)>=0)];
% median shocks
U_median = signrestr_median(M);

% Save high-frequency shocks
shocks_names = ["MP_pm","CBI_pm","MP_median","CBI_median"];
shocks_table = array2table(round([U_pm U_median],8), 'VariableNames', shocks_names);
tab = [tab shocks_table];
tab.start.Format = "uuuu-MM-dd HH:mm";
filename_t = "shocks_fed_jk_t.csv";
writetable(tab, filename_t);

% Aggregate to monthly
mtab = table_d2m2q(tab);
mtab.Properties.VariableNames(3:4) = mtab.Properties.VariableNames(3:4) + "_hf";
writetable(mtab, strrep(filename_t, "_t.csv", "_m.csv"));