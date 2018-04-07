labels = double(rand(10,1)>0.5);
data = rand(10,5);
model = train(labels, sparse(data), '-c 1 -s 2');