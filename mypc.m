function pc1 = mypc(tab, varlist, var2scale)
% Computes the first principal component of selected variables in table,
% assuming that each variable has population mean = 0.
% - Fills missing values with 0, unless all values are missing
% - Does not center the variables prior to computation
% - Rescales the 1st pc to the std of the chosen variable "var2scale"
X = tab{:, varlist};

% detect full rows of missing values
imiss = sum(isnan(X),2)==size(X,2);

X(ismissing(X)) = 0;
X = X./std(X);
[~,score] = pca(X, 'Centered', false);

% reinsert missing values when all the row is missing
score(imiss, :) = NaN;

% rescale the 1st principal component
pc1 = score(:,1)/std(score(:,1),"omitmissing")*std(tab.(var2scale), "omitmissing");

end