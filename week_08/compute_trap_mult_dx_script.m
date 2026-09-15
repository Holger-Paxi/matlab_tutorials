%% 
% inputs

% dx_vect = [0.25, 0.1, 0.05]
dx_vect = 0.05:0.05:1;
x_a = 1;
x_b = 3;

func = @(x) exp(x).*(sin(x).^2);
%% 
% calculations

results = {};
for dx = dx_vect
    trap = composite_trapezoidal_function(dx, x_a, x_b, func);
    results{end+1} = trap;
end
%% 
% merge results

results = vertcat(results{:});
%%
disp(results);