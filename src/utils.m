classdef utils
   
    methods (Static)
        
        function res = mergeSorted(array_1,array_2)
            
            arguments
                array_1 (1,:) double {mustBeInteger, mustBePositive, utils.mustBeInAscendingOrder} 
                array_2 (1,:) double {mustBeInteger, mustBePositive, utils.mustBeInAscendingOrder} 
            end

            % returns
            %   a sorted array
            
            i_1 = 1;
            i_2 = 1;
            total_length = length(array_1) + length(array_2);
            res = zeros(1, total_length);
            
            for i = 1: total_length
                
                if i_1 > length(array_1)
                    res(i) = array_2(i_2);
                    i_2 = i_2 + 1;
                    continue
                end
                
                if i_2 > length(array_2)
                    res(i) = array_1(i_1);
                    i_1 = i_1 + 1;
                    continue
                end
                
                if array_1(i_1) < array_2(i_2)
                    res(i) = array_1(i_1);
                    i_1 = i_1 + 1;
                else
                    res(i) = array_2(i_2);
                    i_2 = i_2 + 1;
                end
            end
        end

        function res = mergeStrings(first_string, second_string, substitute_char)

            arguments
                first_string string
                second_string string
                substitute_char char
            end

            first_chars = first_string{1}; 
            second_chars = second_string{1}; 
            res = first_chars;
            
            if length(first_chars) ~= length(second_chars)
                res = "";
            end

            count = 0;
        
            for i = 1:length(first_chars)
        
                first_string_char = first_chars(i);
                second_string_char = second_chars(i);
                
                % if the chars differ
                if first_string_char ~= second_string_char

                    % if one of the chars is the substitue_char  
                    if first_string_char == substitute_char || second_string_char == substitute_char
                        res = "";
                        return;
                    end

                    res(i) = substitute_char;
                    count = count + 1;
                end 
        
                if count > 1
                    res = "";
                    return;
                end
            end

            res = string(res);

        end

        function idx = findString(string_array, string)

            idx = -1;
        
            for i = 1:length(string_array)
                if strcmp(string_array(i, :), string)
                    idx = i;
                    return;
                end
            end
            
        end

        function count = countMatches(char_array, pat)

            arguments
                char_array string
                pat pattern
            end

            % returns
            %    how many time the pattern is found in the char array specified

            count = length(strfind(char_array, pat));
        end


        function res = areAllCellsEmpty(cell_array)
        
            res = 1;
            for i = 1:length(cell_array)
                if ~ isempty(cell_array{i})
                    res = 0;
                    return;
                end
            end
        end

        % https://uk.mathworks.com/help/matlab/matlab_prog/argument-validation-functions.html

        function mustBeInAscendingOrder(a)

            if utils.isInAscendingOrder(a) ; return ; end

            eidType = 'mustBeInAscendingOrder:notInAscendingOrder';
            msgType = 'Input must be in ascending order';
            throwAsCaller(MException(eidType,msgType))
        end

        function res = isInAscendingOrder(a)

            res = 1;
            last = 0;

            for i = a 

                if i <= last
                    res = 0;
                    return;
                end
                last = i;
            end 

        end 

        function res = minimumBits(numbers)
            res = ceil(log2(max(numbers)));
        end

        function [x,v] = intlinprogWrapper(C, A, b, variablesNumber, verbose)
            
            % calls intrlinprog setting intcon, lb, ub with the specified variablesNumber
            % sets on or off the display using the verbose parameter

            intcon = 1:variablesNumber;
            lb = zeros(variablesNumber, 1);
            ub = ones(variablesNumber, 1);

            if verbose
                intlinprogOptions = optimoptions('intlinprog');
            else
                intlinprogOptions = optimoptions('intlinprog', Display = 'off');
            end

            [x,v] = intlinprog(C,intcon, A, b, [], [], lb, ub, intlinprogOptions);
        end

    end
end