require 'gosu'

class Snake
  def initialize
    @image = Gosu::Image.new("snake.png")
    @body = Array.new
    @score = 0
    @speed = 0
  end

  def draw
  end
end

class Apple
  def initialize
  end
end

class MyWindow < Gosu::Window
  def initialize
    super(600, 450)
    self.caption = 'SNAKE'

    @state = "menu"

    @menu_image = Gosu::Image.new("menu.png")
    @game_over_image = Gosu::Image.new("game-over.png")
  end

  def update
  end

  def draw
    if @state == "menu"
      @menu_image.draw(0, 0, 0)
    elsif @state == "game_over"
      @game_over_image.draw(0, 0, 0)
    end
  end
end

window = MyWindow.new
window.show
