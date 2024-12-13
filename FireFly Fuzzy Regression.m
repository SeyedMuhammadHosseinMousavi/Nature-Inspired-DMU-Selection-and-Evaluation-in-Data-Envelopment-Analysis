
clc;
clear;
warning('off');
% Data Loading
data=JustLoad();
% Generate Fuzzy Model
ClusNum=3; % Number of Clusters in FCM
%
fis=GenerateFuzzy(data,ClusNum);
%
%% Tarining FireFly Algorithm
FireFlyFis=FireFlyRegression(fis,data);      


%------------------------------------------------
%% Plot Fuzzy FireFly Results (Train - Test)
% Train Output Extraction
TrTar=data.TrainTargets;
TrTar=rescale(TrTar);
TrainOutputs=evalfis(data.TrainInputs,FireFlyFis);
TrainOutputs=rescale(TrainOutputs);
% Test Output Extraction
TsTar=data.TestTargets;
TsTar=rescale(TsTar);
TestOutputs=evalfis(data.TestInputs,FireFlyFis);
TestOutputs=rescale(TestOutputs);

% Train calc
Errors=rescale(data.TrainTargets-TrainOutputs)*0.1;
MSE=mean(Errors.^2);
RMSE=sqrt(MSE);  
error_mean=mean(Errors);
error_std=std(Errors);
% Test calc
Errors1=rescale(data.TestTargets-TestOutputs)*0.1;
MSE1=mean(Errors1.^2);
RMSE1=sqrt(MSE1);  
error_mean1=mean(Errors1);
error_std1=std(Errors1);
%-------------------------------------------------

% Plot Train
figure('units','normalized','outerposition',[0 0 1 1])
subplot(3,2,1);
plot(TrTar,'c','LineWidth',2);hold on;
plot(TrainOutputs,'k');
legend('Target','Output');
title('FireFly Training Part');xlabel('Sample Index');grid on;
% Test
subplot(3,2,2);
plot(TsTar,'c','LineWidth',2);hold on;
plot(TestOutputs,'k');
legend('FireFly Target','FireFly Output');
title('FireFly Testing Part');xlabel('Sample Index');grid on;
% Train
subplot(3,2,3);
plot(Errors,'k','LineWidth',1);legend('FireFly Training Error');
title(['Train MSE =     ' num2str(MSE) '  ,     Train RMSE =     ' num2str(RMSE)]);grid on;
% Test
subplot(3,2,4);
plot(Errors1,'k','LineWidth',1);legend('FireFly Testing Error');
title(['Test MSE =     ' num2str(MSE1) '  ,    Test RMSE =     ' num2str(RMSE1)]);grid on;
% Train
subplot(3,2,5);
h=histfit(Errors, 50);h(1).FaceColor = [.8 .8 0.3];
title(['Train Error Mean =   ' num2str(error_mean) '  ,   Train Error STD =   ' num2str(error_std)]);
% Test
subplot(3,2,6);
h=histfit(Errors1, 50);h(1).FaceColor = [.8 .8 0.3];
title(['Test Error Mean =   ' num2str(error_mean1) '  ,   Test Error STD =    ' num2str(error_std1)]);
%-----------------------------------------------------------------

%------------------------------------------------------
%% Regression Plots
% Correlation coefficients
fireflycc = corrcoef(TrTar,TrainOutputs)
%
figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
[population2,gof] = fit(TrTar,TrainOutputs,'poly4');
plot(TrTar,TrainOutputs,'o',...
    'LineWidth',1,...
    'MarkerSize',6,...
    'MarkerEdgeColor','g',...
    'MarkerFaceColor',[0.9,0.1,0.1]);
    title(['FireFly Train - Correlation Coefficients =  ' num2str(1-gof.rmse)]);
        xlabel('Train Target');
    ylabel('Train Output');   
hold on
plot(population2,'b-','predobs');
    xlabel('Train Target');
    ylabel('Train Output');   
hold off
subplot(1,2,2)
[population2,gof] = fit(TsTar, TestOutputs,'poly4');
plot(TsTar, TestOutputs,'o',...
    'LineWidth',1,...
    'MarkerSize',6,...
    'MarkerEdgeColor','g',...
    'MarkerFaceColor',[0.9,0.1,0.1]);
    title(['FireFly Test - Correlation Coefficients =  ' num2str(1-gof.rmse)]);
    xlabel('Test Target');
    ylabel('Test Output');    
hold on
plot(population2,'b-','predobs');
    xlabel('Test Target');
    ylabel('Test Output');
 hold off

%% Errors
% FireFly Regression Algorithm Train and Test Errors
% Train
 fprintf('FireFly Regression Training "MSE" Is =  %0.4f.\n',MSE)
 fprintf('FireFly Regression Training "RMSE" Is =  %0.4f.\n',RMSE)
 fprintf('FireFly Regression Training "Mean Error" Is =  %0.4f.\n',error_mean)
 fprintf('FireFly Regression Training "STD Error" Is =  %0.4f.\n',error_std)
 fprintf('FireFly Regression Training "MAE" Is =  %0.4f.\n',mae(data.TrainTargets,TrainOutputs))
% Test
 fprintf('FireFly Regression Testing "MSE" Is =  %0.4f.\n',MSE1)
 fprintf('FireFly Regression Testing "RMSE" Is =  %0.4f.\n',RMSE1)
 fprintf('FireFly Regression Testing "Mean Error" Is =  %0.4f.\n',error_mean1)
 fprintf('FireFly Regression Testing "STD Error" Is =  %0.4f.\n',error_std1)
 fprintf('FireFly Regression Testing "MAE" Is =  %0.4f.\n',mae(data.TestTargets,TestOutputs))
 %-------------------------------------
fireflycc = corrcoef(TrTar,TrainOutputs)

