class StoreController < ApplicationController
  before_filter :find_cart, :except => :empty_cart
  
  def index
    @products = Product.find_products_for_sale
  end
  
  def add_to_cart
    begin
      product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error("Invalid product id: #{params[:id]}")
      redirect_to_index I18n.t('store.invalidprodmsg')
    else
      @cart.add_product(product)
    end  
  end
  
  def empty_cart
    session[:cart] = nil
    redirect_to_index I18n.t('store.emptycartmsg')
  end
  
  def checkout
    if @cart.items.empty?
      redirect_to_index I18n.t('store.cartemptymsg')
    else
      @order = Order.new
    end
  end
  
  def save_order
    @order = Order.new(params[:order])
    @order.add_line_items_from_cart(@cart)
    if @order.save
      session[:cart] = nil
      redirect_to_index I18n.t('store.orderthanx')
    else
      render :action => :checkout
    end
  end
  
  
  private
  
  def redirect_to_index msg
    flash[:notice] = msg
    redirect_to :action => :index
  end
  
  def find_cart
    @cart = (session[:cart] ||= Cart.new)
  end
  
protected

  def authorize
  end

end
