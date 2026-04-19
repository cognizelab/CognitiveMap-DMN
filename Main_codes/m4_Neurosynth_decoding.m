%% load data
clear;clc
load('Main_codes/Data/neurosynth.mat');
%% LDA topics
topic_out = cellfun(@isempty,struct2table(LDA100terms).Label);
topic_names = struct2table(LDA100terms).Label(~topic_out);
LDA_clean = [neurosynth_topics.LDA100.L(:,~topic_out);neurosynth_topics.LDA100.R(:,~topic_out)];
%% cognitive terms
all_terms = neurosynth_terms.neurosynth.feature_names;
[terms_in, ~] = ismember(erase(all_terms,' '),erase(cognitive_atlas,' '));
term_names = all_terms(terms_in);term_names = term_names(:);
term_clean = [neurosynth_terms.neurosynth.L(:,terms_in);neurosynth_terms.neurosynth.R(:,terms_in)];
%% load brain image
haufe = cifti_read("Main_codes/SpatialMemorySignature/z_stat_haufe_fsLR32k.dscalar.nii");
pos_haufe = haufe.cdata; pos_haufe(pos_haufe<0)=0;
neg_haufe = haufe.cdata;neg_haufe(neg_haufe>0)=0;neg_haufe = abs(neg_haufe);
%% topic correlations
pearsons_pos_topic=zeros(length(topic_names),1);
for ii = 1:length(topic_names)
    topic_temp = LDA_clean(:,ii);
    pearsons_pos_topic(ii) = corr(pos_haufe(pos_haufe~=0), topic_temp(pos_haufe~=0), 'type', 'Pearson');
end
[pearsons_pos_topic_sort, idx] = sort(pearsons_pos_topic, 'descend');
topic_pos_sort = topic_names(idx);
figure()
wc = wordcloud(topic_pos_sort(pearsons_pos_topic_sort>0.01)', pearsons_pos_topic_sort(pearsons_pos_topic_sort>0.01));
wc.Color = repmat([210 28 72]/255, sum(pearsons_pos_topic_sort>0.01),1);
%%
pearsons_neg_topic=zeros(length(topic_names),1);
for ii = 1:length(topic_names)
    topic_temp = LDA_clean(:,ii);
    pearsons_neg_topic(ii) = corr(neg_haufe(neg_haufe~=0), topic_temp(neg_haufe~=0), 'type', 'Pearson');
end
[pearsons_neg_topic_sort, idx] = sort(pearsons_neg_topic, 'descend');
topic_neg_sort = topic_names(idx);
figure()
wc = wordcloud(topic_neg_sort(pearsons_neg_topic_sort>0.01)', pearsons_neg_topic_sort(pearsons_neg_topic_sort>0.01));
wc.Color = repmat([84 96 190]/255, sum(pearsons_neg_topic_sort>0.01),1);

%% term correlation

pearsons_pos_term=zeros(length(term_names),1);
for ii = 1:length(term_names)
    temp = term_clean(:,ii);
    pearsons_pos_term(ii) = corr(pos_haufe(pos_haufe~=0), temp(pos_haufe~=0), 'type', 'Pearson');
end
[pearsons_pos_term_sort, idx] = sort(pearsons_pos_term, 'descend');
term_pos_sort = term_names(idx);
figure()
wc = wordcloud(term_pos_sort(pearsons_pos_term_sort>0.01)', pearsons_pos_term_sort(pearsons_pos_term_sort>0.01));
wc.Color = repmat([210 28 72]/255, sum(pearsons_pos_term_sort>0.01),1);
%%
pearsons_neg_term=zeros(length(term_names),1);
for ii = 1:length(term_names)
    temp = term_clean(:,ii);
    pearsons_neg_term(ii) = corr(neg_haufe(neg_haufe~=0), temp(neg_haufe~=0), 'type', 'Pearson');
end
[pearsons_neg_term_sort, idx] = sort(pearsons_neg_term, 'descend');
term_neg_sort = term_names(idx);
figure()
wc = wordcloud(term_neg_sort(pearsons_neg_term_sort>0.01)', pearsons_neg_term_sort(pearsons_neg_term_sort>0.01));
wc.Color = repmat([84 96 190]/255, sum(pearsons_neg_term_sort>0.01),1);
