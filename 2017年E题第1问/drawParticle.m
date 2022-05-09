 
%在目标函数的图形上绘制2维以下的粒子的新位置
function drawParticle(SwarmSize,ParSwarm,ParticleSize,IsDraw)
    if IsDraw~=0
        if 1==ParticleSize
            for ParSwarmRow=1:SwarmSize
                plot([ParSwarm(ParSwarmRow,1),ParSwarm(ParSwarmRow,1)],[ParSwarm(ParSwarmRow,3),0],'r*-','markersize',8);
                text(ParSwarm(ParSwarmRow,1),ParSwarm(ParSwarmRow,3),num2str(ParSwarmRow));
            end
        end
        
        if 2==ParticleSize
            for ParSwarmRow=1:SwarmSize
                stem3(ParSwarm(ParSwarmRow,1),ParSwarm(ParSwarmRow,2),ParSwarm(ParSwarmRow,5),'r.','markersize',8);%绘制3D图形  (matlab6.5 stem3出错,改为plot3朱)
            end
        end
    end
    
    