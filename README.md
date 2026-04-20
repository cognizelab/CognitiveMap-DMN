# Repository for "Default mode network facilitates the formation of cognitive maps"

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


## Prerequisites
- MATLAB Dependencies:
	- [CanlabCore](https://github.com/canlab/CanlabCore)
	- [cifti-matlab](https://github.com/Washington-University/cifti-matlab).

- R Dependencies:
  	- For behavioral analyses and linear mixed-effects modeling: dplyr, tidyr, lme4, lmerTest, ggeffects.

- Python Dependencies:
	- For reproducing the figures using Jupyter notebooks: NumPy, Pandas, Matplotlib, SciPy.


## Data Availability
The raw data generated in this study cannot be made publicly available due to restrictions imposed by institutional ethics approval and the informed consent obtained from study participants. Individual-specific brain maps (e.g., fMRI response estimates) are available under restricted access to qualified researchers, contingent upon approval of a data use agreement and compliance with institutional ethics guidelines. Access requests should be submitted to the corresponding author (Prof. Deniz Vatansever, deniz@fudan.edu.cn) and will be reviewed by the institutional data access committee. Requests will typically receive a response within 4 weeks. Approved data will be made available for non-commercial research purposes for a period of 5 years following approval. 
