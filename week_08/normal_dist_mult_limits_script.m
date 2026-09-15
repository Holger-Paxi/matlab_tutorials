%% 
% inputs

sigma = 1;
dx = 0.1;
%% 
% limits or boundaries

x_a_vect = -sigma*(1:3);
x_b_vect = sigma*(1:3);
%% 
% function

func = @(x) (1./(sigma.*sqrt(2.*pi)))...
    .*exp(-(1./2).*((x./sigma).^2));
%% 
% calculations

results = {};
for ind = 1:length(x_a_vect)
    % redefine limits
    x_a = x_a_vect(ind);
    x_b = x_b_vect(ind);

    trap = composite_trapezoidal_function(dx, x_a, x_b, func);
    simp = composite_simpson_function(dx, x_a, x_b, func);

    % merging
    results{end+1} = innerjoin(...
        trap, simp, ...
        "Keys", [...
            "x_a", "x_b", "n", "h", "dx", "true_value" ...
        ]...
    );
end
%% 
% merging tables

results = vertcat(results{:});
%% 
% reordering columns

results = results(:, [...
    "x_a", "x_b", "n", "h", "dx", ...
    "true_value", "integ_trap", "integ_simp", ...
    "rel_error_trap", "rel_error_simp" ...
]);
%%
disp(results);