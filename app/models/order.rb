class Order < ActiveRecord::Base
  has_many  :line_items
  
  PAYMENT_TYPES = [
    # Displayed stored in db
    [ "Check" , "check" ],
    [ "Credit Card" , "cc" ],
    [ "Purchase Order" , "po" ]
    #~ [ I18n.t(order.paytype.check) , "check" ],
    #~ [ I18n.t(order.paytype.cc) , "cc" ],
    #~ [ I18n.t(order.paytype.po) , "po" ]
  ]
  
  validates_presence_of :name, :address, :email, :pay_type
  validates_inclusion_of  :pay_type, :in => 
    PAYMENT_TYPES.map {|disp, value| value}
    
  def add_line_items_from_cart cart
    cart.items.each do |item|
      li = LineItem.from_cart_item(item)
      line_items << li
    end
  end
  
end
