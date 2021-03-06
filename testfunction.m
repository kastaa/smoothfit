function [scoret,score] = testfunction(ff,varargin)

load('data_simSNR.mat');
score = zeros(3,6);
x = 1:670;
if nargin(ff)==2
    for u = 1:3
        for i = 1:6
            mat = datas{u}.SNR{i};
            err = zeros(10,1);
            for j = 1:10
                [yyfin] = ff(x,mat(j,:));
                err(j) = sum(abs((yyfin-datas{u}.theo)));
            end
            score(u,i) = mean(err)./sum(datas{u}.theo);
        end
    end
elseif nargin(ff)==3
    for u = 1:3
        for i = 1:6
            mat = datas{u}.SNR{i};
            err = zeros(10,1);
            for j = 1:10
                [yyfin] = ff(mat(j,:),varargin{1},varargin{2});
                err(j) = sum(abs((yyfin-datas{u}.theo)));
            end
            score(u,i) = mean(err)./sum(datas{u}.theo);
        end
    end
end

scoret = mean(score');
figure()
bar(score);
