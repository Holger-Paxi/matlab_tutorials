% close all current open figures
close all;

% inputs
x_vect = 0:0.25:1;
% h_vect = [0.5, 0.25, 0.1, 0.01];
h_vect = [0.5:-0.05:0.15, 0.1:-0.01:0.01];

% input function
syms x
a = 3; b = -5; c = 5; d = 3; e = 2;
func = a.*x.^4 + b.*x.^3 + c.*x^2 + d.*x + e;

% store results
results = {}; % cell class

% calculations
for h = h_vect
    for x0 = x_vect
        
        tab = num_diff_first_deriv_function( ...
            x0, h, func ...
        );
    
        % append tables
        results{end+1} = tab;

    end
end

% merge results
results = vertcat(results{:});

% sort values
results = sortrows(results, ["x value", "step - ""h"""]);
disp(results);
