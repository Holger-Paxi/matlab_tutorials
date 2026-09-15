%% 
% inputs

sigma = 1;
dx = 0.1;
%% 
% limits or boundaries

x_a = -sigma;
x_b = sigma;
%% 
% function

func = @(x) (1./(sigma.*sqrt(2.*pi)))...
    .*exp(-(1./2).*((x./sigma).^2));
%% 
% calculations

trap = composite_trapezoidal_function(dx, x_a, x_b, func);
simp = composite_simpson_function(dx, x_a, x_b, func);

% merging
results = innerjoin(...
    trap, simp, ...
    "Keys", [...
        "x_a", "x_b", "n", "h", "dx", "true_value" ...
    ]...
);
%% 
% reordering columns

results = results(:, [...
    "x_a", "x_b", "n", "h", "dx", ...
    "true_value", "integ_trap", "integ_simp", ...
    "rel_error_trap", "rel_error_simp" ...
]);
%%
disp(results);