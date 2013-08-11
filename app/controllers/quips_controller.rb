class QuipsController < ApplicationController
  before_filter :authorize, only: [:create]

  def new
    @quip = Quip.new
  end

  def create
    @quip = current_user.new_quip(content: params['quip_content'])

    if @quip.save
      flash[:notice] = 'Your Quip was posted!'
      redirect_to current_user
    else
      render :new
    end
  end
end
