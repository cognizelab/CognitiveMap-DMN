%% Default Setting
param = set_params(model,param); 
%% -------------------------------------------------- Data Manipulation ------------------------------------------------------------------
%% Data Filtering
log.model = model; ID = [];

if param.interp > 0
    [x, log.data.xgood,f1] = mat_data_filtering(x, param.interp, 0.1); y(f1,:) = []; 
    [y, log.data.ygood,f2] = mat_data_filtering(y, 0, 0.1); x(f2,:) = [];    
    log.removed_xy = [f1 f2];
    
    if ~isempty(c)
        c(f1,:) = []; c(f2,:) = [];
    end
    
    [c, log.data.cgood,f3] = mat_data_filtering(c, 1, 1); 
    
    if ~isempty(param.ID) && size(param.ID,1) ~= size(x,1)
        param.ID(f1,:) = []; param.ID(f2,:) = [];
    end
    if ~isempty(param.groupCV) && size(param.groupCV,1) ~= size(x,1)
        param.groupCV(f1,:) = []; param.groupCV(f2,:) = [];
    end
    if ~isempty(param.stratifyCV) && size(param.stratifyCV,1) ~= size(x,1)
        param.stratifyCV(f1,:) = []; param.stratifyCV(f2,:) = [];
    end
    if ~isempty(param.indexCV) && size(param.indexCV,1) ~= size(x,1)
        param.indexCV(f1,:) = []; param.indexCV(f2,:) = [];
    end
end

%% Data Packing
[index,cv] = mat_sample(x,y,c,cv,param);
log.folds.cv = cv; log.folds.index = index; 

%% Data Permutation
if param.random == 1 
    y = y(randperm(size(y,1)),:);
elseif param.random > 1
    Y = y;    
end

n = 1; k = 1;
if param.random == 2
    y = Y(randperm(size(Y,1)),:);
end 
idx = index(:,n); PV = []; TV = []; PW = []; id = [];       

% data allocation
ftest = find(idx==k); ftrain = find(idx~=k); param.ftest = ftest; param.ftrain = ftrain;
xtest = x(ftest,:); ytest = y(ftest,:); 
xtrain = x(ftrain,:); ytrain = y(ftrain,:); 
if ~isempty(param.ID); id = [id;param.ID(ftest,:)]; log.ID{k,n} = param.ID(ftest,:); end
if param.random == 3
    f1 = randperm(size(ytest,1)); ytest = ytest(f1,:);               
    f2 = randperm(size(ytrain,1)); ytrain = ytrain(f2,:); 
end                
% covariates regression  
if param.covariates > 0 && ~isempty(c) 
   ctest = c(ftest,:); ctrain = c(ftrain,:); 
   if param.covariates == 1 
       if param.random == 3; ctrain = ctrain(f2,:); ctest = ctest(f2,:); end
      [ytrain,ytest] = mat_regress_xy(ctrain,ctest,ytrain,ytest);
   elseif param.covariates == 2 
       if param.random == 3; ctrain = ctrain(f1,:); ctest = ctest(f1,:); end
      [xtrain,xtest] = mat_regress_xy(ctrain,ctest,xtrain,xtest);
   end
end     
% feature scaling 
if param.scale == 1 
    [xtrain,xtest] = mat_scale(xtrain,xtest); 
end
% parameter optimization  
if param.po > 0
    [opt_parameter{k,n},opt_records{k,n},param] = get_opt_params(xtrain,ytrain,model,param);
    do_parameter = opt_parameter{k,n};
else
    opt_parameter = []; opt_records = [];
    do_parameter = get_default_params(model,param);
end   
% model training  
[out_train{k,n},temporary_file] = train_model(xtrain,ytrain,model,do_parameter,param);
% model generalization
out_apply{k,n} = apply_model(xtest,ytest,model,out_train{k,n},temporary_file);
% data concatenation
TV = [TV;out_apply{k,n}.tv]; PV = [PV;out_apply{k,n}.pv]; PW = [PW;out_apply{k,n}.dp];              
% model evaluation (fold level)
out_assess{k,n} = assess_model(out_apply{k,n},model,param);