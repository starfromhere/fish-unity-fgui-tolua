MathTools = class("MathTools")

function MathTools.vecToAngle(x, y)
    return Mathf.Atan2(y, x) * Mathf.Rad2Deg
end

function MathTools.distance(x1, y1, x2, y2)
    return Mathf.Sqrt(Mathf.Pow(x1 - x2, 2) + Mathf.Pow(y1 - y2, 2))
end