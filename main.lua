platform = {} -- Create a platform
player = {} -- Player -- Both are tables!
bullets = {} -- Array of bullets being stored
enemy = {} -- The Enemy on the screen
sleepingBox = {} -- The Sleeping box. 

function love.load() --Load the game (Inital State)
    platform.width = love.graphics.getWidth() -- This makes the platform as wide as the whole game window.
	platform.height = love.graphics.getHeight() -- This makes the platform as tall as the whole game window.
 
    -- This is the coordinates where the platform will be rendered.
	platform.x = 0 -- This starts drawing the platform at the left edge of the game window.
    platform.y = (platform.height / 2) -- This starts drawing the platform at the very middle of the game window

    gameSound = love.audio.newSource('Melody1.mp3', 'stream')
    gameSound:play()

    player.x = 1 -- love.graphics.getWidth() / 2
    player.y = love.graphics.getHeight() / 2
    player.speed = 200 -- Player speed

    player.img = love.graphics.newImage('melody.png') -- Loads a image as asset

    player.ground = player.y
    
    player.y_velocity = 0
    player.jump_height = -300    
    player.gravity = -500 

    player.health = 3
    isAlive = true
    score = 0

    canShoot = true
    canShootTimerMax = 0.5 -- 0.2
    canShootTimer = canShootTimerMax
    bulletDamage = 1

    paint0 = love.graphics.newImage('paint0.png')
    paint1 = love.graphics.newImage('paint1.png')
    paint2 = love.graphics.newImage('paint2.png')
    paint3 = love.graphics.newImage('paint3.png')
    paint4 = love.graphics.newImage('paint4.png')
    -- ^ What type of projectial? 

    defaultPaint = paint0 -- Variable to decide what paint is used at start

    bulletImg = love.graphics.newImage('bullet0.png')
    bulletSoundChoice = love.math.random(1, 2) -- Function does work
    if bulletSoundChoice == 1 then
        bulletSound = love.audio.newSource('tink.wav', 'static')
    elseif bulletSoundChoice == 2 then
        bulletSound = love.audio.newSource('openhat.wav', 'static')
    end
    -- foe details
    enemy.x = love.graphics.getWidth() -- These two likely need to change
    enemy.y = love.graphics.getHeight() / 2 --
    enemy.health = 0

    enemy.img = love.graphics.newImage('ghost.png')

    createEnemyTimerMax = 0.6 -- love.math.random(5, 10) / 10 -- Spawn timer 0.6
    createEnemyTimer = createEnemyTimerMax

    -- the sleeping box
    sleepingBox.x = love.graphics.getWidth() / 2 + 340
    sleepingBox.y = love.graphics.getHeight() / 2
    
    sleepingBox.img = love.graphics.newImage('sleeping-music-box1.png')
    touchedBox = false 

    deathCounter = 0
end

