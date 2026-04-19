function out = mat_report_correlation(out,log)

results = {}; descriptions = {}; statistic = @(x) mean(x);

%% -------------------------------------------------- Descriptions ------------------------------------------------------------------
disp('Description:');
%%
currv = sprintf(['The %d folds cross-validation (CV) has been conducted for %d times.\n'], log.ocv);
descriptions = [descriptions;currv]; disp(currv);
disp('---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------');

%% -------------------------------------------------- Overall Model ------------------------------------------------------------------
disp('Overall model evaluation:');
%% r
data = out.model_quality.accuracy_correlation;
try
    CI = bootci(1000, {statistic, data}, 'alpha', 0.05); 
    SE = std(data) / sqrt(length(data));
    
    currv = sprintf(['The overall prediction-outcome correlation coefficient (r) is %.3f (averaged across repetations); the bootstrapped 95%% confidence interval (CI) is [%.3f, %.3f]; the standard error (SE) is %.2f.\n'], mean(data), CI, SE);
    results = [results;currv]; disp(currv);
end

%% r2
data = out.model_quality.R2;
try
    CI = bootci(1000, {statistic, data}, 'alpha', 0.05); 
    SE = std(data) / sqrt(length(data));
    
    currv = sprintf(['The overall prediction-outcome explained variance score (EVS, r2) is %.3f (averaged across repetations); the bootstrapped 95%% confidence interval (CI) is [%.3f, %.3f]; the standard error (SE) is %.2f.\n'], mean(data), CI, SE);
    results = [results;currv]; disp(currv);
end

%% MAE
data = out.model_quality.MAE;
try
    CI = bootci(1000, {statistic, data}, 'alpha', 0.05); 
    SE = std(data) / sqrt(length(data));
    
    currv = sprintf(['The overall prediction-outcome mean absolute error (MAE) is %.3f (averaged across repetations); the bootstrapped 95%% confidence interval (CI) is [%.3f, %.3f]; the standard error (SE) is %.2f.\n'], mean(data), CI, SE);
    results = [results;currv]; disp(currv);
end

%% RMSE
data = out.model_quality.RMSE;
try
    CI = bootci(1000, {statistic, data}, 'alpha', 0.05); 
    SE = std(data) / sqrt(length(data));
    
    currv = sprintf(['The overall prediction-outcome root mean squared error (RMSE) is %.3f (averaged across repetations); the bootstrapped 95%% confidence interval (CI) is [%.3f, %.3f]; the standard error (SE) is %.2f.\n'], mean(data), CI, SE);
    results = [results;currv]; disp(currv);
end
disp('---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------');

%% -------------------------------------------------- Model across Folds ------------------------------------------------------------------
disp('Fold-specific model evaluation:');
%% r
data = out.model_quality.accuracy_correlation_folds;
try
    CI = bootci(1000, {statistic, data}, 'alpha', 0.05); 
    SE = std(data) / sqrt(length(data));
    
    currv = sprintf(['The fold-specific prediction-outcome correlation coefficient (r) is %.3f (averaged across folds); the bootstrapped 95%% confidence interval (CI) is [%.3f, %.3f]; the standard error (SE) is %.2f.\n'], mean(data), CI, SE);
    results = [results;currv]; disp(currv);
end

%% r2
data = out.model_quality.R2_folds;
try
    CI = bootci(1000, {statistic, data}, 'alpha', 0.05); 
    SE = std(data) / sqrt(length(data));
    
    currv = sprintf(['The fold-specific prediction-outcome explained variance score (EVS, r2) is %.3f (averaged across folds); the bootstrapped 95%% confidence interval (CI) is [%.3f, %.3f]; the standard error (SE) is %.2f.\n'], mean(data), CI, SE);
    results = [results;currv]; disp(currv);
end

%% MAE
data = out.model_quality.MAE_folds;
try
    CI = bootci(1000, {statistic, data}, 'alpha', 0.05); 
    SE = std(data) / sqrt(length(data));
    
    currv = sprintf(['The fold-specific prediction-outcome mean absolute error (MAE) is %.3f (averaged across folds); the bootstrapped 95%% confidence interval (CI) is [%.3f, %.3f]; the standard error (SE) is %.2f.\n'], mean(data), CI, SE);
    results = [results;currv]; disp(currv);
end

%% RMSE
data = out.model_quality.RMSE_folds;
try
    CI = bootci(1000, {statistic, data}, 'alpha', 0.05); 
    SE = std(data) / sqrt(length(data));
    
    currv = sprintf(['The fold-specific prediction-outcome root mean squared error (RMSE) is %.3f (averaged across folds); the bootstrapped 95%% confidence interval (CI) is [%.3f, %.3f]; the standard error (SE) is %.2f.\n'], mean(data), CI, SE);
    results = [results;currv]; disp(currv);
end
disp('---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------');

%%
out.results = results;
out.descriptions = descriptions;