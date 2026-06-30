[![DOI](https://doi.org/10.5281/zenodo.19673813.svg)](https://doi.org/10.5281/zenodo.19673813)

# Repository for "Default mode engagement tracks the formation of cognitive maps during naturalistic spatial learning"

Authors: Liangyue Song, Jörn A. Quent, Xinyu Liang, Kaixiang Zhuang and Deniz Vatansever.

This repository contains the codes used for analyses and figures in our manuscript "Default mode network facilitates the formation of cognitive maps".

## Keywords
Cognitive map, Default mode network, Spatial navigation, Multivariate pattern analysis, Spatial learning

## Repository Structure
Here is a detailed guide to the code and files included in this repository:
- ***Main_codes/*** Core scripts for the primary analyses reported in the manuscript.
	- ***MVPA_toolkit***  Comprises a set of analysis functions adapted from the multivariate pattern analysis framework developed by Kaixiang Zhuang and colleagues at Cognize Lab ([cognizelab](https://github.com/cognizelab)), originally released as part of the [semantic retrieval signature project](https://github.com/cognizelab/semantic-retrieval-signature/tree/main/Code/mvpa).
	- ***m1_Behavior_NavigationMetrics.rmd*** Script for processing behavior data to get navigational metrics. 
	- ***m2_Behavior_LMM.rmd*** Script for fitting linear mixed-effects models to characterize behavioral signatures of cognitive map formation.
	- ***m3_Brain_SVR.m*** Script for SVR-based MVPA to predict spatial memory precision, assess predictive performance, and derive the corresponding neural signature.
	- ***m4_Brain_NeurosynthDecoding.m*** Script for surface-based Neurosynth decoding for neural signatures.
	- ***m5_Brain_LMM.rmd***  Script for testing the construct validity of the derived neural signature by modeling trial-wise behavioral metrics of cognitive maps as a function of neural signature expression using linear mixed-effects models.

- ***Figure_codes/***: Jupyter notebooks and MATLAB Live Scripts (.mlx) for reproducing figures and visualizations presented in the manuscript.  
  - ***Figure2_FlowField.ipynb***: Notebook for generating group-level flow field visualizations of navigation behavior.  
  - ***Figure2-4.mlx***: MATLAB Live Scripts for reproducing each main figure (Figures 2–4).  
  - ***Figure_data/***: Precomputed outputs used for figure generation and visualization.

- ***Demo/*** Example scripts demonstrating the complete SVR-based multivariate prediction pipeline using a simulated dataset that mimics subject-level variability and correlated feature noise, illustrating the importance of the Haufe transform for interpreting predictive models.
	- ***demo_generate_data.m*** Generates a simulated dataset with known ground-truth activation patterns, correlated feature noise, and subject-specific random effects.
	- ***demo_main.m*** Demonstrates the complete analysis workflow, including group-based cross-validation, prediction performance evaluation, permutation testing, bootstrap estimation of feature importance, and Haufe transformation for model interpretation.

## Instructions for Demo
The demo is designed to introduce the core **SVR-based multivariate pattern analysis (MVPA)** pipeline implemented in the MVPA Toolkit. Using a simulated dataset with subject-level structure, group-based cross-validation, correlated feature noise, and a known ground-truth activation pattern, it demonstrates both predictive modeling and model interpretation.
The demo can be reproduced in two ways:
1. Load the pre-generated simulated dataset: ***Demo/Data/demo_data.mat***
2. Regenerate the simulated dataset by running: ***Demo/Data/generate_data.m***

Then run: ***Demo/Demo_MVPA*** to execute the complete SVR-based MVPA pipeline, including **group-based cross-validation**, **model training**, **prediction performance evaluation**, **permutation testing**, **bootstrap estimation of feature importance**, **Haufe transformation**, and **comparison of the ground-truth activation pattern, predictive weights, and Haufe-transformed activation patterns**.Typical runtime on the system described above is **less than 5 minutes**.

## Prerequisites
- MATLAB Dependencies:
	- [CanlabCore](https://github.com/canlab/CanlabCore)
	- [cifti-matlab](https://github.com/Washington-University/cifti-matlab).

- R Dependencies:
  	- For behavioral analyses and linear mixed-effects modeling: dplyr, tidyr, lme4, lmerTest, ggeffects.

- Python Dependencies:
	- For reproducing the figures using Jupyter notebooks: NumPy, Pandas, Matplotlib, SciPy.

## System Requirements
The code has been tested on the following environment:
- **Operating system:** macOS (Apple Silicon)
- **Hardware:** Apple Mac mini (2024, Apple M4, 24 GB RAM)
- **MATLAB:** R2024b
- **Python:** 3.9.7
- **R:** 2025.09.0+387
No specialized hardware is required.

## Data Availability
The raw data generated in this study cannot be made publicly available due to restrictions imposed by institutional ethics approval and the informed consent obtained from study participants. Individual-specific brain maps (e.g., fMRI response estimates) are available under restricted access to qualified researchers, contingent upon approval of a data use agreement and compliance with institutional ethics guidelines. Access requests should be submitted to the corresponding author (Prof. Deniz Vatansever, deniz@fudan.edu.cn) and will be reviewed by the institutional data access committee. Requests will typically receive a response within 4 weeks. Approved data will be made available for non-commercial research purposes for a period of 5 years following approval. 
