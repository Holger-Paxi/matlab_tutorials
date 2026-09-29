func = @(x) x.^2 - 4.*x + 4 - log(x);

a1 = 1; b1 = 2;
a2 = 2; b2 = 4;
max_iter = 100;

% tolerance
tol = 1e-5;
%%
[root1, iter1, tab1] = bisection_method_function(...
    a1, b1, tol, max_iter, func ...
);
[root2, iter2, tab2] = bisection_method_function( ...
    a2, b2, tol, max_iter, func ...
);
%%
fprintf("root1 = %f; iteration = %d\nroot2 = %f; iteration = %d\n", ...
    root1, iter1, root2, iter2...
)
%% 
% figure

figure
hold on
fplot(func, [1, 4], 'b:')
plot(tab1.p, tab1.f_p, 'r--o')
plot(tab2.p, tab2.f_p, 'g--o')
grid on
xlabel('x');
ylabel('f(x)');
title('Bisection Method Results');
legend('Function', 'Root 1', 'Root 2');
axis equal
hold off
%%
figure
hold on
plot(tab1.iter, tab1.f_p, 'r--s')
plot(tab2.iter, tab2.f_p, 'g:o')
grid on
xlabel("iteration")
ylabel("f(x)")
title("bisection method convergence")
legend("root 1", "root 2")
% ylim([-0.01, 0.01])
hold off
%%
figure
hold on
plot(tab1.iter, abs(tab1.f_p), 'r--s')
plot(tab2.iter, abs(tab2.f_p), 'g:o')
grid on
xlabel("iteration")
ylabel("|f(x)|")
title("bisection method convergence")
legend("root 1", "root 2")
set(gca, "YScale", "log")
hold off