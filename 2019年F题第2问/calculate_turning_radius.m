function radius = calculate_turning_radius(l1, l2, l3)
    load data
    %data(1,:) = [];
    pointA = [data(l1,2),data(l1,3),data(l1,4)];
    pointB = [data(l2,2),data(l2,3),data(l2,4)];
    pointC = [data(l3,2),data(l3,3),data(l3,4)];
% 计算两个向量
    vecAB = pointB - pointA;
    vecAC = pointC - pointA;

    % 计算平面的法向量
    normal = cross(vecAB, vecAC);

    % 找到平面上的一个点（取中点）
    midPoint = (pointA + pointB + pointC) / 3;

    % 计算投影到平面的三个点
    projA = project_to_plane(pointA, midPoint, normal);
    projB = project_to_plane(pointB, midPoint, normal);
    projC = project_to_plane(pointC, midPoint, normal);

    % 在平面上计算半径（仅考虑 x, y 坐标）
    radius = calculate_turning_radius_2d(projA(1:2), projB(1:2), projC(1:2));
end

function pointOnPlane = project_to_plane(point, planePoint, planeNormal)
    % 计算点到平面的垂直距离
    vecToPoint = point - planePoint;
    distance = dot(vecToPoint, planeNormal) / norm(planeNormal);

    % 将点投影到平面
    pointOnPlane = point - distance * planeNormal / norm(planeNormal);
end

function radius = calculate_turning_radius_2d(pointA, pointB, pointC)
    % 计算两个中点
    midAB = (pointA + pointB) / 2;
    midBC = (pointB + pointC) / 2;

    % 计算两条线段的斜率
    slopeAB = (pointB(2) - pointA(2)) / (pointB(1) - pointA(1));
    slopeBC = (pointC(2) - pointB(2)) / (pointC(1) - pointB(1));

    % 计算中垂线的斜率
    slopeMidAB = -1 / slopeAB;
    slopeMidBC = -1 / slopeBC;

    % 计算圆心
    % 解线性方程组
    A = [-slopeMidAB, 1; -slopeMidBC, 1];
    b = [midAB(2) - slopeMidAB * midAB(1); midBC(2) - slopeMidBC * midBC(1)];
    center = A \ b;

    % 计算半径
    radius = sqrt((center(1) - pointA(1))^2 + (center(2) - pointA(2))^2);
end