--[[ Made by coolcapidog
Channel ->> https://www.youtube.com/c/coolcapidog
You can change the settings but you shouldn't change anything except settings.
]]
repeat wait() until game.Players.LocalPlayer.Character
local dEPENDENCIES = Instance.new("Folder")
dEPENDENCIES.Name = "DEPENDENCIES"

local wind = Instance.new("Sound")
wind.Name = "Wind"
wind.RollOffMaxDistance = 1.49e+04
wind.RollOffMinDistance = 9.91
wind.SoundId = "rbxassetid://3308152153"
wind.Parent = dEPENDENCIES

local flymoving = Instance.new("BoolValue")
flymoving.Name = "Flymoving"
flymoving.Parent = dEPENDENCIES

local bodyGyro = Instance.new("BodyGyro")
bodyGyro.Name = "BodyGyro"
bodyGyro.D = 1.36e+03
--bodyGyro.MaxTorque = Vector3.new(1.33e+06, 1.33e+06, 1.33e+06)
bodyGyro.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
bodyGyro.P = 6.67e+03
bodyGyro.Parent = dEPENDENCIES

local bodyVelocity = Instance.new("BodyVelocity")
bodyVelocity.Name = "BodyVelocity"
bodyVelocity.MaxForce = Vector3.new(3.31e+08, 3.31e+08, 3.31e+08)
bodyVelocity.P = 4.45e+04
bodyVelocity.Velocity = Vector3.new(0, 0, 0)
bodyVelocity.Parent = dEPENDENCIES

local roll = 0
local target

local KeyCode = Enum.KeyCode.E

local WindSoundEnabled = true
local hl = Instance.new("Highlight")
hl.Parent = workspace
hl.Enabled = false
hl.Adornee = game.ReplicatedStorage

local BodyVelocity = dEPENDENCIES:WaitForChild("BodyVelocity"):Clone()
local v3 = dEPENDENCIES.BodyGyro:Clone()
local Character = game.Players.LocalPlayer.Character
local Humanoid = Character:FindFirstChild("Humanoid") or Character:WaitForChild("Humanoid")
BodyVelocity.Parent = Character
v3.Parent = Character
local Sound1 = Instance.new("Sound", Character:WaitForChild("HumanoidRootPart"))
Sound1.SoundId = "rbxassetid://3308152153"
Sound1.Name = "Sound1"
local organ = Instance.new("Sound",workspace)
organ.SoundId = "rbxassetid://9038874199"
local crash = Instance.new("Sound",workspace)
crash.SoundId = "rbxassetid://8713390940"
crash.PlaybackSpeed = 3
crash.Volume = 10
organ.Looped = true
organ.Volume = 0.5
local anim = Instance.new("Animation") 
anim.AnimationId = "http://www.roblox.com/asset/?id=10714347256"
local lander = Instance.new("Animation")
lander.AnimationId = "http://www.roblox.com/asset/?id=10714360164"
Sound1.Volume = 1
local landeranim = Humanoid:LoadAnimation(lander)
landeranim.Priority = Enum.AnimationPriority.Action3
local theactualanimation = Humanoid:LoadAnimation(anim)
if WindSoundEnabled == false then
	Sound1.Volume = 0
end
local Camera = game.Workspace.Camera
local function u2()
	if Humanoid.MoveDirection == Vector3.new(0, 0, 0) then
		return Humanoid.MoveDirection
	end
	local v12 = (Camera.CFrame * CFrame.new((CFrame.new(Camera.CFrame.p, Camera.CFrame.p + Vector3.new(Camera.CFrame.lookVector.x, 0, Camera.CFrame.lookVector.z)):VectorToObjectSpace(Humanoid.MoveDirection)))).p - Camera.CFrame.p;
	if v12 == Vector3.new() then
		return v12
	end
	return v12.unit
end
local Flymoving = dEPENDENCIES.Flymoving
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local Flying = false

local ContextActionService = game:GetService("ContextActionService")

