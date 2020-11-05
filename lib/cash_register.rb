class CashRegister
  def initialize(discount = 0.0)
    @total = 0.0
    @discount = discount
    @items = []
    @items_hash = {}
  end
  attr_accessor :discount, :items
  attr_writer :total
  attr_reader :items_hash

  def total
    if @total.instance_of?(Float) && @total.to_s.end_with?('.0')
      @total.to_i
    else
      @total
    end
  end

  def apply_discount
    if @discount.zero?
      p 'There is no discount to apply.'
    else
      @total -= total * (discount / 100.0)
      p "After the discount, the total comes to $#{self.total}."
    end
  end

  def add_item(title, price, quantity = 1)
    quantity.times do
      @items.push(title)
      @total += price
    end
    @items_hash[title.to_sym] = { price: price.to_f, quantity: quantity }
  end

  def void_last_transaction
    quantity = @items_hash[@items.last.to_sym][:quantity]
    quantity.times do
      @total -= items_hash[@items.last.to_sym][:price].to_f
      @items_hash[@items.last.to_sym][:quantity] -= 1 unless @items_hash[@items.last.to_sym][:quantity].zero?
      @items.pop
    end
  end
end
