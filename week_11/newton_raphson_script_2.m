classdef newton_raphson_app_2 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                   matlab.ui.Figure
        answer                     matlab.ui.control.Label
        UITable                    matlab.ui.control.Table
        sym_dfunc                  matlab.ui.control.Label
        sym_func                   matlab.ui.control.Label
        error_msg                  matlab.ui.control.Label
        closeButton                matlab.ui.control.Button
        resetButton                matlab.ui.control.Button
        executeButton              matlab.ui.control.Button
        equation                   matlab.ui.control.EditField
        equationLabel              matlab.ui.control.Label
        maxnumberiterations        matlab.ui.control.NumericEditField
        maxnumberiterationsLabel   matlab.ui.control.Label
        errortolerance             matlab.ui.control.NumericEditField
        errortoleranceLabel        matlab.ui.control.Label
        initialguess               matlab.ui.control.NumericEditField
        initialguessLabel          matlab.ui.control.Label
        OutputsLabel               matlab.ui.control.Label
        InputsLabel                matlab.ui.control.Label
        NewtonRaphsonMethondLabel  matlab.ui.control.Label
        UIAxes_convergence         matlab.ui.control.UIAxes
        UIAxes_func                matlab.ui.control.UIAxes
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: executeButton
        function executeButtonPushed(app, event)
            p0 = app.initialguess.Value;
            tol = app.errortolerance.Value;
            max_iter = app.maxnumberiterations.Value;
            func = str2func(app.equation.Value);

            % start of the function
            % symbolic derivatives

            syms x
            func_sym = func(x);
            dfunc_sym = diff(func_sym, x);

            % derivative function

            dfunc = matlabFunction(dfunc_sym, "Vars", x);

            % step 1
            iter = 1;

            results = table();

            % step 2
            while iter <= max_iter
                % step 3
                f_p0 = func(p0);
                df_p0 = dfunc(p0);
                p = p0 - f_p0./df_p0;

                f_p = func(p);  % not necessary
                results(end+1,:) = table( ...
                    iter, p0, p, f_p0, df_p0, f_p ...
                    );
                % convergence flag
                converged = false;

                % step 4
                if abs(p - p0) < tol
                    converged = true;
                    msg = sprintf("the method converged successfully");
                    break
                end

                % step 5
                iter = iter + 1;

                % step 6
                p0 = p;

            end
            % end of the function

            if ~converged
                msg = sprintf("the method failed after %d iteration", max_iter);
            end

            %
            app.error_msg.Text = msg;
            app.answer.Text = sprintf("root = %f; at iteration = %d", p, iter);
            app.sym_func.Interpreter = 'latex';
            app.sym_func.Text = ['$f(x) = ' latex(func_sym) '$'];
            app.sym_dfunc.Interpreter = 'latex';
            app.sym_dfunc.Text = ['$f''(x) = ' latex(dfunc_sym) '$'];

            app.UITable.Data = results;
            app.UITable.ColumnName = [...
                "iter", "p0", "p", "f_p0", "df_p0", "f_p"...
            ];
            fplot(app.UIAxes_func, func)
            yline(app.UIAxes_func, 0, ':')
            plot(app.UIAxes_convergence, results.iter, abs(results.p - results.p0))
        end

        % Button pushed function: resetButton
        function resetButtonPushed(app, event)
            app.initialguess.Value = 1;
            app.errortolerance.Value = 1e-5;
            app.maxnumberiterations.Value = 100;
            app.equation.Value = "@(x) x.^2 - 4.*x + 4 - log(x)";

            app.error_msg.Text = "";
            app.answer.Text = "";
            app.sym_func.Text = "";
            app.sym_dfunc.Text = "";

            app.UITable.Data = [];
            app.UITable.ColumnName = [];
            cla(app.UIAxes_func)
            cla(app.UIAxes_convergence)
        end

        % Button pushed function: closeButton
        function closeButtonPushed(app, event)
            delete(app)
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 714 792];
            app.UIFigure.Name = 'MATLAB App';

            % Create UIAxes_func
            app.UIAxes_func = uiaxes(app.UIFigure);
            title(app.UIAxes_func, 'Title')
            xlabel(app.UIAxes_func, 'X')
            ylabel(app.UIAxes_func, 'Y')
            zlabel(app.UIAxes_func, 'Z')
            app.UIAxes_func.Position = [47 25 300 185];

            % Create UIAxes_convergence
            app.UIAxes_convergence = uiaxes(app.UIFigure);
            title(app.UIAxes_convergence, 'Title')
            xlabel(app.UIAxes_convergence, 'X')
            ylabel(app.UIAxes_convergence, 'Y')
            zlabel(app.UIAxes_convergence, 'Z')
            app.UIAxes_convergence.Position = [376 25 300 185];

            % Create NewtonRaphsonMethondLabel
            app.NewtonRaphsonMethondLabel = uilabel(app.UIFigure);
            app.NewtonRaphsonMethondLabel.HorizontalAlignment = 'center';
            app.NewtonRaphsonMethondLabel.FontSize = 24;
            app.NewtonRaphsonMethondLabel.Position = [186 750 293 30];
            app.NewtonRaphsonMethondLabel.Text = 'Newton Raphson Methond';

            % Create InputsLabel
            app.InputsLabel = uilabel(app.UIFigure);
            app.InputsLabel.FontSize = 18;
            app.InputsLabel.Position = [40 729 54 22];
            app.InputsLabel.Text = 'Inputs';

            % Create OutputsLabel
            app.OutputsLabel = uilabel(app.UIFigure);
            app.OutputsLabel.FontSize = 18;
            app.OutputsLabel.Position = [41 531 68 22];
            app.OutputsLabel.Text = 'Outputs';

            % Create initialguessLabel
            app.initialguessLabel = uilabel(app.UIFigure);
            app.initialguessLabel.HorizontalAlignment = 'right';
            app.initialguessLabel.Position = [82 685 68 22];
            app.initialguessLabel.Text = 'initial guess';

            % Create initialguess
            app.initialguess = uieditfield(app.UIFigure, 'numeric');
            app.initialguess.Position = [165 685 100 22];
            app.initialguess.Value = 1;

            % Create errortoleranceLabel
            app.errortoleranceLabel = uilabel(app.UIFigure);
            app.errortoleranceLabel.HorizontalAlignment = 'right';
            app.errortoleranceLabel.Position = [67 646 83 22];
            app.errortoleranceLabel.Text = 'error tolerance';

            % Create errortolerance
            app.errortolerance = uieditfield(app.UIFigure, 'numeric');
            app.errortolerance.Placeholder = '1e-10';
            app.errortolerance.Position = [165 646 100 22];
            app.errortolerance.Value = 1e-05;

            % Create maxnumberiterationsLabel
            app.maxnumberiterationsLabel = uilabel(app.UIFigure);
            app.maxnumberiterationsLabel.HorizontalAlignment = 'right';
            app.maxnumberiterationsLabel.Position = [26 607 124 22];
            app.maxnumberiterationsLabel.Text = 'max number iterations';

            % Create maxnumberiterations
            app.maxnumberiterations = uieditfield(app.UIFigure, 'numeric');
            app.maxnumberiterations.Placeholder = '100';
            app.maxnumberiterations.Position = [165 607 100 22];
            app.maxnumberiterations.Value = 100;

            % Create equationLabel
            app.equationLabel = uilabel(app.UIFigure);
            app.equationLabel.HorizontalAlignment = 'right';
            app.equationLabel.Position = [99 568 51 22];
            app.equationLabel.Text = 'equation';

            % Create equation
            app.equation = uieditfield(app.UIFigure, 'text');
            app.equation.Placeholder = '@(x) x.^2 - 4.*x + 4 - log(x)';
            app.equation.Position = [165 568 510 22];
            app.equation.Value = '@(x) x.^2 - 4.*x + 4 - log(x)';

            % Create executeButton
            app.executeButton = uibutton(app.UIFigure, 'push');
            app.executeButton.ButtonPushedFcn = createCallbackFcn(app, @executeButtonPushed, true);
            app.executeButton.Position = [456 685 100 23];
            app.executeButton.Text = 'execute';

            % Create resetButton
            app.resetButton = uibutton(app.UIFigure, 'push');
            app.resetButton.ButtonPushedFcn = createCallbackFcn(app, @resetButtonPushed, true);
            app.resetButton.Position = [456 646 100 23];
            app.resetButton.Text = 'reset';

            % Create closeButton
            app.closeButton = uibutton(app.UIFigure, 'push');
            app.closeButton.ButtonPushedFcn = createCallbackFcn(app, @closeButtonPushed, true);
            app.closeButton.Position = [456 607 100 23];
            app.closeButton.Text = 'close';

            % Create error_msg
            app.error_msg = uilabel(app.UIFigure);
            app.error_msg.BackgroundColor = [0 0 0];
            app.error_msg.Position = [44 495 632 26];
            app.error_msg.Text = '';

            % Create sym_func
            app.sym_func = uilabel(app.UIFigure);
            app.sym_func.BackgroundColor = [0 0 0];
            app.sym_func.Position = [44 418 632 26];
            app.sym_func.Text = '';

            % Create sym_dfunc
            app.sym_dfunc = uilabel(app.UIFigure);
            app.sym_dfunc.BackgroundColor = [0 0 0];
            app.sym_dfunc.Position = [44 380 632 26];
            app.sym_dfunc.Text = '';

            % Create UITable
            app.UITable = uitable(app.UIFigure);
            app.UITable.ColumnName = {'Column 1'; 'Column 2'; 'Column 3'; 'Column 4'};
            app.UITable.RowName = {};
            app.UITable.Position = [44 224 632 135];

            % Create answer
            app.answer = uilabel(app.UIFigure);
            app.answer.BackgroundColor = [0 0 0];
            app.answer.Position = [44 456 632 26];
            app.answer.Text = '';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = newton_raphson_app_2

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end
