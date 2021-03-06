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

    @item1 = Item.new({name: 'Peach', price: '$0.75'})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    @item3 = Item.new({name: 'Peach-Raspberry Nice Cream', price: '$5.30'})
    @item4 = Item.new({name: 'Banana Nice Cream', price: '$4.25'})

    @vendor1.add_stock(@item1, 35)
    @vendor1.add_stock(@item2, 7)
    @vendor2.add_stock(@item4, 50)
    @vendor2.add_stock(@item3, 25)
    @vendor3.add_stock(@item1, 65)
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

  def test_market_can_get_names_of_vendors
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    assert_equal ['Rocky Mountain Fresh', 'Ba-Nom-a-Nom', 'Palisade Peach Shack'], @market.vendor_names
  end

  def test_market_can_find_vendors_who_sell_an_item
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    assert_equal [@vendor1, @vendor3], @market.vendors_that_sell(@item1)
    assert_equal [@vendor2], @market.vendors_that_sell(@item4)
  end

  def test_market_can_sort_items
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    expected = [
      'Banana Nice Cream',
      'Peach',
      'Peach-Raspberry Nice Cream',
      'Tomato'
    ]

    assert_equal expected, @market.sorted_item_list
  end

  def test_market_can_get_total_inventory
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    expected = {
      @item1 => 100,
      @item2 => 7,
      @item4 => 50,
      @item3 => 25
    }

    assert_equal expected, @market.total_inventory
  end

  def test_market_can_sell_items
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    assert_equal false, @market.sell(@item1, 200)
    assert_equal false, @market.sell(@item5, 1)
    assert_equal true, @market.sell(@item4, 5)

    assert_equal 45, @vendor2.check_stock(@item4)
  end

  def test_market_decrements_more_than_one_vendor
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    assert_equal true, @market.sell(@item1, 40)

    assert_equal 0, @vendor1.check_stock(@item1)
    assert_equal 60, @vendor3.check_stock(@item1)
  end
end
