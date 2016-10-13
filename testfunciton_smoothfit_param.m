clear all
close all
clc

scorept = zeros(3,6);
scoreval = 100*ones(3,6);
bestpt = 0;
bf = 0;
bn = 0;

for i = 40:5:100
    for j = 0.01:0.01:0.06
        [~,score] = testfunction(@smoothtestsonde,i,j);
        close all;
        scoretemp = score-scoreval;
        scorept = scoretemp<=0;
        if sum(sum(scorept))>bestpt
            bestpt = sum(sum(scorept));
            bf = i;
            bn = j;
            scoreval = score;
        end   
        if i == 40 && j == 0.01
            bestpt = 0;
        end
    end
end