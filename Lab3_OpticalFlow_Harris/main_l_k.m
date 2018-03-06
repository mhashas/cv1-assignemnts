[Vx, Vy] = lucas_kanade(imread('sphere1.ppm'),imread('sphere2.ppm'));
Xs = linspace(1,N,floor(N/15));
Ys = linspace(1,M,floor(M/15));
[Xs, Ys] = meshgrid(Xs, Ys);


figure;imshow(imread('sphere2.ppm'));hold on; quiver(Xs(:),Ys(:),Vx(:),Vy(:))