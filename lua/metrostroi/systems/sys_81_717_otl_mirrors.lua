Metrostroi.DefineSystem("OTL_Mirrors")
TRAIN_SYSTEM.DontAccelerateSimulation = false

function TRAIN_SYSTEM:Initialize()
    
end

if CLIENT then
    function TRAIN_SYSTEM:ClientInitialize()
        self.Cam1 = self.Train:CreateRT("LeftMirror_SYS", 128, 256)
        self.Cam2 = self.Train:CreateRT("RightMirror_SYS", 128, 256)
    end

    function TRAIN_SYSTEM:ClientThink()
        local left_mirror_pos = Vector(468.077942,75.168098,24.984735)
        local right_mirror_pos = Vector(468.077942,-75.168098,24.984735)
    
        local train = self.Train

        Metrostroi.RenderCamOnRT(train,left_mirror_pos,"LeftMirror",0.2,self.Cam1,train,left_mirror_pos,Angle(0, 180, 0),128,256)
        Metrostroi.RenderCamOnRT(train,right_mirror_pos,"RightMirror",0.2,self.Cam2,train,right_mirror_pos,Angle(0, 180, 0),128,256)

        render.PushRenderTarget(train.LeftMirror,0,0,128,256)
        render.Clear(0, 0, 0, 0)
        cam.Start2D()
            render.DrawTextureToScreenRect(self.Cam1, 0, 0, 2048, 1024 + 128)
        cam.End2D()
        render.PopRenderTarget()

        render.PushRenderTarget(train.RightMirror,0,0,128,256)
        render.Clear(0, 0, 0, 0)
        cam.Start2D()
            render.DrawTextureToScreenRect(self.Cam2, 0, 0, 2048, 1024 + 128)
        cam.End2D()
        render.PopRenderTarget()
    end
end