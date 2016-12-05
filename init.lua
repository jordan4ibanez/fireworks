local fireworks = {}

fireworks.register_firework = function(name,explosion_size,height,color,rocket_texture)
	minetest.register_entity("fireworks:"..name, {
		physical = true,
		collide_with_objects = false,
		collisionbox = {0,0,0,0,0,0},
		visual = "upright_sprite",
		visual_size = {x=1, y=1},
		textures={rocket_texture},
		makes_footstep_sound = false,
		
		timer = 0,
		
		height = height,
		origin = 0,
		explosion_size = explosion_size,
		explode_texture = 
		
		on_activate = function(self,dtime)
			self.object:setacceleration({x=0,y=self.height,z=0})
			self.origin = self.object:getpos().y
		end,
		
		on_step = function(self,dtime)
			if self.object:getpos().y > self.origin + self.height then
				local pos = self.object:getpos()
				minetest.add_particlespawner({
					amount = self.explosion_size*30,
					time = 0.1,
					minpos = pos,
					maxpos = pos,
					minvel = {x=-self.explosion_size, y=-self.explosion_size, z=-self.explosion_size},
					maxvel = {x=self.explosion_size, y=self.explosion_size, z=self.explosion_size},
					minacc = {x=0, y=0, z=0},
					maxacc = {x=0, y=0, z=0},
					minexptime = 1,
					maxexptime = 1,
					minsize = 1,
					maxsize = 1,
					collisiondetection = false,
					vertical = false,
					texture = ,
				})
				self.object:remove()
			end
		end,
	})
end

fireworks.register_firework("poop",5,5,"red","default_dirt.png")
minetest.override_item("default:stick", {
	on_drop = function(itemstack, dropper, pos)
		minetest.add_entity(pos, "fireworks:poop")

	end,
})
