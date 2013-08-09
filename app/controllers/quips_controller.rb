class QuipsController < ApplicationController
  before_filter :authorize, only: [:create]

  def new
    @quip = Quip.new
  end

  def create
    @quip = Quip.new(content: params['quip_content'])
    @quip.user_id = current_user.id

    if @quip.save
      flash[:notice] = 'Your Quip was posted!'
      redirect_to current_user
    else
      render :new
    end
  end
end
