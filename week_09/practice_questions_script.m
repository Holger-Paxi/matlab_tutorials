%% 
% Question 1.a - bisection method

func1 = @(x) sqrt(x) - cos(x);

a1 = 0;
b1 = 1;

max_iter = 100;
tol = 1e-5;
%% 
% plotting the func1

figure
fplot(func1)
yline(0)
figure
fplot(func1, [0, 50])
yline(0)
%%
[root1, iter1, tab1] = bisection_method_function(...
    a1, b1, tol, max_iter, func1 ...
);
fprintf("Root: %.6f, Iterations: %d\n", root1, iter1)
disp(tab1)
%% 
% Question 1.b - bisection method

func2 = @(x) x.^4 - 2.*x.^3 - 4.*x.^2 + 4.*x + 4;

intervals = [-2, -1; -1, 0; 1, 2; 2, 3];
%%
figure
fplot(func2)
yline(0)
figure
fplot(func2, [-2, -1])
yline(0)
figure
fplot(func2, [-1, 0])
yline(0)
figure
fplot(func2, [1, 2])
yline(0)
figure
fplot(func2, [2, 3])
yline(0)
% 4 roots
%%
for interval = intervals'
    a = interval(1);
    b = interval(2);

    [root, iter, table] = bisection_method_function(...
        a, b, tol, max_iter, func2 ...
    );
    fprintf("Root: %.6f, Iterations: %d\n", root, iter)
    disp(table)
end
%% 
% Question 3.a - newton's method

func3 = @(x) x.^3 + 3.*x.^2 - 1;

p0_vect = [-2.5, -0.5, 0.5];
%%
figure
fplot(func3)
yline(0)
figure
fplot(func3, [-3, -2])
yline(0)
figure
fplot(func3, [-2, 0])
yline(0)
figure
fplot(func3, [0, 1])
yline(0) % 3 roots
%%
for p0 = p0_vect
    [root, iter, table] = newton_method_function(...
        p0, tol, max_iter, func3...
    );
    fprintf("Root: %.6f, Iterations: %d\n", root, iter)
    disp(table)
end
%% 
% Question 3.b - newton's method

func4 = @(x) exp(-x) - sin(x);

p0 = 0.25;
%%
figure
fplot(func4)
yline(0)
figure
fplot(func4, [0, 100])
yline(0)
ylim([-1, 1])
figure
fplot(func4, [0, 1])
yline(0)
figure
fplot(func4, [2.5, 3.5])
yline(0)
figure
fplot(func4, [5.5, 6.5])
yline(0)
figure
fplot(func4, [9, 10])
yline(0) % infinite roots
%%
[root4, iter4, table4] = newton_method_function(...
    p0, tol, max_iter, func4...
    );
fprintf("Root: %.6f, Iterations: %d\n", root4, iter4)
disp(table4)