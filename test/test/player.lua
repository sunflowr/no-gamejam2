require "entity"

class "Player" (Entity) {
	__init__ = function(self, world, sprite, x, y)
		Entity.__init__(self)
		self.sprite = sprite
		self.x = x or 1
		self.y = y or 1
		self.score = 0

		-- Create a ball.
		self.objects = {}
		self.objects.ball = {}
		self.objects.ball.body = love.physics.newBody(world, x, y, "dynamic")
		self.objects.ball.shape = love.physics.newCircleShape(20)
		self.objects.ball.fixture = love.physics.newFixture(self.objects.ball.body, self.objects.ball.shape, 1)
		self.objects.ball.fixture:setRestitution(0.1)
	end,

	update = function(self, dt)
	end,

	draw = function(self)
		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(self.sprite, self.objects.ball.body:getX(), self.objects.ball.body:getY())
	end
}