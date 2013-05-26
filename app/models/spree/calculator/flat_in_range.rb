module Spree
  class Calculator::FlatInRange < Calculator
    preference :lower_boundry,    :decimal, :default => 0.0
    preference :upper_boundry,    :decimal, :default => 50.0
    preference :amount,           :decimal, :default => 5.0
    preference :alternative_amount, :decimal, :default => 10.0
    preference :free_shipping, :boolean, :default => false
    preference :free_shipping_price, :decimal, :default => 0.0
    attr_accessible :preferred_lower_boundry, :preferred_upper_boundry, :preferred_amount, :preferred_alternative_amount, :preferred_free_shipping, :preferred_free_shipping_price
    def self.description
      I18n.t(:flat_in_range)
    end

    def compute(object)
      sum = 0
      item_total = object.line_items.map(&:amount).sum
      if (item_total >= self.preferred_lower_boundry && item_total <= self.preferred_upper_boundry)
        if self.preferred_free_shipping == true && self.preferred_free_shipping_price <= item_total
          return 0.0
        else
          return self.preferred_amount
        end
      else
        if self.preferred_free_shipping == true && self.preferred_free_shipping_price <= item_total
          return 0.0
        else
          return self.preferred_alternative_amount
        end
      end
    end
  end
end