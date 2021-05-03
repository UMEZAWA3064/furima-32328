class DeliveriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @item = Item.find(params[:item_id])
    @user_delivery = UserDelivery.new
    if @item.user_id == current_user || @item.buyer != nil           #商品に紐付いた購入情報があれば、トップページに遷移する
      redirect_to root_path
    end
  end

  def create
    @user_delivery = UserDelivery.new(delivery_params)
    @item = Item.find(params[:item_id])
      if @user_delivery.valid?
        pay_item
        @user_delivery.save
        redirect_to root_path
      else
        render 'index'
      end
  end

  private
  def delivery_params
    params.require(:user_delivery).permit(:post_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: delivery_params[:token],
      currency:'jpy'
    )
  end

end
