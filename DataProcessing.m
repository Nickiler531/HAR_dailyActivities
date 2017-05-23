%% First step, separate gravity component

% Design filter
fhp = hpfilter;

% "Decouple" acceleration due to body dynamics from gravity
a_decouple = filter(fhp,Data{900,1}(:,1));

%compare results for 1 axis (walking)
period = 1/32;
t=1:period:500;

time_index = size(Data{900,1}(:,3),1);
plot(t(1:time_index), Data{900,1}(:,1),'LineWidth',1.5);
hold on
plot(t(1:time_index), a_decouple,'LineWidth',1.5);

% Customize axis box for current subplot
grid on
xlabel('time (s)')
ylabel('a_z (m s^{-2})')
xlim([t(1), t(time_index)])

legend('a_x', 'a_x without gravity influence')

%% Plot autocorrelation

[c, lags] = xcorr(a_decouple);

tmindist = 0.3;
minpkdist = floor(tmindist/(1/32));
[pks,locs] = findpeaks(c,'minpeakprominence',1e4,...
    'minpeakdistance',minpkdist);

% Plot autocorrelation and three key peaks
tc = (1/fs)*lags;
plot(tc,c,'.-')
grid on
hold on
plot(tc(locs),c(locs),'rs')
hold off
xlim([-5,5])
addActivityLegend(1)
xlabel('Time lag (s)')
ylabel('Correlation')

%% Plot specrtral density power

% PSD with numerical output
[p,f] = pwelch(a_decouple,[],[],[],32);

% Find max 8 peaks, at least 0.25Hz apart from each other and with a given
% prominence value

fmindist = 0.25;                    % Minimum distance in Hz
N = 2*(length(f)-1);                % Number of FFT points
minpkdist = floor(fmindist/(32/N)); % Minimum number of frequency bins

[pks,locs] = findpeaks(p,'npeaks',8,'minpeakdistance',minpkdist,...
    'minpeakprominence', 0.01);

% Plot PSD and overlay peaks
plot(f,db(p),'.-')
grid on
hold on
plot(f(locs),db(pks),'rs')
hold off
addActivityLegend(1)
title('Power Spectral Density with Peaks Estimates')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')

%% Run in every data

%This extracts the 66 features in each data point
for i = 1:size(Data,1)
    feat(i,1) = Data{i,2};
    feat(i,2:67)=featuresFromBuffer(Data{i,1}(:,1),Data{i,1}(:,2),Data{i,1}(:,3),32); %32 is the frequency of the data used
end
%The result matrix feat contains the classes in the column 1 and the
%extracted features in the rest

% Now Classifier toolbox can be used to classify...

%% Eliminate the data with less than 120 data
% clases to keep: 2, 5, 8, 10, 11, 12, 14

feat_reduced = feat(find(feat(:,1)==2 | feat(:,1)==5 | feat(:,1)==8 | feat(:,1)==10 | feat(:,1)==11 | feat(:,1)==12 |feat(:,1)==14 ),:);

%% Lets try PCA now

[coeff,score,latent,tsquared,explained] = pca(feat(:,2:end));

feat_pca=feat;
feat_pca(:,2:end)= feat(:,2:end)*coeff;

feat_pca_reduced = feat_pca(:,1:41);

%% Lets test if a reduction of characteristics can be made

%First calculate the sum of the absolute value of rows in the coeff matrix
impact = sum(abs(coeff),2)./sum(sum(abs(coeff)));

%% Add a dummy characteristic to see if the analysis is correct

dummy_pca=[feat_pca, ones(size(feat_pca,1),1)];
[dummycoeff,dummyscore,dummylatent,dummytsquared,dummyexplained] = pca(dummy_pca(:,2:end));
dummyimpact = sum(abs(dummycoeff),2)./sum(sum(abs(dummycoeff)));
dummyimpact2 = sum(abs(dummycoeff),1)./sum(sum(abs(dummycoeff)));