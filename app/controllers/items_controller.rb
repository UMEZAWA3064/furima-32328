class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]  # exceptでログインしていない状態でもトップページ、詳細ページ、新規登録、ログインページに飛べる

  before_action :move_to_index, except: [:index, :show]       # 未ログインユーザーが投稿画面などに直接アクセスしてきたらindexに遷移するようにする。index,showは除外
  before_action :correct_user, only: [:edit, :destroy] # URL直打ち禁止にする。他のユーザーが編集、削除できないようにする。

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
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  # 他のユーザーがURLを直接打っても編集、削除できないようにする
  def correct_user
    @item = Item.find(params[:id])
    redirect_to action: :index unless @item.user.id == current_user.id
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :description, :image, :category_id, :item_status_id, :prefecture_id,
                                 :delivery_burden_id, :delivery_day_id).merge(user_id: current_user.id)
  end

  # ログインしているユーザーでない時はindexに遷移する
  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