game:GetService("RunService").RenderStepped:Connect(function()
	if game.Players.LocalPlayer.Character then
		if Flying == true then
			Humanoid:ChangeState(6)
			if u2() == Vector3.new(0, 0, 0) then
				v3.CFrame = game.Workspace.Camera.CFrame
				Flymoving.Value = false
			else 
				local a = Humanoid.MoveDirection:Dot(Camera.CFrame.RightVector)
				local b = Humanoid.MoveDirection:Dot(Camera.CFrame.LookVector)
				local c = Humanoid.MoveDirection:Dot(Camera.CFrame.UpVector)
				v3.CFrame = game.Workspace.Camera.CFrame * CFrame.Angles(math.rad(-55* b),math.rad(-55* c),math.rad(-55* a) ) * CFrame.Angles(0,math.rad(roll),0)
				Flymoving.Value = true
			end
			local missile
			if target then
				missile = Humanoid.MoveDirection.Magnitude*(CFrame.new(Character.PrimaryPart.Position,target.Position).LookVector)
				if (Character.PrimaryPart.Position -target.Position).Magnitude < 5 then
					target = nil
					hl.Enabled = false
					hl.Adornee = game.ReplicatedStorage
				end
			else
				missile = u2()
			end
			TweenService:Create(BodyVelocity, TweenInfo.new(0.3), {Velocity = missile * 350}):Play()
		end

	end
end)

Flymoving.Changed:Connect(function(p1)
	if p1 == true then
		theactualanimation:Stop(0.5)
		TweenService:Create(Camera, TweenInfo.new(0.5), {FieldOfView = 100}):Play()
		TweenService:Create(organ, TweenInfo.new(0.5), {PlaybackSpeed = 1.025}):Play()
		Sound1:Play()
		return
	end
	if p1 == false then
		theactualanimation:Play(0.5) 
		theactualanimation.TimePosition = 2 
		theactualanimation:AdjustSpeed(0)
		TweenService:Create(Camera, TweenInfo.new(0.5), {FieldOfView = 70}):Play()
		TweenService:Create(organ, TweenInfo.new(0.5), {PlaybackSpeed = 1}):Play()
		Sound1:Stop()
	end
end)

function fly()
	if Flying == false then
		Flying = true
		organ.Playing = true
		if Character:FindFirstChild("HumanoidRootPart") then
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, false)
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
			theactualanimation:Play(0.35) 
			theactualanimation.TimePosition = 2 
			theactualanimation:AdjustSpeed(0)
			Character.HumanoidRootPart.Running.Volume = 0
			Humanoid:ChangeState(6)
			BodyVelocity.Parent = Character.HumanoidRootPart
			v3.Parent = Character.HumanoidRootPart
			TweenService:Create(organ, TweenInfo.new(0.5), {Volume = 0.5}):Play()
		end
	else
		Flying = false
		Flymoving.Value = false
		theactualanimation:Stop(0.25)
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, true)
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
		Character.HumanoidRootPart.Running.Volume = 0.65
		Humanoid:ChangeState(8)
		BodyVelocity.Parent = Character
		v3.Parent = Character
		BodyVelocity.Velocity = Vector3.new(0,0,0)
		TweenService:Create(organ, TweenInfo.new(0.25), {Volume = 0}):Play()
		wait(0.25)
		organ.Playing = false
	end
end

function home()
	if not Flymoving.Value then return end
	local maushit = game.Players.LocalPlayer:GetMouse().Hit
	local rot = CFrame.new(Character.PrimaryPart.Position,maushit.p)
	local missile = Humanoid.MoveDirection.Magnitude*(rot.LookVector)
	Flying = false
	TweenService:Create(BodyVelocity, TweenInfo.new(0.3), {Velocity = missile * 450}):Play()
	local delaye = (Character.PrimaryPart.Position-maushit.p).Magnitude/450
	if delaye > 0.42 then
		wait( delaye  -0.42)
		crash:Play()
		wait(0.42)
	else
		crash:Play()
		wait( delaye)
	end
	Character.PrimaryPart.Velocity = Vector3.new(0,0,0)
	local rX, rY, rZ = rot:ToOrientation()
	Character.PrimaryPart.Anchored = true
	Character.PrimaryPart.CFrame = CFrame.new(maushit.p+Vector3.new(0,Humanoid.HipHeight+(Character.PrimaryPart.Size.Y/2),0))* CFrame.fromOrientation(0, rY, 0)
	Character.PrimaryPart.Anchored = false
	Humanoid.WalkSpeed = 0
	Flymoving.Value = false
	landeranim:Play()
	landeranim.TimePosition = 1
	theactualanimation:Stop(0.25)
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, true)
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
	Character.HumanoidRootPart.Running.Volume = 0.65
	BodyVelocity.Velocity = Vector3.new(0,0,0)
	Humanoid:ChangeState(8)
	BodyVelocity.Parent = Character
	v3.Parent = Character
	organ.Volume = 0
	organ.Playing = false
	wait(2.5)
	Humanoid.WalkSpeed = 16
