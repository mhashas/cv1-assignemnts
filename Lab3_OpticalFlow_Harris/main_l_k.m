clear all
close all
pairs = [["sphere1.ppm", "sphere2.ppm"]; ["synth1.pgm", "synth2.pgm"]];
for idx = 1:2
    path1 = pairs(idx,1);
    path1 = path1{1};
    path2 = pairs(idx,2);
    path2 = path2{1};
    [N, M, ~] = size(imread(path1));
    [Vx, Vy, Xs, Ys] = lucas_kanade(imread(path1),imread(path2));
    figure;imshow(imread(path2));hold on; quiver(Xs,Ys,Vx,Vy); pause(0.5)
end