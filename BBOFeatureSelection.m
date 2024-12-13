

clc;
clear;
close all;
warning('off');

%% Problem Definition
data=LoadData();
nf=5;   % Desired Number of Selected Features
CostFunction=@(u) FeatureSelectionCost(u,nf,data);        % Cost Function
nVar=data.nx;
VarSize = [1 nVar];   % Decision Variables Matrix Size
VarMin = -10;         % Decision Variables Lower Bound
VarMax = 10;         % Decision Variables Upper Bound

%% BBO Parameters

MaxIt = 100;          % Maximum Number of Iterations
nPop = 6;            % Number of Habitats (Population Size)
KeepRate = 0.2;                   % Keep Rate
nKeep = round(KeepRate*nPop);     % Number of Kept Habitats
nNew = nPop-nKeep;                % Number of New Habitats
% Migration Rates
mu = linspace(1, 0, nPop);          % Emmigration Rates
lambda = 1-mu;                      % Immigration Rates
alpha = 0.9;
pMutation = 0.1;
sigma = 0.02*(VarMax-VarMin);

%% Initialization
% Empty Habitat
habitat.Position = [];
habitat.Cost = [];
habitat.out = [];
% Create Habitats Array
pop = repmat(habitat, nPop, 1);
% Initialize Habitats
for i = 1:nPop
pop(i).Position = unifrnd(VarMin, VarMax, VarSize);
[pop(i).Cost, pop(i).out] = CostFunction(pop(i).Position);
end
% Sort Population
[~, SortOrder] = sort([pop.Cost]);
pop = pop(SortOrder);
% Best Solution Ever Found
BestSol = pop(1);
% Array to Hold Best Costs
BestCost = zeros(MaxIt, 1);

%% BBO Main Loop
for it = 1:MaxIt
newpop = pop;
for i = 1:nPop
for k = 1:nVar
% Migration
if rand <= lambda(i)
% Emmigration Probabilities
EP = mu;
EP(i) = 0;
EP = EP/sum(EP);
% Select Source Habitat
j = RouletteWheelSelection(EP);
% Migration
newpop(i).Position(k) = pop(i).Position(k) ...
+alpha*(pop(j).Position(k)-pop(i).Position(k));
end
% Mutation
if rand <= pMutation
newpop(i).Position(k) = newpop(i).Position(k)+sigma*randn;
end
end
% Apply Lower and Upper Bound Limits
newpop(i).Position = max(newpop(i).Position, VarMin);
newpop(i).Position = min(newpop(i).Position, VarMax);
% Evaluation
newpop(i).Cost = CostFunction(newpop(i).Position);
end
% Sort New Population
[~, SortOrder] = sort([newpop.Cost]);
newpop = newpop(SortOrder);
% Select Next Iteration Population
pop = [pop(1:nKeep)
newpop(1:nNew)];
% Sort Population
[~, SortOrder] = sort([pop.Cost]);
pop = pop(SortOrder);
% Update Best Solution Ever Found
BestSol = pop(1);
% Store Best Cost Ever Found
BestCost(it) = BestSol.Cost;
% Show Iteration Information
disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
end
%% Itr
figure;
% plot(BestCost, 'LineWidth', 2);
semilogy(BestCost,'k-', 'LineWidth', 2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;




% BBO Feature Matrix
% Extracting Data
RealData=data.x';
% Extracting Labels
RealLbl=data.t';
FinalFeaturesInd=BestSol.out.S;
% Sort Features
FFI=sort(FinalFeaturesInd);
% Select Final Features
BBO_Features=RealData(:,FFI);
% Adding Labels
BBO_Features_Lbl=BBO_Features;
BBO_Features_Lbl(:,end+1)=RealLbl;
BBOFinal=BBO_Features_Lbl;

%% DEA Part after BBO
x=BBOFinal(:,1:end-1)';
y=BBOFinal(:,end)';

% Calc Efficiency for All DMUs

E1 = GetCCREfficiency(x, y);es=size(E1);
es=es(1,1);
BBOCCR=sum(E1)/50;
E2 = GetIOBCCEfficiency(x, y);BBOIOBCC=sum(E2)/50;
E3 = GetOOBCCEfficiency(x, y);BBOOOBCC=sum(E3)/50;
E4 = GetAdditiveEfficiency(x, y);BBOADD=sum(E4)/50;
E = [E1 E2 E3 E4];
Emin = min(E,[],2);
Emax = max(E,[],2);

%% Plot Results
figure;
bar(E);
legend('CCR','IO-BCC','OO-BCC','Additive');
% Average Eff
sizeE=size(E);
sizeE=sizeE(1,1)*sizeE(1,2);
Eff=sum(sum(E));
BBO_Eff=Eff/sizeE;

%% DEA Part on Original
xx=data.x;
yy=data.t;

% Calc Efficiency for All DMUs
Ee1 = GetCCREfficiency(xx, yy);CCR=sum(Ee1)/50;
Ee2 = GetIOBCCEfficiency(xx, yy);IOBCC=sum(Ee2)/50;
Ee3 = GetOOBCCEfficiency(xx, yy);OOBCC=sum(Ee3)/50;
Ee4 = GetAdditiveEfficiency(xx, yy);ADD=sum(Ee4)/50;
Ee = [Ee1 Ee2 Ee3 Ee4];
Eemin = min(Ee,[],2);
Eemax = max(Ee,[],2);

%% Plot Results
figure;
bar(Ee);
legend('CCR','IO-BCC','OO-BCC','Additive');
% Average Eff
sizeEe=size(Ee);
sizeEe=sizeEe(1,1)*sizeEe(1,2);
Eeff=sum(sum(Ee));
Basic_Eff=Eeff/sizeEe;

%% Statistics
fprintf('BBO DEA Average Is =  %0.4f.\n',BBO_Eff);
fprintf('DEA Average Is =  %0.4f.\n',Basic_Eff);
fprintf('BBO CCR Is=  %0.4f.\n',BBOCCR);
fprintf('CCR Is =  %0.4f.\n',CCR);
fprintf('BBO IOBCC Is=  %0.4f.\n',BBOIOBCC);
fprintf('IOBCC Is =  %0.4f.\n',IOBCC);
fprintf('BBO OOBCC Is=  %0.4f.\n',BBOOOBCC);
fprintf('OOBCC Is =  %0.4f.\n',OOBCC);
fprintf('BBO Add Is=  %0.4f.\n',BBOADD);
fprintf('Add Is =  %0.4f.\n',ADD);



