%% 
% inputs

tol = 1e-4;
func1 = @(lambda) 1e6.*exp(lambda) + ...
    (435e3./lambda).*(exp(lambda) - 1) - ...
    1564e3;

a = 0.001;
b = 0.125;
p0 = 0.05;
max_iter = 100;
%% 
% bisection

[root1, iter1, tab1] = bisection_method_function( ...
    a, b, tol, max_iter, func1 ...
);
%% 
% newton

[root2, iter2, tab2] = newton_method_function( ...
    p0, tol, max_iter, func1 ...
);
%%
fprintf(...
    "bisection; root = %f; iteration = %d\n" + ...
    "newton   ; root = %f; iteration = %d\n", ...
    root1, iter1, root2, iter2 ...
);
%%
figure
fplot(func1)
%%
figure
fplot(func1, [0, 0.2])