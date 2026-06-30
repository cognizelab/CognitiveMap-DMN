%% =========================================================================
% Generate simulated dataset for m3_SVR demo
%
% This script generates a synthetic regression dataset following the
% encoding model:
%
%       X = sA' + noise
%
% This synthetic regression dataset include:
%   (1) Four target levels (1-4)
%   (2) Subject-specific random effects
%   (3) Correlated feature noise
%   (4) Known ground-truth activation pattern
% The generated dataset is saved as "demo_data.mat".
% =========================================================================

clear; clc;
rng(2025);

%% =========================================================================
% Simulation parameters
% =========================================================================

nSubject = 10;
nLevel   = 4;

N = nSubject * nLevel;
P = 100;

%% =========================================================================
% Labels
% =========================================================================

% Regression target
y = repmat((1:nLevel)', nSubject, 1);

% Subject ID
groupCV = repelem((1:nSubject)', nLevel);

% Latent signal
signal = (y - 2.5) / 1.5;

%% =========================================================================
% Ground-truth activation pattern
% =========================================================================

A = zeros(P,1);

A(1:5)   =  1;
A(11:15) = -1;
A(21:25) =  1;
A(31:35) = -1;

%% =========================================================================
% Correlated feature noise
% =========================================================================

rho = 0.99;

Sigma = toeplitz(rho.^(0:P-1));
L = chol(Sigma,'lower');

noise = randn(N,P) * L';

%% =========================================================================
% Subject-specific random effects
% =========================================================================

subject_effect = randn(nSubject,P) * 0.6;

for s = 1:nSubject

    idx = groupCV == s;

    noise(idx,:) = noise(idx,:) + subject_effect(s,:);

end

%% =========================================================================
% Generate feature matrix
% =========================================================================

x = signal * A' + noise;

% Standardize each feature
x = zscore(x);

%% =========================================================================
% Save dataset
% =========================================================================

save('demo_data.mat', ...
    'x', ...
    'y', ...
    'A', ...
    'groupCV', ...
    'signal', ...
    'nSubject', ...
    'nLevel', ...
    'P');

fprintf('Demo dataset saved to demo_data.mat\n');