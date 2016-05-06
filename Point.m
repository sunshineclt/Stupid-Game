classdef Point
    % POINT is a point class :) nothing to say
    
    properties
        x % the point's x coord
        y % the point's y coord
    end
    
    methods
        function obj = Point(x, y)
            obj.x = x;
            obj.y = y;
        end
    end
    
end

