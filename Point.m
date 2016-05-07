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
        
        function newPoint = move(obj, deltaX, deltaY)
            newPoint = Point(obj.x + deltaX, obj.y + deltaY);
            newPoint = regular(newPoint);
        end
    end
    
    methods (Access = private)
        function newPoint = regular(obj)
            global wrect
            newPoint = obj;
            if newPoint.x < 0
                newPoint.x = newPoint.x + wrect(3);
            end
            if newPoint.y < 0
                newPoint.y = newPoint.y + wrect(4);
            end
            if newPoint.x > wrect(3)
                newPoint.x = newPoint.x - wrect(3);
            end
            if newPoint.y > wrect(4)
                newPoint.y = newPoint.y - wrect(4);
            end
        end
    end
    
end

