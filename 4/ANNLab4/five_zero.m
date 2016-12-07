clear

X = vm([0 0 1 0 1 0 0 1;0 0 0 0 0 1 0 0;0 1 1 0 0 1 0 1])

W = X'*X;%learning
update=sgn(W*X')' %recalling