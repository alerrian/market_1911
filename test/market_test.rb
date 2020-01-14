require 'Minitest/autorun'
require 'Minitest/pride'
require_relative '../lib/item'
require_relative '../lib/vendor'
require_relative '../lib/market'

class MarketTest < Minitest::Test
  def setup
    @market = Market.new('South Pearl Street Farmers Market')
    @vendor1 = Vendor.new('Rocky Mountain Fresh')
    @vendor2 = Vendor.new('Ba-Nom-a-Nom')
    @vendor3 = Vendor.new('Palisade Peach Shack')
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
  end

  def test_a_market_exists
    assert_instance_of Market, @market
  end

  def test_a_market_has_attributes
    assert_equal 'South Pearl Street Farmers Market', @market.name
    assert_equal [], @market.vendors
  end

  def test_market_can_add_vendors
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    assert_equal [@vendor1, @vendor2, @vendor3], @market.vendors
  end
end
