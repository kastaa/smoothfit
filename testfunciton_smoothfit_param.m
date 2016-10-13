clear all
close all
clc

scorei = zeros(3,6);
scorej = zeros(3,6);
scoreval = 100*ones(3,6);

for i = 40:5:100
    for j = 0.01:0.01:0.06
        [~,score] = testfunction(@smoothtestsonde,i,j);
        close all;
        scoreval(score<scoreval) = score(score<scoreval);
        scorei(score<scoreval) = i;
        scorej(score<scoreval) = j;
    end
end