function love.update(dt) -- During updates (Movement)
    -- Where the keyboard magic happens

    -- Movement
    if love.keyboard.isDown('d') then
		if player.x < (love.graphics.getWidth() - player.img:getWidth()) then
            player.x = player.x + (player.speed * dt)
            player.img = love.graphics.newImage('melody.png')
		end
	elseif love.keyboard.isDown('a') then
		if player.x > 0 then 
            player.x = player.x - (player.speed * dt)
            player.img = love.graphics.newImage('melodyB.png') -- MelodyB or backwards melody
		end
	end
 
	if love.keyboard.isDown('w') then
		if player.y_velocity == 0 then
            player.y_velocity = player.jump_height
            player.img = love.graphics.newImage('melody_jump1.png')
		end
    end
    
    -- Jump
	if player.y_velocity ~= 0 then
		player.y = player.y + player.y_velocity * dt
		player.y_velocity = player.y_velocity - player.gravity * dt
	end
 
	if player.y > player.ground then
		player.y_velocity = 0
    	player.y = player.ground
    end
    
    -- Bullet
    if (love.keyboard.isDown('`')) then  
        defaultPaint = paint0
        bulletImg = love.graphics.newImage('bullet0.png') -- Grey is generic 
        player.speed = 200
        canShootTimerMax = 0.5
        bulletDamage = 1
        createEnemyTimer = love.math.random(5, 10) / 10
    elseif (love.keyboard.isDown('1')) then
        defaultPaint = paint1
        bulletImg = love.graphics.newImage('bullet1.png') -- Green is slower enemy spawn but you move slower
        player.speed = 175
        canShootTimerMax = 0.5
        bulletDamage = 1
        createEnemyTimer = love.math.random(7.5, 12.5) / 10
    elseif (love.keyboard.isDown('2')) then
        defaultPaint = paint2
        bulletImg = love.graphics.newImage('bullet2.png') -- Blue is stronger bullets but they are slower
        player.speed = 200
        canShootTimerMax = 0.6
        bulletDamage = 2
        createEnemyTimer = love.math.random(5, 10) / 10
    elseif (love.keyboard.isDown('3')) then 
        defaultPaint = paint3
        bulletImg = love.graphics.newImage('bullet3.png') -- Yellow is faster speed, but nothing else changed because actually harder to move!
        player.speed = 300
        canShootTimerMax = 0.5
        bulletDamage = 1
        createEnemyTimer = love.math.random(5, 10) / 10
    elseif (love.keyboard.isDown('4')) then
        defaultPaint = paint4
        bulletImg = love.graphics.newImage('bullet4.png') -- Orange is faster bullets but they are weaker
        player.speed = 200
        canShootTimerMax = 0.4
        bulletDamage = 0.75
        createEnemyTimer = love.math.random(5, 10) / 10
    end
    canShootTimer = canShootTimer - (1 * dt)
    if canShootTimer < 0 then
        canShoot = true
    end

    if (love.keyboard.isDown('space') and canShoot) then
        newBullet = { 
            x = player.x,  -- + (player.img:getWidth()/2)  player.x
            y = player.y, --player.y (+ 10 moves it down)
            img = bulletImg,
            bulletDamage = bulletDamage
        }
        table.insert(bullets, newBullet)
        bulletSound:play()
        canShoot = false
        canShootTimer = canShootTimerMax
    end 

    for i, bullet in ipairs(bullets) do
        bullet.x = bullet.x + (250 * dt) -- Value to edit bullet direction! Need to figure out way to make movement in direction. 
    
          if bullet.y < 0 then -- remove bullets when they pass off the screen -- Bullets okay when game resetarts
            table.remove(bullets, i)
        end
    end

    -- Foe creation
    createEnemyTimer = createEnemyTimer - (1 * dt)
    if createEnemyTimer < 0 then
        createEnemyTimer = love.math.random(5, 10) / 10 -- createEnemyTimerMax

        -- Create an enemy
        newEnemy = {
            x = enemy.x, --
            y = enemy.y, -- ^ Subject to change
            img = enemy.img,
            health = enemy.health + love.math.random(1, 3) -- Lol bad math
        }
        table.insert(enemy, newEnemy)
    end
    for i, enemy in ipairs(enemy) do
        enemy.x = enemy.x - (250 * dt) --[[Error main.lua:124: attempt to perform arithmetic on field 'x' (a nil value) Traceback main.lua:124: in function 'update' [C]: in function 'xpcall']]
        if enemy.x > 0 then -- > ?
            table.remove(enemy, i)
        end
    end

    -- Collison detection
    for i, e in ipairs(enemy) do
        for j, bullet in ipairs(bullets) do
            if CheckCollision(e.x, e.y, e.img:getWidth(), e.img:getHeight(), bullet.x, bullet.y, bullet.img:getWidth(), bullet.img:getHeight()) then
                table.remove(bullets, j)
                e.health = e.health - bullet.bulletDamage
                if e.health == 0 then
                    table.remove(enemy, i)
                    score = score + 1
                end
            end
        end
        if CheckCollision(e.x, e.y, e.img:getWidth(), e.img:getHeight(), player.x, player.y, player.img:getWidth(), player.img:getHeight())
        and isAlive then
            table.remove(enemy, i)
            player.health = player.health - 1
            if player.health == 0 then
                isAlive = false
                deathCounter = deathCounter + 1
            end
        end
    end
    if CheckCollision(sleepingBox.x, sleepingBox.y, sleepingBox.img:getWidth(), sleepingBox.img:getHeight(), player.x, player.y, player.img:getWidth(), player.img:getHeight()) 
    and touchedBox == false then
        touchedBox = true
        canShoot = false
    end

    -- Death detection
    if not isAlive and love.keyboard.isDown('r') then -- Lose state
        bullets = {}
        enemy = {}
        createEnemyTimer = nil
        touchedBox = false

        -- reset timers
        canShootTimer = canShootTimerMax
        createEnemyTimer = love.math.random(5, 10) / 10 -- Also related here...
    
        -- move player back to default position
        player.x = 1
        player.y = love.graphics.getHeight() / 2
        player.health = 3

        enemy.x = love.graphics.getWidth()
        enemy.y = love.graphics.getHeight() / 2
        enemy.img = love.graphics.newImage('ghost.png')
        enemy.health = 0


        -- reset our game state
        score = 0
        isAlive = true
    end
end

function love.draw() -- Draw game (Draw inital state)
    
    love.graphics.rectangle('fill', platform.x, platform.y, platform.width, platform.height) -- The Platform

    love.graphics.print(score, love.graphics:getWidth() / 2 - 360, love.graphics:getHeight() / 2 - 280) -- Score counter
    love.graphics.print(player.health, love.graphics:getWidth() / 2 - 360, love.graphics:getHeight() / 2 - 260) -- Health counter
    love.graphics.print(deathCounter, love.graphics:getWidth() / 2 - 360, love.graphics:getHeight() / 2 - 240) -- Health counter

    love.graphics.draw(defaultPaint, love.graphics:getWidth() / 2 + 340, love.graphics:getHeight() / 2 - 300) -- Chosen Paint

    if isAlive then -- While alive draw player related stuff. Else you kinda lost
        love.graphics.draw(player.img, player.x , player.y, 0, 1, 1, 0, 32)
        love.graphics.print("Melodys Adventure", love.graphics:getWidth() / 2 - 50, love.graphics:getHeight() / 2 - 20)
    else
        love.graphics.print("Press 'R' to restart", love.graphics:getWidth() / 2-50, love.graphics:getHeight() / 2 - 20)
    end

    if touchedBox == true then
        love.graphics.print("You won!", love.graphics:getWidth() / 2-50, love.graphics:getHeight() / 2 - 60)
    end

    for i, bullet in ipairs(bullets) do
        love.graphics.draw(bullet.img, bullet.x, bullet.y)
    end

    for i, enemy in ipairs(enemy) do 
        love.graphics.draw(enemy.img, enemy.x, enemy.y)
    end

    love.graphics.draw(sleepingBox.img, sleepingBox.x, sleepingBox.y)
end

function CheckCollision(x1,y1,w1,h1,x2,y2,w2,h2)
    return x1 < x2 + w2 and
           x2 < x1 + w1 and
           y1 < y2 + h2 and
           y2 < y1 + h1
  end

