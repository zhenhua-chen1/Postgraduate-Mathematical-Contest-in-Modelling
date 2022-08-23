function [x,z]=search_centrio(pos_x,pos_z,s,Length,height,angle)
 if angle==0 %矩形质心坐标
     x=pos_x;%质心横坐标不变
     z=pos_z-(height/2+s/Length/2);%质心横坐标不变
 elseif abs(angle)<atan(height/Length)
     if s<1/2*Length^2*abs(tan(angle))
         [x,z]=triangle(pos_x,pos_z,s,Length,height,angle);%三角形质心坐标变换
     elseif s>1/2*Length^2*abs(tan(angle))&&s<Length*height-1/2*Length^2*abs(tan(angle))
         [x,z]=trapezium(pos_x,pos_z,s,Length,height,angle);%梯形坐标变换
     elseif s>Length*height-1/2*Length^2*abs(tan(angle))
         [x,z]=pentagon(pos_x,pos_z,s,Length,height,angle);%五边形形坐标变换
     end
  elseif abs(angle)==atan(height/Length)
     if s<1/2*Length*height
        [x,z]=triangle(pos_x,pos_z,s,Length,height,angle);%梯形坐标变换
     elseif s>1/2*Length*height
         [x,z]=pentagon(pos_x,pos_z,s,Length,height,angle);%五边形坐标变换
     end
   elseif abs(angle)>atan(height/Length)
       if s<1/2*height^2/abs(tan(angle))
           [x,z]=triangle(pos_x,pos_z,s,Length,height,angle);%三角形质心坐标变换
       elseif  s>1/2*height^2/abs(tan(angle))&&s<Length*height-1/2*height^2/abs(tan(angle))
           [x,z]=trapezium(pos_x,pos_z,s,Length,height,angle);
       elseif s>Length*height-1/2*height^2/abs(tan(angle))
           [x,z]=pentagon(pos_x,pos_z,s,Length,height,angle);%五边形形坐标变换
       end
 end
end
function [x,z]=triangle(pos_x,pos_z,s,Length,height,angle)
      a=sqrt(abs(2*s/tan(angle)));
      x=pos_x-(Length/2-1/3*sqrt(2*s/(abs(tan(angle)))));
      z=pos_z-(height/2-1/3*a*sqrt(2*s*abs(tan(angle))));
end
function [x,z]=trapezium(pos_x,pos_z,s,Length,height,angle)
      a=Length;
      if angle>=1/2*angle
          x=pos_x-(Length/2-s+(a^2*abs(tan(angle)))/6);
          z=pos_z-(height/2+(s/(2*a)+(a^4*abs(tan(angle)^2))/(24*s)));
      else
          x=pos_x-(a/2-s/2/height-height^3*cot(angle)^2);
          z=pos_z-(height/2-s+height^2*cot(angle)/6);
      end
end
function [x,z]=pentagon(pos_x,pos_z,s,Length,height,angle)
    x=pos_x-(Length/10-1/5*sqrt(2*(Length*height-s)/abs(tan(angle))));
    z=pos_z+(Length/10+1/5*sqrt(2*abs(tan(angle)*(Length*height-s))));
end