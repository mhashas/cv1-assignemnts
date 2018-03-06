clear all
close all
pairs = [["sphere1.ppm", "sphere2.ppm"]; ["synth1.pgm", "synth2.pgm"]];
for idx = 1:2
    path1 = pairs(idx,1);
    path1 = path1{1};
    path2 = pairs(idx,2);
    path2 = path2{1};
    [N, M, ~] = size(imread(path1));
    [Vx, Vy] = lucas_kanade(imread(path1),imread(path2));
    Xs = linspace(1,N,floor(N/15));
    Ys = linspace(1,M,floor(M/15));
    [Xs, Ys] = meshgrid(Xs, Ys);
    figure;imshow(imread(path2));hold on; quiver(Xs(:),Ys(:),Vx(:),Vy(:)); pause(0.5)
end