end
function targetFN()
	if not target then
		local maushit = game.Players.LocalPlayer:GetMouse().Hit
		if maushit then
			local dist = 75
			local temptarget 
			for i,v in pairs(workspace:GetDescendants()) do
				if v:IsA("BasePart") and (v.Position - maushit.p).Magnitude < dist and not v.Anchored then
					dist = (v.Position - maushit.p).Magnitude
					temptarget = v
				end
			end
			if temptarget then
				target = temptarget
				hl.Adornee = target:FindFirstAncestorOfClass("Model") or target
				hl.Enabled = true
			end
		end
	else
		target = nil
		hl.Enabled = false
		hl.Adornee = game.ReplicatedStorage
	end
end

UIS.InputBegan:Connect(function(key, gameProcessed)
	if gameProcessed then return end
	if key.KeyCode == KeyCode then
		fly()
	end
	if Flymoving.Value then
		if key.KeyCode == Enum.KeyCode.Z then
			roll = -90
		elseif key.KeyCode == Enum.KeyCode.C then
			roll = 90
		end
		if key.KeyCode == Enum.KeyCode.V and game.Players.LocalPlayer:GetMouse().Hit then
			home()
		end
	end
	if key.KeyCode == Enum.KeyCode.X then
		targetFN()
	end
end)

function createToggle(fn)
	local toggle = false
	local function toggleFunction()
		toggle = not toggle
		if toggle then
			fn()
		end
	end
	return toggleFunction
end


UIS.InputEnded:Connect(function(key, gameProcessed)
	if gameProcessed then return end
	if key.KeyCode == Enum.KeyCode.Z then
		roll = 0
	elseif key.KeyCode == Enum.KeyCode.C then
		roll = 0
	end
end)
game.Players.LocalPlayer.CharacterAdded:Connect(function(chr)
	Humanoid =  chr:WaitForChild("Humanoid")
	Character = chr
	BodyVelocity = dEPENDENCIES:WaitForChild("BodyVelocity"):Clone()
	v3 = dEPENDENCIES.BodyGyro:Clone()
	BodyVelocity.Parent = Character
	v3.Parent = Character
	landeranim = Humanoid:LoadAnimation(lander)
	landeranim.Priority = Enum.AnimationPriority.Action3
	theactualanimation = Humanoid:LoadAnimation(anim)
	Sound1 = Instance.new("Sound", Character:WaitForChild("HumanoidRootPart"))
	Sound1.SoundId = "rbxassetid://3308152153"
	Sound1.Name = "Sound1"
	Sound1.Volume = 1
end)

--ContextActionService:BindAction("toggleFly", createToggle(fly), true, Enum.KeyCode.NumLock, Enum.KeyCode.ButtonR1)
--ContextActionService:SetPosition("toggleFly", UDim2.new(1, -70, 0, 10))
--ContextActionService:BindAction("toggleTarget", createToggle(targetFN), true, Enum.KeyCode.NumLock, Enum.KeyCode.ButtonR1)
--ContextActionService:SetPosition("toggleTarget", UDim2.new(-1, 0, -0.5, 0))
--ContextActionService:BindAction("homelanderLand", createToggle(home), true, Enum.KeyCode.NumLock, Enum.KeyCode.ButtonR1)
--ContextActionService:SetPosition("homelanderLand", UDim2.new(-0.9, 0, -0.5, 0))
