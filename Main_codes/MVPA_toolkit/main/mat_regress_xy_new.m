function [ytrain,ytest,c_y_train,c_y_test] = mat_regress_xy_new(ctrain,ctest,ytrain,ytest)
%% keep the coviariate influence as output
ctrain = bsxfun(@minus, ctrain, mean(ctrain));
ctrain = [ones(size(ytrain,1),1) ctrain];
beta = (ctrain'*ctrain)\(ctrain'*ytrain);
ytrain = ytrain - ctrain*beta;
c_y_train = ctrain*beta;

if nargin == 4 & ~isempty(ytest)
    ctest = bsxfun(@minus, ctest, mean(ctest));
    ctest = [ones(size(ytest,1),1) ctest];
    ytest = ytest - ctest*beta;
    c_y_test = ctest*beta;
else
    ytest = [];
    c_y_test = [];
end

