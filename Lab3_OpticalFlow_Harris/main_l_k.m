clear all
close all
pairs = [["sphere1.ppm", "sphere2.ppm"]; ["synth1.pgm", "synth2.pgm"]];

%set to predefined 15 window size and equally separated
window_size = 15;

for idx = 1:2
    path1 = pairs(idx,1);
    path1 = path1{1};
    path2 = pairs(idx,2);
    path2 = path2{1};
    [N, M, ~] = size(imread(path1));
    
    %set box centers we wanna measure flow of
    Xs = zeros(floor(N/15),floor(M/15));
    Ys = zeros(floor(N/15),floor(M/15));
    for i = 1:floor(N/15)
        for j = 1:floor(M/15)
            start_i = (i-1)*15+1;
            end_i = i*15;
            start_j = (j-1)*15+1;
            end_j = j*15;
            Ys(i,j) = start_i + (end_i - start_i) / 2;
            Xs(i,j) = start_j + (end_j - start_j) / 2;
        end
    end
    Ys = Ys(:);
    Xs = Xs(:);

    [Vx, Vy] = lucas_kanade(imread(path1),imread(path2), Xs, Ys, window_size);
    figure;imshow(imread(path2));hold on; quiver(Xs,Ys,Vx,Vy); pause(0.5)
end