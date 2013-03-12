SCREEN_WIDTH = 640
SCREEN_HEIGHT = 480
FULLSCREEN = false
VSYNC = true
ANTIALIASING = 0

PHYS_SCALE = 64

require "player"

function love.load()
	-- Setup physics.
	love.physics.setMeter(PHYS_SCALE)	-- 1m = 64px

	-- Create world.
	world = love.physics.newWorld(0, 9.82 * PHYS_SCALE, true)
	world:setCallbacks(beginContact, endContact, preSolve, postSolve)

	objects = {}

	-- Create the ground.
	objects.ground = {}
	objects.ground.body = love.physics.newBody(world, SCREEN_WIDTH / 2, (SCREEN_HEIGHT - 25))
	objects.ground.shape = love.physics.newRectangleShape(SCREEN_WIDTH, 50)
	objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape)

	-- Initilize graphics.
	love.graphics.setBackgroundColor(134, 166, 248)
	love.graphics.setMode(SCREEN_WIDTH, SCREEN_HEIGHT, FULLSCREEN, VSYNC, ANTIALIASING)

	enteties = {}

	-- Setup player.
	--player = entity.create()
	--player.init()
	player = Player(world, love.graphics.newImage("player.png"), SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)
	table.insert(enteties, player)

end

dtotal = 0
function love.update(dt)
	world:update(dt)

	-- Check keys.
	local x = 0
	local y = 0
	if love.keyboard.isDown("up", "w") then
		y = - 1
	end
	if love.keyboard.isDown("down", "s") then
		y = 1
	end
	if love.keyboard.isDown("right", "d") then
		x = 1
	end
	if love.keyboard.isDown("left", "a") then
		x = - 1
	end
	if love.keyboard.isDown(" ") then
		objects.ball.body:setPosition(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)
	end
	if x ~= 0 or y ~= 0 then
		objects.ball.body:applyForce(x * 400, y * 400)
	end

	for i, v in ipairs(enteties) do
		v:update(dt)
	end

	-- Update NPC.
	dtotal = dtotal + dt
	if dtotal >= 1 then
		dtotal = dtotal - 1
		--npc.think()
	end
end

function love.draw()
	love.graphics.setColor(0, 160, 50)
	love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))

	for i, v in ipairs(enteties) do
		v:draw()
	end

	love.graphics.setColor(0, 60, 50)
	love.graphics.print("Score: " .. player.score, 10, 10)
end

function love.keypressed(key)
	if key == 'escape' then
		love.event.push("quit")
	end
end

function beginContact(a, b, coll)
end

function endContact(a, b, coll)
end

function preSolve(a, b, coll)
end

function postSolve(a, b, coll)
end
