-- Ruben Vazquez
-- Carolyn Cressman

-- A script written in Lua to simulate a Line Follower.
-- Written for the V-Rep Simulator using the Line Tracer CAD model from Cubictek co. ltd.

-- Get the references for the sensors and for the dynamic portions of the wheels.
leftSensor = simGetObjectHandle("LeftSensor")
rightSensor = simGetObjectHandle("RightSensor")
leftJoint = simGetObjectHandle("DynamicLeftJoint")
rightJoint = simGetObjectHandle("DynamicRightJoint")

-- Declare variables:
-- baseSpeed: a number containing the linear speed of the wheels.
-- wheelRadius: a number containing the radius of the wheels.
-- sensors: an array to store the data from the two sensors.
linearSpeed = 0.3
wheelRadius = 0.027
sensors = {}

-- Infinite loop
while true do

    -- Read in the sensor data.
    sensors[1] = simReadVisionSensor(leftSensor) == 1
    sensors[2] = simReadVisionSensor(rightSensor) == 1

    -- Initialize the speed of both wheels to the initial speed.
    leftWheelSpeed = linearSpeed
    rightWheelSpeed = linearSpeed

    -- If the left sensor reads false,
    if sensors[1] == false then
        -- then slow down the speed of the left wheel so that the follower turns right.
        leftWheelSpeed = leftWheelSpeed*0.3
    end
    
    -- If the right sensor reads false,
    if sensors[2] == false then
        -- then slow down the speed of the right wheel so that the follower turns left.
        rightWheelSpeed = rightWheelSpeed*0.3
    end

    -- Set the speed of the joints to apply the proper forces to rotate the wheels
    -- at the given speeds.
    simSetJointTargetVelocity(leftJoint, leftWheelSpeed/wheelRadius)
    simSetJointTargetVelocity(rightJoint, rightWheelSpeed/wheelRadius)

end
