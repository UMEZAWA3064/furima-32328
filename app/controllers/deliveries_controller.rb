class DeliveriesController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @user_delivery = UserDelivery.new
  end

  #def new
    #@user_delivery = UserDelivery.new
  #end

  def create
    @user_delivery = UserDelivery.new(delivery_params)
      if @user_delivery.valid?
        @user_delivery.save
        redirect_to root_path
      else
        render 'index'
      end
  end

  private
  def delivery_params
    params.permit(:post_code, :prefecture_id, :city, :address, :building_name, :phone_number, :user_id, :item_id)
  end
end
