class ItemsController < ApplicationController

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else
      items = Item.all
    end

    render json: items, except: [:created_at, :updated_at], include: :user
  end

  def show
    item = Item.find(params[:id])
    render json: item, except: [:created_at, :updated_at]
  end

  def create
    if params[:user_id]
      item = Item.create!({
        name: params[:name],
        description: params[:description],
        price: params[:price],
        user_id: params[:user_id]
      })
    else
      item = Item.create!({
        name: params[:name],
        description: params[:description],
        price: params[:price]
      })
    end

    render json: item, except: [:created_at, :updated_at], status: :created
  end

end
