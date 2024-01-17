%Data Read
%Data Visulization 

% -------- Exploring the Data -------- 

%Data Read
%Read data set into MATLAB as matrix. 
heart_failure = readmatrix('heart_failure_clinical_records_dataset.csv');
fprintf '\nPREPROCESSING DATA:' 

%Data Cleaning
%Determine if every row is unique in data set. 

unique_data = unique(heart_failure,'rows');

if (size(heart_failure) == size(unique_data)); 
    fprintf '\n\nEvery row is unique.' 
else 
    fprintf '\n\nThere are duplicate rows.'
end 

% Determine if any data is missing in data set. 
% heart_failure(1,1) = NaN 

missing_data = ismissing(heart_failure); 

if (missing_data == 0);
   fprintf '\n\nNo data is missing.'
else 
    fprintf '\n\nData missing.'
end 

% -------- Data Visulization -------- 

%Creating a cell array from data file 
%heart_failure = num2cell(heart_failure);
%Working with variable 'DEATH_EVENT' 
%'DEATH_EVENT' is of logical data type where 1 = death event, 0 = survived 

death_event = heart_failure(:,13)
%death_event = cell2mat(death_event)
%tabulate(death_event)

% Extracting data to divide by death event and survived 
death_event =heart_failure (heart_failure(:,13)== 1, 1:13)
survived = heart_failure (heart_failure(:,13)== 0, 1:13)

% confirming matrix dimensions match with the correct value for each 
% variable

sum(heart_failure(:,13) == 1)

sum(heart_failure(:,13) == 0) 

%Further extracting data to sort by death event and survived in male and
%female categories 

male_death_event = death_event(death_event(:,10) == 1, 1:13)
male_survived = death_event(death_event(:,10) == 0, 1:13)

female_death_event = death_event(death_event(:,10) == 1, 1:13)
female_survived = death_event(death_event(:,10) == 0, 1:13)

%Survival rate within each category(Male & Female)

female = heart_failure(heart_failure(:,10) == 0, 1:13)

male = heart_failure(heart_failure(:,10) == 1, 1:13)

%Data Analysis of Age 
min(heart_failure(:,1))
max(heart_failure(:,1))
median(heart_failure(:,1))
std(heart_failure(:,1))
outlier = isoutlier(heart_failure(:,1))

% -------- Comparison -------- 

%Plot on full data
plot(heart_failure(:,1))

%
%Plot graph of Age with Gender
% using built in function: histcounts [N,edges,bin] = histcounts(___)
%nF = females, nM = males, e = edges 
%
figure(1)
binEdges1=[40:10:100];
[nF,e,iF]=histcounts(female(:,1),binEdges1);
[nM,e,iM]=histcounts(male(:,1),binEdges1);
x=mean([e(1:end-1);e(2:end)]);
bar(x,[nM;nF])
xlabel("Age of patients") ;
ylabel("Number of patients") ; 
legend("Male Patient","Female patient") ;
title("Age Distribution Against Gender")

%
%Comparison of age with death_events
%nD = death events, nS = survived, e = edges 
%
figure(2)
binEdges2 = [40:10:100]; 
[nD,e,iD] = histcounts(death_event(:,1),binEdges2)
[nS,e,iS]=histcounts(survived(:,1),binEdges2);
y=mean([e(1:end-1);e(2:end)]);
bar(y,[nS;nD])
xlabel("Age of patients") ;
ylabel("Number of patients") ; 
legend("Survived patient","Deceased patient") ;
title("Age Distribution Against Patient Living Status")

%
% Comparison of creatinine_phosphokinase with death_events
% nD = death events, nCP = creatine phosphokinase, e = edges 
%
figure(3)
binEdges3 = [0:1000:7500]
[nD,e,iD] = histcounts(death_event(:,3),binEdges3)
[nCP,e,iCP]=histcounts(survived(:,3),binEdges3);
z=mean([e(1:end-1);e(2:end)]);
bar(z,[nCP;nD])
xlabel("Creatine Phosphokinase levels (mcg/L)") ;
ylabel("Number of patients") ; 
legend("Survived patient","Deceased patient") ;  
title("Creatine Phosphokinase Levels in Patients Deceased and Living")

%
%Chart comparing diabetes and death events
%
figure(6);
tempDiabetes = heart_failure(:,4);
tempDeath = heart_failure(:,13);
len = height(tempDiabetes);
numOfDiabetes = 0;
numOfDiabetesAndDead = 0;
for k = 1:len

  if(tempDiabetes(k) == 1)
      numOfDiabetes = numOfDiabetes + 1;
    if (tempDeath(k) == 1)
      numOfDiabetesAndDead = numOfDiabetesAndDead +1;
    end
  end
end

numOfDiabetesButNotDead = numOfDiabetes - numOfDiabetesAndDead;
X = [numOfDiabetesAndDead/numOfDiabetes numOfDiabetesButNotDead/numOfDiabetes];
t = tiledlayout(1,2,'TileSpacing','compact');
labels = {'Diabetic and died','Diabetic but survived'};
pie(X,'%.2f%%')
title('Chart of Diabetes Leading to Death Event')
lgd = legend(labels);

%Shows the error/inconsistent data inputed in to the column of Age.
age = heart_failure(:,1);
tempAge = heart_failure(:,1);
len = height(tempAge);

for k = 1:len
    if mod(tempAge(k),1) ~= 0
        tempAge(k) = round(tempAge(k));
        disp("Inconsistency in Age at " +"index" + ": " + k + " , Age should be: " + tempAge(k))
    end
end

%
%Chart comparing Anaemia and Death events
%
figure(7);
tempAnaemia = heart_failure(:,2);
tempDeath = heart_failure(:,13);
len = height(tempAnaemia);
numOfAnaemia = 0;
numOfAnaemiaAndDead = 0;
for j = 1:len

  if(tempAnaemia(j) == 1)
      numOfAnaemia = numOfAnaemia + 1;
    if (tempDeath(j) == 1)
      numOfAnaemiaAndDead = numOfAnaemiaAndDead +1;  
    end
  end
end

numOfAnaemiaButNotDead = numOfAnaemia - numOfAnaemiaAndDead ;
Y = [numOfAnaemiaAndDead/numOfAnaemia numOfAnaemiaButNotDead/numOfAnaemia];
t2 = tiledlayout(1,2,'TileSpacing','compact');
labels = {'Anaemia leading to heart failure','Anaemia but survived'};
pie(Y,'%.2f%%')
title('Chart of Anaemia Leading to Death Event')
lgd2 = legend(labels);


%
%Chart comparing highblood pressure and Death events
% HBP = high blood pressure 
figure(8);
HBP = (heart_failure(:,6));
Death_event = (heart_failure(:,13));
len = height(HBP);
num_HBP= 0;
num_HBP_Dead = 0;
for K = 1:len

  if(HBP(K) == 1)
      num_HBP = num_HBP + 1;
    if (Death_event(K) == 1)
      num_HBP_Dead = num_HBP_Dead+1;  
    end
  end
end

num_HBP_survived = num_HBP - num_HBP_Dead ;
Y = [num_HBP_Dead/num_HBP num_HBP_survived/num_HBP];
t2 = tiledlayout(1,2,'TileSpacing','compact');
labels = {'High Blood Pressure leading to death','High blood pressure but survived'};
pie(Y,'%.2f%%');
title('High Blood Pressure Leading to Death');
lgd3 = legend(labels);
