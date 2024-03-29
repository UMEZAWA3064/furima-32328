class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]  # exceptでログインしていない状態でもトップページ、詳細ページ、新規登録、ログインページに飛べる
  before_action :set_item, only: [:edit, :show, :update, :destroy] # edit,showは同じ記述なのでset_itemとしてprivateメソッドに移し替える
  before_action :prevent_url, only: [:edit, :update, :destroy] #出品者本人が売却済みの商品に対して編集、削除のURLの直打ち禁止

  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :description, :image, :category_id, :item_status_id, :prefecture_id,
                                 :delivery_burden_id, :delivery_day_id).merge(user_id: current_user.id)
  end

  # edit,show,update,destroy :correct_userを省略した内容
  def set_item
    @item = Item.find(params[:id])
  end


  def prevent_url
    if @item.user_id != current_user.id || @item.buyer != nil 
      redirect_to root_path
    end
  end
end
