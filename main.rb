require 'ruby2d'


set width: 800,
    height: 600

MAX_HEIGHT = get :height
MAX_WIDTH = get :width

@xspeed = 3
@yspeed = 3
@left_points = 0
@right_points = 0
pad = Sound.new('Assets\ping_pong_8bit_plop.ogg')
over = Sound.new('Assets\mixkit-arcade-retro-game-over-213.wav')
@over_text = @over_text = Text.new(
    "",
    x: get(:width) / 2 - 150,
    y: MAX_HEIGHT/2,
    font: 'assets/PressStart2P.ttf',
    color: 'gray', size: 40
    )

@ball = Circle.new(x: 50, y: 50,color: 'blue', radius: 7 )
@rect1 = Rectangle.new(x: 8, y: 50, height: 100, width: 10)
@rect2 = Rectangle.new(x: MAX_WIDTH-18, y: 50, height: 100, width: 10)

@left_score_text =  Text.new(
    0,
    x: get(:width) / 2 - 150,
    y: 5,
    font: 'assets/PressStart2P.ttf',
    color: 'gray', size: 40
    )

@right_score_text =  Text.new(
    0,
    x: get(:width) / 2 + 60,
    y: 5,
    font: 'assets/PressStart2P.ttf',
    color: 'gray', size: 40
    ) 



def gameOver
    if @ball.x >= MAX_WIDTH
        return true

    elsif @ball.y <= 0
        return true
    else
        return false
    end
end

def evaluateScore
    if @right_points > @left_points
        @over_text.text = "Left Player Wins"

    elsif @right_points < @left_points
        @over_text.text = "Right Player Wins"

    else
        @over_text.text = "Match Draw"
    end
end

on :key_held do |event|
    if event.key == 's'
        if @rect1.y + 100 <= MAX_HEIGHT
            @rect1.y += 3
        end
    elsif event.key == 'w'
        if @rect1.y - 3 >= 0
            @rect1.y += -3
        end
    elsif event.key == "up"
        if @rect2.y - 3 >=0
            @rect2.y += -3
        end
    elsif event.key =='down'
        if @rect2.y + 100 <= MAX_HEIGHT
            @rect2.y += 3
        end
    end
  end

update do
    @ball.x = @ball.x + @xspeed
    @ball.y = @ball.y + @yspeed
    if gameOver()
        if @right_points > @left_points
            @over_text.text = "Right Player Wins"

        elsif @right_points < @left_points
            @over_text.text = "Left Player Wins"

        else
            @over_text.text = "Match Draw"
        end
        over.play
        close
        sleep(2)
    end

    if @ball.y <=7
        @yspeed = -@yspeed
        pad.play

    elsif @ball.y >= MAX_HEIGHT-7
        @yspeed = -@yspeed
        pad.play

    elsif @rect2.contains? @ball.x + 7, @ball.y
        @xspeed = -@xspeed
        @right_points+=1
        @right_score_text.text = @right_points
        pad.play

    elsif @rect1.contains? @ball.x - 7, @ball.y
        @xspeed = -@xspeed
        @left_points+=1
        @left_score_text.text = @left_points
        pad.play

    elsif @ball.x <= 5
        close
    elsif @ball.x >= MAX_WIDTH
        close
    end
    @left_score_text
    @right_score_text
end

show
