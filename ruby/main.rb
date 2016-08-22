require 'gosu'

class MyWindow < Gosu::Window
  def initialize
    super(600, 450)
    self.caption = 'SNAKE'
  end
end

window = MyWindow.new
window.show
