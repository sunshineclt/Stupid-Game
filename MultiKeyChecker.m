classdef MultiKeyChecker
    % MULTIKEYBOARDCHECKER is a multi-key watcher of kbCheck of PTB
    
    properties
        keys
        number
        lastHitTime
    end
    
    methods
        function obj = MultiKeyChecker(keyboardName)
            obj.number = size(keyboardName, 2);
            for index = 1:obj.number
                obj.keys{1, index} = KbName(keyboardName{1, index});
            end
            obj.lastHitTime = GetSecs - 1e5;
        end
        function key = keyboardCheck(obj)
            while true
                [~, ~, KC] = KbCheck;
                keyRight = check(obj, KC);
                if keyRight ~= -1
                    break;
                end
            end
            key = keyRight;
        end
        function key = keyboardCheckWithDelay(obj, delay)
            while true
                [~, ~, KC] = KbCheck;
                if GetSecs - obj.lastHitTime < delay
                    continue;
                end
                keyRight = check(obj, KC);
                if keyRight ~= -1
                    break;
                end
            end
            key = keyRight;
        end        
    end
    
    methods (Access = private)
        function keyRight = check(obj, KC)
            for index = 1:obj.number
                if KC(obj.keys{1, index})
                    keyRight = index;
                    return
                end
            end
            keyRight = -1;
        end
    end
end

