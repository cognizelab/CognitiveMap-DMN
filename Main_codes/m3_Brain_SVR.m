%% set up toolbox  
addpath(genpath('/Main_codes/MVPA_toolkit')); 
addpath(genpath('/Utility_codes/Statistics'));
addpath(genpath('/Utility_codes/nnet'))
%% load data
load('Main_codes/Data/scaled_beta.mat');

%% model setting

nparticipant = 43; nlevel=4;
groupCV = repmat(1:nparticipant, nlevel,1);
param.groupCV = groupCV(:);
output=repmat(1:nlevel,1,nparticipant);output=output(:);
%param.xnew = image_7T;
model = 'svr'; % applying SVM algorithm
cv = [10 10]; % outer loop (10 times of 10-folds cross-validation)
param.interp = 1; % perform data cleaning with interpolating missing values with the median 
param.scale = 1; % perform feature scaling
param.po = 0; % do not perform parameter optimization (use default parameter in SVM)
param.C = []; % use default C parameter in SVM
param.text = 1;
%% run svr
[out,log] = mat_cv_new(image,output,[],model,cv,param);

%% permutation test
out = mat_permutation(image,output,[],log,out,'N',1000);

%% bootstrap and haufe transform (time consuming)
[out,bootweight,haufeweight] = mat_bootstrap_new(image,output,[],log,out,'N',10,'opt_parameter',1,'parallel','Haufe',3,'parpool',5); %  bootstrap


%% sensitivity check
% 3T discovery dataset
PV = reshape(mean(out.ordered_PV,2), [nlevel, nparticipant])';
ROC_accuracies_3T = zeros(4,4);
ROC_p_3T = zeros(4,4);

for i = 1:3
    for j = (i+1):4
        ROC = roc_plot([PV(:, i);PV(:,j)], [zeros(nparticipant,1);ones(nparticipant,1)], 'twochoice','nooutput','noplot');
        ROC_accuracies_3T(i,j)=ROC.accuracy;
        ROC_p_3T(i,j) = ROC.accuracy_p;
    end
end
% 7T validation dataset
nsub = 39;
PV = reshape(mean(out.ordered_PV_validation,2), [nlevel, nsub])';
ROC_accuracies_validation = zeros(4,4);
ROC_p_validation = zeros(4,4);

for i = 1:3
    for j = (i+1):4
        ROC = roc_plot([PV(:, i);PV(:,j)], [zeros(nsub,1);ones(nsub,1)], 'twochoice','nooutput','noplot');
        ROC_accuracies_validation(i,j)=ROC.accuracy;
        ROC_p_validation(i,j) = ROC.accuracy_p;
    end
end

%% Generalization to 7T independent dataset

[train,test] = mat_scale(image,independent_image_7T);
[out_train,~] = train_model_svr(train,output,get_default_params(model,param),param);
output_independent_7T = test * out_train.feature_weight + out_train.bias;

%% trial-wise expression

% weight-based
trial_expression = trial_image * out.boot_Z;

% haufe-based
trial_expression = canlab_pattern_similarity(trial_image',out.boot_haufe_Z,'cosine_similarity');