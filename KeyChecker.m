classdef KeyChecker
    % KEYBOARDCHECKER is a wrapper of kbCheck of PTB
    
    properties
        key
    end
    
    methods
        function obj = KeyChecker(keyboardName)
            obj.key = KbName(keyboardName);
        end
        function waitUntilKeyboardCheck(obj)
            while true
                [~, ~, KC] = KbCheck;
                if KC(obj.key)
                    break;
                end
            end
        end
    end
    
end

