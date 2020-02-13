class Cell
  attr_accessor :state

  def initialize(state, x, y)
    if state.class != Cell
      @state = state == 1
    else
      @state = state.state
    end
    @x = x
    @y = y
  end

  def alive?
    @state
  end

  def dead?
    !alive?
  end

  def lives!
    @state = true
    self
  end

  def dies!
    @state = false
    self
  end

  def numb
    @state == true ? 1 : 0
  end
end