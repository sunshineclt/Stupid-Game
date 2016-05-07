classdef KeyChecker
    % KEYBOARDCHECKER is a multi-key watcher of kbCheck of PTB
    
    properties
        keys
        number
        lastHitTime
        requiredDelay
    end
    
    methods
        function obj = KeyChecker(keyboardKey, requiredDelay)
            obj.number = size(keyboardKey, 1);
            for index = 1:obj.number
                obj.keys{index, 1} = KbName(keyboardKey{index, 1});
                obj.keys{index, 2} = keyboardKey{index, 2};
            end
            obj.lastHitTime = GetSecs - 1e5;
            if nargin > 1
                obj.requiredDelay = requiredDelay;
            end
        end
        
        function key = keyboardCheck(obj)
            while true
                [~, ~, KC] = KbCheck;
                keyRight = check(obj, KC);
                if keyRight ~= -1
                    if obj.keys{keyRight, 2}
                        if GetSecs() - obj.lastHitTime < obj.requiredDelay
                            continue;
                        end
                    end
                    break;
                end
            end
            key = keyRight;
        end

    end
    
    methods (Access = private)
        function keyRight = check(obj, KC)
            for index = 1:obj.number
                if KC(obj.keys{index, 1})
                    keyRight = index;
                    return
                end
            end
            keyRight = -1;
        end
    end
end

