class DemoController < ApplicationController
  # every time the controller is called we are making an instance of this class
  layout false
  def index
    # Ruby method inside a controller is also known as action
    # render is used to over write default behaviours
    render('index')
  end

  def hello
    @array = [1, 2, 3, 4, 5]
    @id = params['id']
    @page = params[:page]
    render('hello')
  end

  def other_hello
    redirect_to(action: 'index')
  end

  def welldev
    redirect_to('https://www.welldev.io')
  end

  def escape_output; end
end
